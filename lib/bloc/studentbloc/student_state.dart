part of 'student_bloc.dart';

abstract class StudentState extends Equatable {
  const StudentState();

  @override
  List<Object> get props => [];
}

class StudentInitial extends StudentState {}

class LoadingStudentState extends StudentState {}

class LoadedStudentState extends StudentState {
  late final List<StudentModel> StudentsList;
  LoadedStudentState({this.StudentsList = const <StudentModel>[]});

  @override
  List<Object> get props => [StudentsList];
}

class ErrorStudentState extends StudentState {
  String message;
  ErrorStudentState({required this.message});
}
