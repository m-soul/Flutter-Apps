import 'package:first_app/Layout/social_app/cubit/cubit.dart';
import 'package:first_app/Layout/social_app/cubit/states.dart';
import 'package:first_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {}, icon: Icon(Icons.notifications_rounded)),
              IconButton(onPressed: () {}, icon: Icon(Icons.search_rounded)),
            ],
            title: Text(
              cubit.titles[cubit.currentIndex],
              style: TextStyle(fontSize: 30, color: Colors.black),
            ),
            backgroundColor: defaultColor,
          ),
          body: SocialCubit.get(context).userModel != null
              ? cubit.screens[cubit.currentIndex]
              : Center(child: CircularProgressIndicator()),
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNav(index);
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_rounded), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.chat_rounded), label: 'Chats'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person_rounded), label: 'User'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'Settings'),
              ]),
        );
      },
    );
  }
}
