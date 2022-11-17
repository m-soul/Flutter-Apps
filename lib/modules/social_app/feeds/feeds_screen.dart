import 'package:first_app/Layout/social_app/cubit/cubit.dart';
import 'package:first_app/Layout/social_app/cubit/states.dart';
import 'package:first_app/models/social_app/post_model.dart';
import 'package:first_app/modules/social_app/feeds/comment_screen.dart';
import 'package:first_app/modules/social_app/feeds/create_post_screen.dart';
import 'package:first_app/shared/components/components.dart';
import 'package:first_app/shared/components/constants.dart';
import 'package:first_app/shared/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return SocialCubit.get(context).posts.length > 0 &&
                  SocialCubit.get(context).userModel != null
              ? SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Hero(
                        tag: 'createPostHeroTag',
                        child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            margin: EdgeInsets.all(8.0),
                            elevation: 10,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          SocialCubit.get(context)
                                              .userModel!
                                              .image,
                                        ),
                                        radius: 25,
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Expanded(
                                        child: InkWell(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Text(
                                              'Write a post...',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                CreatePostRoute(
                                                    builder: (context) =>
                                                        CreatePostScreen()));
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15.0),
                                    child: Container(
                                      height: 1,
                                      color: Colors.grey[300],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.videocam_rounded,
                                                color: defaultColor,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                'Video',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              )
                                            ],
                                          ),
                                          onTap: () {},
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Container(
                                          width: 2,
                                          height: 20,
                                          color: Colors.grey[300],
                                        ),
                                      ),
                                      Expanded(
                                        child: InkWell(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.add_a_photo_rounded,
                                                color: defaultColor,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                'Photo',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              )
                                            ],
                                          ),
                                          onTap: () {},
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Container(
                                          width: 2,
                                          height: 20,
                                          color: Colors.grey[300],
                                        ),
                                      ),
                                      Expanded(
                                          child: InkWell(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.keyboard_voice_rounded,
                                              color: defaultColor,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              'Voice',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            )
                                          ],
                                        ),
                                        onTap: () {},
                                      ))
                                    ],
                                  )
                                ],
                              ),
                            )),
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => buildPostItem(context,
                            SocialCubit.get(context).posts[index], index),
                        itemCount: SocialCubit.get(context).posts.length,
                        separatorBuilder: (context, index) => SizedBox(
                          height: 8,
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      )
                    ],
                  ),
                )
              : Center(child: CircularProgressIndicator());
        });
  }

  Widget buildPostItem(context, PostModel model, index) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      model.image,
                    ),
                    radius: 25,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              model.name,
                              style: TextStyle(fontSize: 20, height: 1.3),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.check_circle_rounded,
                              size: 16,
                              color: defaultColor,
                            )
                          ],
                        ),
                        Text(
                          model.dateTime,
                          style: TextStyle(
                              fontSize: 16, color: Colors.grey, height: 1.1),
                        )
                      ],
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz))
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Container(
                  height: 1,
                  color: Colors.grey[300],
                ),
              ),
              if (model.text != '')
                Text(
                  model.text,
                  style: TextStyle(fontSize: 24, height: 1.2),
                ),
              // Container(
              //   width: double.infinity,
              //   child: Wrap(
              //     children: [
              //       Container(
              //         height: 20,
              //         child: MaterialButton(
              //           onPressed: () {},
              //           minWidth: 1,
              //           padding: EdgeInsets.zero,
              //           child: Text(
              //             '#Gay',
              //             style: TextStyle(color: defaultColor, fontSize: 20),
              //           ),
              //         ),
              //       ),
              //       Container(
              //         height: 20,
              //         child: MaterialButton(
              //           onPressed: () {},
              //           minWidth: 1,
              //           padding: EdgeInsets.zero,
              //           child: Text(
              //             '#Gay',
              //             style: TextStyle(color: defaultColor, fontSize: 20),
              //           ),
              //         ),
              //       ),
              //       Container(
              //         height: 20,
              //         child: MaterialButton(
              //           onPressed: () {},
              //           minWidth: 1,
              //           padding: EdgeInsets.zero,
              //           child: Text(
              //             '#Gay',
              //             style: TextStyle(color: defaultColor, fontSize: 20),
              //           ),
              //         ),
              //       ),
              //       Container(
              //         height: 20,
              //         child: MaterialButton(
              //           onPressed: () {},
              //           minWidth: 1,
              //           padding: EdgeInsets.zero,
              //           child: Text(
              //             '#Gay',
              //             style: TextStyle(color: defaultColor, fontSize: 20),
              //           ),
              //         ),
              //       ),
              //       Container(
              //         height: 20,
              //         child: MaterialButton(
              //           onPressed: () {},
              //           minWidth: 1,
              //           padding: EdgeInsets.zero,
              //           child: Text(
              //             '#Gay',
              //             style: TextStyle(color: defaultColor, fontSize: 20),
              //           ),
              //         ),
              //       ),
              //       Container(
              //         height: 20,
              //         child: MaterialButton(
              //           onPressed: () {},
              //           minWidth: 1,
              //           padding: EdgeInsets.zero,
              //           child: Text(
              //             '#Gay',
              //             style: TextStyle(color: defaultColor, fontSize: 20),
              //           ),
              //         ),
              //       ),
              //       Container(
              //         height: 20,
              //         child: MaterialButton(
              //           onPressed: () {},
              //           minWidth: 1,
              //           padding: EdgeInsets.zero,
              //           child: Text(
              //             '#Gay',
              //             style: TextStyle(color: defaultColor, fontSize: 20),
              //           ),
              //         ),
              //       ),
              //       Container(
              //         height: 20,
              //         child: MaterialButton(
              //           onPressed: () {},
              //           minWidth: 1,
              //           padding: EdgeInsets.zero,
              //           child: Text(
              //             '#Gay',
              //             style: TextStyle(color: defaultColor, fontSize: 20),
              //           ),
              //         ),
              //       ),
              //       Container(
              //         height: 20,
              //         child: MaterialButton(
              //           onPressed: () {},
              //           minWidth: 1,
              //           padding: EdgeInsets.zero,
              //           child: Text(
              //             '#Gay',
              //             style: TextStyle(color: defaultColor, fontSize: 20),
              //           ),
              //         ),
              //       ),
              //       Container(
              //         height: 20,
              //         child: MaterialButton(
              //           onPressed: () {},
              //           minWidth: 1,
              //           padding: EdgeInsets.zero,
              //           child: Text(
              //             '#Gay',
              //             style: TextStyle(color: defaultColor, fontSize: 20),
              //           ),
              //         ),
              //       ),
              //       Container(
              //         height: 20,
              //         child: MaterialButton(
              //           onPressed: () {},
              //           minWidth: 1,
              //           padding: EdgeInsets.zero,
              //           child: Text(
              //             '#Gay',
              //             style: TextStyle(color: defaultColor, fontSize: 20),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              if (model.postImage != '')
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Container(
                    height: 140,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(model.postImage.toString()),
                            fit: BoxFit.fill),
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.favorite_rounded,
                              color: defaultColor,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${SocialCubit.get(context).likes[index]}',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.chat_bubble,
                              color: defaultColor,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${SocialCubit.get(context).commentsNumber[index]}',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
              Container(
                height: 1,
                color: Colors.grey[300],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              SocialCubit.get(context).userModel!.image),
                          radius: 18,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: InkWell(
                            child: Hero(
                              tag:
                                  'commentHero${SocialCubit.get(context).postId[index]}',
                              child: Material(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.grey[300]),
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10,
                                          left: 10,
                                          top: 5,
                                          bottom: 5),
                                      child: Text(
                                        'Write a comment...',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.grey),
                                      )),
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  CommentRoute(
                                      builder: (context) => SocialCommentScreen(
                                          model: model, index: index)));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    child: Row(
                      children: [
                        Icon(
                          Icons.favorite_border_rounded,
                          color: defaultColor,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Like',
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        )
                      ],
                    ),
                    onTap: () {
                      SocialCubit.get(context)
                          .likePost(SocialCubit.get(context).postId[index]);
                    },
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  InkWell(
                    child: Row(
                      children: [
                        Icon(
                          Icons.share_rounded,
                          color: defaultColor,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Share',
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        )
                      ],
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
