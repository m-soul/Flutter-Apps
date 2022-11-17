import 'dart:ui';

import 'package:first_app/modules/animation_test/cubit/cubit.dart';
import 'package:first_app/modules/animation_test/cubit/states.dart';
import 'package:first_app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnimationTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AnimationCubit(),
        child: BlocConsumer<AnimationCubit, AnimationStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.green,
              ),
              body: Column(
                children: [
                  defaultTextButton(
                      function: () {
                        if (AnimationCubit.get(context).opacity == 1) {
                          AnimationCubit.get(context).changeOpacity();
                        } else {
                          AnimationCubit.get(context).reverseOpacity();
                        }
                      },
                      text: 'Click to animate'),
                  if (state is! AnimationChangeOpacityDoneState)
                    AnimatedOpacity(
                      curve: Curves.fastLinearToSlowEaseIn,
                      onEnd: () {
                        AnimationCubit.get(context).changeOpacityDone();
                      },
                      duration: Duration(seconds: 1),
                      opacity: AnimationCubit.get(context).opacity,
                      child: Text(
                        'Hello',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  Text(
                    'New one here',
                    style: TextStyle(fontSize: 30),
                  )
                ],
              ),
            );
          },
        ));
  }
}
