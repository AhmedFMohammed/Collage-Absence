import 'package:schoolattendance/repository/API/LocalServerAPI/APIdate/APITeacher.dart';
import 'package:schoolattendance/services/models/teacher.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'teacher_event.dart';
part 'teacher_state.dart';

class TeacherBloc extends Bloc<TeacherEvent, TeacherState> {
  APITeacher _apiTeacher = APITeacher();
  TeacherBloc() : super(TeacherInitial()) {
    on<AllTeacherEvent>(_onAllTeacherEvent);
  }

  _onAllTeacherEvent(AllTeacherEvent event, Emitter<TeacherState> emit) async {
    event.TL = await _apiTeacher.GetTeachers();

    emit(LoadedTeacherState(TL: event.TL));
  }
}
