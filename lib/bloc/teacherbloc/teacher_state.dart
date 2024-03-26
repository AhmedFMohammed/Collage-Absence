part of 'teacher_bloc.dart';

abstract class TeacherState extends Equatable {
  const TeacherState();

  @override
  List<Object> get props => [];
}

class TeacherInitial extends TeacherState {}

class LoadedTeacherState extends TeacherState {
  List<TeacherModel> TL;
  LoadedTeacherState({this.TL = const <TeacherModel>[]});
  @override
  List<Object> get props => [TL];
}
