part of 'teacher_bloc.dart';

abstract class TeacherEvent extends Equatable {
  const TeacherEvent();

  @override
  List<Object> get props => [];
}

class AllTeacherEvent extends TeacherEvent {
  List<TeacherModel> TL;
  AllTeacherEvent({this.TL = const <TeacherModel>[]});
  @override
  List<Object> get props => [TL];
}
