import 'package:first_app/Layout/social_app/social_layout.dart';
import 'package:first_app/modules/social_app/register/social_register_screen.dart';
import 'package:first_app/modules/social_app/social_login/cubit/cubit.dart';
import 'package:first_app/modules/social_app/social_login/cubit/states.dart';
import 'package:first_app/shared/components/components.dart';
import 'package:first_app/shared/components/constants.dart';
import 'package:first_app/shared/networks/local/cache_helper.dart';
import 'package:first_app/shared/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
          listener: (context, state) {
        if (state is SocialLoginErrorState) {
          SocialLoginCubit.get(context).loginErrorMessage = state.error;
        }
        if (state is SocialLoginSuccessState) {
          SocialLoginCubit.get(context).deleteErrorToast();
          uId = state.uId;
          CacheHelper.saveData(key: 'uId', value: state.uId)
              .then((value) => navigateAndFinish(context, SocialLayout()));
        }
      }, builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 60.0,
                      ),
                    ),
                    Text(
                      'Login now to communicate with millions of users',
                      style: TextStyle(fontSize: 25.0, color: defaultColor),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validateMsg: 'please enter your email address',
                        label: 'Email Address',
                        prefix: Icons.email_outlined),
                    SizedBox(
                      height: 15.0,
                    ),
                    defaultFormField(
                      controller: passwordController,
                      type: TextInputType.visiblePassword,
                      suffix: SocialLoginCubit.get(context).suffix,
                      onSubmit: (value) {
                        if (formKey.currentState!.validate()) {
                          SocialLoginCubit.get(context).userLogin(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                        }
                      },
                      isPassword: SocialLoginCubit.get(context).isPassword,
                      suffixPressed: () {
                        SocialLoginCubit.get(context)
                            .changePasswordVisibility();
                      },
                      validateMsg: 'password is too short',
                      label: 'Password',
                      prefix: Icons.lock_outline,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    if (SocialLoginCubit.get(context).loginErrorMessage != null)
                      Text(
                        SocialLoginCubit.get(context).loginErrorMessage!,
                        style: TextStyle(fontSize: 20.0, color: Colors.red),
                      ),
                    state is! SocialLoginLoadingState
                        ? defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                SocialLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            text: 'LOGIN')
                        : Center(child: CircularProgressIndicator()),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account?',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        defaultTextButton(
                            function: () {
                              navigateTo(context, SocialRegisterScreen());
                            },
                            text: 'register now')
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
