part of 'student_bloc.dart';

abstract class StudentEvent extends Equatable {
  const StudentEvent();

  @override
  List<Object> get props => [];
}

class AllStudentEvent extends StudentEvent {
  late List<StudentModel> StudentsList;
  AllStudentEvent({this.StudentsList = const <StudentModel>[]});
  @override
  List<Object> get props => [StudentsList];
}

class SearchStudentEvent extends StudentEvent {
  late List<StudentModel> StudentsList;
  String search;
  SearchStudentEvent(
      {this.StudentsList = const <StudentModel>[], required this.search});
  @override
  List<Object> get props => [StudentsList, search];
}

class AddStudentEvent extends StudentEvent {
  late StudentModel Student;
  AddStudentEvent({required this.Student});
  @override
  List<Object> get props => [Student];
}

class EditStudentEvent extends StudentEvent {
  late StudentModel Student;
  EditStudentEvent({required this.Student});
  @override
  List<Object> get props => [Student];
}

class DeleteStudentEvent extends StudentEvent {
  late StudentModel Student;
  DeleteStudentEvent({required this.Student});
  @override
  List<Object> get props => [Student];
}
