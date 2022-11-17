import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/models/social_app/social_user_model.dart';
import 'package:first_app/modules/social_app/register/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);
  void createUser(
      {required String name,
      required String email,
      required String password,
      required String phone,
      required String uId}) {
    SocialUserModel model = SocialUserModel(
      name: name,
      bio: 'write your bio',
      email: email,
      phone: phone,
      uId: uId,
      cover:
          'https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png',
      image:
          'https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png',
      password: password,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) => emit(SocialCreateUserSuccessState()))
        .catchError((error) {
      print(error);
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(SocialRegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      createUser(
          name: name,
          email: email,
          password: password,
          phone: phone,
          uId: value.user!.uid);
    }).catchError((error) {
      print(error);
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(SocialRegisterChangePasswordVisibilityState());
  }
}
