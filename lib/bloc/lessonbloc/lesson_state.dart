part of 'lesson_bloc.dart';

abstract class LessonState extends Equatable {
  const LessonState();

  @override
  List<Object> get props => [];
}

class LessonInitial extends LessonState {}

class LoadingLessonState extends LessonState {}

class LoadedLessonState extends LessonState {
  late final List<LessonModel> LessonsList;
  LoadedLessonState({this.LessonsList = const <LessonModel>[]});

  @override
  List<Object> get props => [LessonsList];
}

class ErrorLessonState extends LessonState {
  String message;
  ErrorLessonState({required this.message});
}
