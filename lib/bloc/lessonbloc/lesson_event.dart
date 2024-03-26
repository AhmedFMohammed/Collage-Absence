part of 'lesson_bloc.dart';

abstract class LessonEvent extends Equatable {
  const LessonEvent();

  @override
  List<Object> get props => [];
}

class AllLessonEvent extends LessonEvent {
  late List<LessonModel> lessonList;
  AllLessonEvent({this.lessonList = const <LessonModel>[]});
  @override
  List<Object> get props => [lessonList];
}

class AddLessonEvent extends LessonEvent {
  late LessonModel lesson;
  AddLessonEvent({required this.lesson});
  @override
  List<Object> get props => [lesson];
}

class EditLessonEvent extends LessonEvent {
  late LessonModel lesson;
  EditLessonEvent({required this.lesson});
  @override
  List<Object> get props => [lesson];
}

class DeleteLessonEvent extends LessonEvent {
  late LessonModel lesson;
  DeleteLessonEvent({required this.lesson});
  @override
  List<Object> get props => [lesson];
}
