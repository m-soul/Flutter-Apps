import 'package:first_app/Layout/social_app/cubit/cubit.dart';
import 'package:first_app/Layout/social_app/cubit/states.dart';
import 'package:first_app/models/social_app/post_model.dart';
import 'package:first_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialCommentScreen extends StatelessWidget {
  var commentController = TextEditingController();
  PostModel model;
  int index;
  SocialCommentScreen({required this.model, required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Hero(
              tag: 'commentHero${SocialCubit.get(context).postId[index]}',
              child: SingleChildScrollView(
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 200,
                    width: 400,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[300]),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                  color: defaultColor,
                                  padding: EdgeInsets.only(
                                      top: 8, left: 8, bottom: 0, right: 8),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(Icons.arrow_back_ios)),
                              Spacer(),
                              IconButton(
                                  color: defaultColor,
                                  padding: EdgeInsets.only(
                                      top: 8, right: 8, left: 0, bottom: 0),
                                  onPressed: () {
                                    SocialCubit.get(context).commentPost(
                                        SocialCubit.get(context).postId[index],
                                        commentController.text,
                                        context);
                                  },
                                  icon: Icon(Icons.send))
                            ],
                          ),
                          TextFormField(
                            controller: commentController,
                            maxLines: 2,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'Write a comment...',
                              labelStyle:
                                  TextStyle(fontSize: 20, color: Colors.grey),
                              border: InputBorder.none,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
