import 'package:first_app/Layout/social_app/cubit/cubit.dart';
import 'package:first_app/Layout/social_app/cubit/states.dart';
import 'package:first_app/shared/components/components.dart';
import 'package:first_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialUploadProfilePictureLoadingState) {
          SocialCubit.get(context).isProfilePictureLoading = true;
        } else if (state is SocialUploadCoverPictureLoadingState) {
          SocialCubit.get(context).isCoverPictureLoading = true;
        }
      },
      builder: (context, state) {
        ImageProvider? profileImage;
        ImageProvider? coverImage;
        var userModel = SocialCubit.get(context).userModel;
        nameController.text = userModel!.name;
        bioController.text = userModel.bio;
        phoneController.text = userModel.phone;
        var profilePicture = SocialCubit.get(context).profilePicture;
        var coverPicture = SocialCubit.get(context).coverPicture;
        if (profilePicture == null) {
          profileImage = NetworkImage(userModel.image);
        } else {
          profileImage = FileImage(profilePicture);
        }
        if (coverPicture == null) {
          coverImage = NetworkImage(userModel.cover);
        } else {
          coverImage = FileImage(coverPicture);
        }
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_rounded),
              color: defaultColor,
            ),
            title: Text(
              'Update your profile',
              style: TextStyle(fontSize: 26, color: Colors.black54),
            ),
            titleSpacing: 10,
            actions: [
              defaultTextButton(
                  function: () {
                    SocialCubit.get(context).updateUser(
                        name: nameController.text,
                        bio: bioController.text,
                        phone: phoneController.text);
                  },
                  text: 'Update'),
              SizedBox(
                width: 15,
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SocialCubit.get(context).isProfilePictureLoading ||
                          SocialCubit.get(context).isCoverPictureLoading
                      ? LinearProgressIndicator()
                      : Container(),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 190,
                    child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Container(
                                  height: 140,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: coverImage, fit: BoxFit.cover),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          topRight: Radius.circular(5))),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 20,
                                    child: IconButton(
                                        iconSize: 20,
                                        onPressed: () {
                                          SocialCubit.get(context)
                                              .getCoverImage()
                                              .then((value) {
                                            SocialCubit.get(context)
                                                .uploadCoverPicture();
                                          });
                                        },
                                        icon: Icon(Icons.add_a_photo_rounded)),
                                  ),
                                )
                              ],
                            ),
                            alignment: AlignmentDirectional.topCenter,
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 64,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  backgroundImage: profileImage,
                                  radius: 60,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 16,
                                  child: IconButton(
                                      iconSize: 16,
                                      onPressed: () {
                                        SocialCubit.get(context)
                                            .getProfileImage()
                                            .then((value) {
                                          SocialCubit.get(context)
                                              .uploadProfilePicture();
                                        });
                                      },
                                      icon: Icon(Icons.add_a_photo_rounded)),
                                ),
                              )
                            ],
                          )
                        ]),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  defaultFormField(
                      controller: nameController,
                      type: TextInputType.text,
                      validateMsg: 'name must not be empty',
                      label: 'Name',
                      prefix: Icons.person_rounded),
                  SizedBox(
                    height: 10,
                  ),
                  defaultFormField(
                      controller: bioController,
                      type: TextInputType.text,
                      validateMsg: 'bio must not be empty',
                      label: 'bio',
                      prefix: Icons.edit),
                  SizedBox(
                    height: 10,
                  ),
                  defaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validateMsg: 'phone number must not be empty',
                      label: 'phone',
                      prefix: Icons.phone_android_rounded),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
