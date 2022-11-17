import 'package:bloc/bloc.dart';
import 'package:first_app/modules/animation_test/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnimationCubit extends Cubit<AnimationStates> {
  AnimationCubit() : super(AnimationInitialState());

  static AnimationCubit get(context) => BlocProvider.of(context);

  double opacity = 1;
  void changeOpacity() {
    opacity = 0;
    emit(AnimationChangeOpacityState());
  }

  void reverseOpacity() {
    opacity = 1;
    emit(AnimationChangeOpacityState());
  }

  void changeOpacityDone() {
    emit(AnimationChangeOpacityDoneState());
  }
}
