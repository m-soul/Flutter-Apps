import 'package:first_app/Layout/social_app/cubit/cubit.dart';
import 'package:first_app/Layout/social_app/cubit/states.dart';
import 'package:first_app/modules/social_app/settings/edit_profile_screen.dart';
import 'package:first_app/modules/social_app/social_login/social_login_screen.dart';
import 'package:first_app/shared/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialSettingsScreen extends StatelessWidget {
  const SocialSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 190,
                child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        child: Container(
                          height: 140,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(userModel!.cover),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5))),
                        ),
                        alignment: AlignmentDirectional.topCenter,
                      ),
                      CircleAvatar(
                        radius: 64,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            userModel.image,
                          ),
                          radius: 60,
                        ),
                      )
                    ]),
              ),
              Text(
                userModel.name,
                style: TextStyle(fontSize: 24),
              ),
              Text(
                userModel.bio,
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '100',
                              style: TextStyle(fontSize: 24),
                            ),
                            Text(
                              'Posts',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.grey),
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '360',
                              style: TextStyle(fontSize: 24),
                            ),
                            Text(
                              'Friends',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.grey),
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '600',
                              style: TextStyle(fontSize: 24),
                            ),
                            Text(
                              'Followers',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.grey),
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '400',
                              style: TextStyle(fontSize: 24),
                            ),
                            Text(
                              'Following',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.grey),
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: defaultButton(
                          function: () {
                            navigateTo(context, EditProfileScreen());
                          },
                          text: 'Edit Profile'))
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                      child: defaultButton(
                          function: () {
                            SocialCubit.get(context)
                                .logout(context, SocialLoginScreen());
                          },
                          text: 'Log out'))
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
