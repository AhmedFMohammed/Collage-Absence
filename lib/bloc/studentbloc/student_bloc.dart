import 'package:schoolattendance/repository/API/LocalServerAPI/APIdate/APIstudent.dart';
import 'package:schoolattendance/services/models/student.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  APIStudent _apiStudent = APIStudent();
  StudentBloc() : super(StudentInitial()) {
    on<AllStudentEvent>(_onAllStudentEvent);
    on<SearchStudentEvent>(_onSearchStudentEvent);
    on<AddStudentEvent>(_onAddStudentEvent);
    on<EditStudentEvent>(_onEditStudentEvent);
    on<DeleteStudentEvent>(_onDeleteStudentEvent);
  }

  void _onAllStudentEvent(
      AllStudentEvent event, Emitter<StudentState> emit) async {
    event.StudentsList = await _apiStudent.getStudent();
    emit(LoadedStudentState(StudentsList: event.StudentsList));
  }

  void _onSearchStudentEvent(
      SearchStudentEvent event, Emitter<StudentState> emit) async {
    event.StudentsList = await _apiStudent.getStudent();
    event.StudentsList = List.from(event.StudentsList.where(
      (e) => e.studentName!.toLowerCase().contains(event.search.toLowerCase()),
    ));
    print(event.StudentsList);
    emit(LoadedStudentState(StudentsList: event.StudentsList));
  }

  void _onAddStudentEvent(
      AddStudentEvent event, Emitter<StudentState> emit) async {
    final state = this.state;
    if (state is LoadedStudentState) {
      await _apiStudent.AddStudent(event.Student);
      emit(LoadedStudentState(
          StudentsList: List.from(state.StudentsList)..add(event.Student)));
    }
  }

  void _onEditStudentEvent(
      EditStudentEvent event, Emitter<StudentState> emit) async {
    final state = this.state;
    if (state is LoadedStudentState) {
      await _apiStudent.EditStudent(event.Student);
      emit(LoadedStudentState(StudentsList: List.from(state.StudentsList)));
    }
  }

  void _onDeleteStudentEvent(
      DeleteStudentEvent event, Emitter<StudentState> emit) async {
    final state = this.state;
    if (state is LoadedStudentState) {
      await _apiStudent.DeleteStudent(event.Student);
      emit(LoadedStudentState(
          StudentsList: List.from(state.StudentsList)..remove(event.Student)));
    }
  }
}
