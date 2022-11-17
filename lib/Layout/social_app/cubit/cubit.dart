import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/Layout/social_app/cubit/states.dart';
import 'package:first_app/models/social_app/message_model.dart';
import 'package:first_app/models/social_app/post_model.dart';
import 'package:first_app/models/social_app/social_user_model.dart';
import 'package:first_app/modules/social_app/chats/chats_screen.dart';
import 'package:first_app/modules/social_app/feeds/feeds_screen.dart';
import 'package:first_app/modules/social_app/settings/settings_screen.dart';
import 'package:first_app/modules/social_app/users/users_screen.dart';
import 'package:first_app/shared/components/components.dart';
import 'package:first_app/shared/components/constants.dart';
import 'package:first_app/shared/networks/local/cache_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());
  static SocialCubit get(context) => BlocProvider.of(context);
  SocialUserModel? userModel;
  bool isProfilePictureLoading = false;
  bool isCoverPictureLoading = false;

  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = SocialUserModel.fromJson(value.data());
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    UsersScreen(),
    SocialSettingsScreen()
  ];

  List<String> titles = [
    'Home',
    'Chats',
    'Users',
    'Settings',
  ];

  void changeBottomNav(int index) {
    if (index == 1) {
      getUsers();
    }
    currentIndex = index;
    emit(SocialBottomNavState());
  }

  File? profilePicture;
  var profilePicker = ImagePicker();
  Future<void> getProfileImage() async {
    final XFile? image =
        await profilePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      this.profilePicture = File(image.path);
      emit(SocialProfilePicturePickedSuccessState());
    } else {
      print('no image selected');
      emit(SocialProfilePicturePickedErrorState());
    }
  }

  File? coverPicture;
  var coverPicker = ImagePicker();
  Future<void> getCoverImage() async {
    final XFile? image =
        await coverPicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      this.coverPicture = File(image.path);
      emit(SocialCoverPicturePickedSuccessState());
    } else {
      print('no image selected');
      emit(SocialCoverPicturePickedErrorState());
    }
  }

  String? profilePictureUrl;
  void uploadProfilePicture() {
    emit(SocialUploadProfilePictureLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profilePicture!.path).pathSegments.last}')
        .putFile(profilePicture!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        profilePictureUrl = value;
        emit(SocialUploadProfilePictureSuccessState());
        isProfilePictureLoading = false;
      }).catchError((error) {
        emit(SocialUploadProfilePictureErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfilePictureErrorState());
    });
  }

  String? coverPictureUrl;
  void uploadCoverPicture() {
    emit(SocialUploadCoverPictureLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverPicture!.path).pathSegments.last}')
        .putFile(coverPicture!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        coverPictureUrl = value;
        emit(SocialUploadCoverPictureSuccessState());
        isCoverPictureLoading = false;
      }).catchError((error) {
        emit(SocialUploadCoverPictureErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverPictureErrorState());
    });
  }

  void updateUser(
      {required String name, required String bio, required String phone}) {
    SocialUserModel model = SocialUserModel(
      email: userModel!.email,
      password: userModel!.password,
      isEmailVerified: userModel!.isEmailVerified,
      name: name,
      bio: bio,
      phone: phone,
      uId: userModel!.uId,
      cover: coverPictureUrl != null
          ? coverPictureUrl.toString()
          : userModel!.cover,
      image: profilePictureUrl != null
          ? profilePictureUrl.toString()
          : userModel!.image,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUserUpdateErrorState());
    });
  }

  File? postPicture;
  var postPicker = ImagePicker();
  Future<void> getPostImage() async {
    final XFile? image =
        await postPicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      this.postPicture = File(image.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('no image selected');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void removePostImage() {
    postPicture = null;
    emit(SocialRemovePostImageState());
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
    required BuildContext context,
  }) {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postPicture!.path).pathSegments.last}')
        .putFile(postPicture!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(
            dateTime: dateTime, text: text, postImage: value, context: context);
        emit(SocialCreatePostSuccessState());
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void createPost(
      {required String dateTime,
      required String text,
      String postImage = '',
      required BuildContext context}) {
    PostModel model = PostModel(
        name: userModel!.name,
        uId: userModel!.uId,
        image: userModel!.image,
        dateTime: dateTime,
        text: text,
        postImage: postImage);
    emit(SocialCreatePostLoadingState());

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
      Navigator.pop(context);
      postPicture = null;
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postId = [];
  List<int> likes = [];
  List<int> commentsNumber = [];
  void getPosts() {
    emit(SocialGetPostsLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((likesCollection) {
          element.reference
              .collection('comments')
              .get()
              .then((commentsCollection) {
            likes.add(likesCollection.docs.length);
            commentsNumber.add(commentsCollection.docs.length);
            postId.add(element.id);
            posts.add(PostModel.fromJson(element.data()));
            emit(SocialGetPostsSuccessState());
          }).catchError((error) {
            emit(SocialGetPostsErrorState(error.toString()));
          });
        }).catchError((error) {
          emit(SocialGetPostsErrorState(error.toString()));
        });
      });
    }).catchError((error) {
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({'like': true}).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState());
    });
  }

  void commentPost(String postId, String comment, context) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(userModel!.uId)
        .set({'comment': comment}).then((value) {
      Navigator.pop(context);
      emit(SocialCommentPostSuccessState());
    }).catchError((error) {
      emit(SocialCommentPostErrorState());
    });
  }

  List<SocialUserModel> users = [];

  void getUsers() {
    if (users.length == 0)
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != userModel!.uId)
            users.add(SocialUserModel.fromJson(element.data()));
        });

        emit(SocialGetAllUsersSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialGetAllUsersErrorState(error.toString()));
      });
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    MessageModel model = MessageModel(
      text: text,
      senderId: userModel!.uId,
      receiverId: receiverId,
      dateTime: dateTime,
    );

    // set my chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });

    // set receiver chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessages({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];

      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });

      emit(SocialGetMessagesSuccessState());
    });
  }

  void logout(context, widget) {
    navigateAndFinish(context, widget);
    CacheHelper.saveData(key: 'uId', value: null);
    emit(SocialLogOutSuccessState());
  }
}
