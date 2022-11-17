import 'package:first_app/Layout/shop_app/shop_layout.dart';
import 'package:first_app/modules/shop_app/Login/cubit/cubit.dart';
import 'package:first_app/modules/shop_app/Login/cubit/states.dart';
import 'package:first_app/modules/shop_app/register/register_screen.dart';
import 'package:first_app/shared/components/components.dart';
import 'package:first_app/shared/components/constants.dart';
import 'package:first_app/shared/networks/local/cache_helper.dart';
import 'package:first_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status!) {
              print(state.loginModel.message);
              print(state.loginModel.data!.token);

              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token,
              ).then((value) {
                token = state.loginModel.data!.token;

                navigateAndFinish(
                  context,
                  ShopLayout(),
                );
              });
            } else {
              print(state.loginModel.message);

              // showToast(
              //   text: state.loginModel.message!,
              //   color: Colors.red,
              //   context: context,
              // );
            }
          }
        },
        builder: (context, state) => Scaffold(
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
                      'Login now to browse our hot offers',
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
                      suffix: ShopLoginCubit.get(context).suffix,
                      onSubmit: (value) {
                        if (formKey.currentState!.validate()) {
                          ShopLoginCubit.get(context).userLogin(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                        }
                      },
                      isPassword: ShopLoginCubit.get(context).isPassword,
                      suffixPressed: () {
                        ShopLoginCubit.get(context).changePasswordVisibility();
                      },
                      validateMsg: 'password is too short',
                      label: 'Password',
                      prefix: Icons.lock_outline,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    state is! ShopLoginLoadingState
                        ? defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                ShopLoginCubit.get(context).userLogin(
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
                              navigateTo(context, ShopRegisterScreen());
                            },
                            text: 'register now')
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
