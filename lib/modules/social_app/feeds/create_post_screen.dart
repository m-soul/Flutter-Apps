import 'package:first_app/Layout/social_app/cubit/cubit.dart';
import 'package:first_app/Layout/social_app/cubit/states.dart';
import 'package:first_app/shared/components/components.dart';
import 'package:first_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var createPostController = TextEditingController();
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Hero(
                tag: 'createPostHeroTag',
                child: SingleChildScrollView(
                  child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      margin: EdgeInsets.all(20.0),
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(
                                      Icons.arrow_back_ios,
                                      color: defaultColor,
                                    )),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Create a new post',
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.black87),
                                ),
                                Spacer(),
                                defaultTextButton(
                                    function: () {
                                      if (SocialCubit.get(context)
                                              .postPicture ==
                                          null) {
                                        SocialCubit.get(context).createPost(
                                            dateTime: DateTime.now().toString(),
                                            text: createPostController.text,
                                            context: context);
                                      } else {
                                        SocialCubit.get(context)
                                            .uploadPostImage(
                                                dateTime:
                                                    DateTime.now().toString(),
                                                text: createPostController.text,
                                                context: context);
                                      }
                                    },
                                    text: 'Post')
                              ]),
                            ),
                            if (state is SocialCreatePostLoadingState)
                              LinearProgressIndicator(),
                            if (state is SocialCreatePostLoadingState)
                              SizedBox(
                                height: 10,
                              ),
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    'https://scontent.fcai20-1.fna.fbcdn.net/v/t1.6435-9/191265440_2880459678859245_639479930688264519_n.jpg?_nc_cat=103&ccb=1-5&_nc_sid=e3f864&_nc_ohc=LhnsT6MZNFsAX-3Dlv3&_nc_ht=scontent.fcai20-1.fna&oh=d9504057def18a7e5ac7354e1664b07f&oe=616D14C7',
                                  ),
                                  radius: 25,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: TextFormField(
                                        controller: createPostController,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                            labelText: 'Write a post...',
                                            labelStyle: TextStyle(
                                                fontSize: 20,
                                                color: Colors.grey),
                                            border: InputBorder.none,
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.never),
                                      )),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 150,
                            ),
                            if (SocialCubit.get(context).postPicture != null)
                              Stack(
                                alignment: AlignmentDirectional.topEnd,
                                children: [
                                  Container(
                                    height: 140,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: FileImage(
                                                SocialCubit.get(context)
                                                    .postPicture!),
                                            fit: BoxFit.cover),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      radius: 20,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle),
                                        child: IconButton(
                                          iconSize: 20,
                                          onPressed: () {
                                            SocialCubit.get(context)
                                                .removePostImage();
                                          },
                                          icon: Icon(Icons.close),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
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
                                    onTap: () {
                                      SocialCubit.get(context).getPostImage();
                                    },
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
              ),
            ],
          );
        });
  }
}
