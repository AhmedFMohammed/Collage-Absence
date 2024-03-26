import 'package:schoolattendance/repository/API/LocalServerAPI/APIdate/APIattendance.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../services/models/attendance.dart';

part 'attendance_event.dart';
part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  APIAttendance apiAttendance = APIAttendance();
  AttendanceBloc() : super(AttendanceInitial()) {
    on<AllAttendanceEvent>(_onAllAttendanceEvent);
    on<AddAttendanceEvent>(_onAddAttendanceEvent);
    on<FilterAttendanceEvent>(_onFilterAttendanceEvent);
    on<DeleteAttendanceEvent>(_onDeleteAttendanceEvent);
  }

  _onAllAttendanceEvent(
      AllAttendanceEvent event, Emitter<AttendanceState> emit) async {
    event.AttendanceList = await apiAttendance.getAttendance();
    emit(LoadedAttendanceState(AttendanceList: event.AttendanceList));
  }

  _onFilterAttendanceEvent(
      FilterAttendanceEvent event, Emitter<AttendanceState> emit) async {
    event.AttendanceList = await apiAttendance.getAttendance();
    event.AttendanceList =
        event.AttendanceList.where((e) => e.lessonId == event.lesson).toList();
    emit(LoadedAttendanceState(AttendanceList: event.AttendanceList));
  }

  _onAddAttendanceEvent(
      AddAttendanceEvent event, Emitter<AttendanceState> emit) async {
    final state = this.state;
    if (state is LoadedAttendanceState) {
      await apiAttendance.AddAttendance(event.Attendance);
      emit(LoadedAttendanceState(
          AttendanceList: List.from(state.AttendanceList)
            ..add(event.Attendance)));
    }
  }

  void _onDeleteAttendanceEvent(
      DeleteAttendanceEvent event, Emitter<AttendanceState> emit) async {
    final state = this.state;
    if (state is LoadedAttendanceState) {
      await apiAttendance.DeleteAttendance(event.Attendance);
      emit(LoadedAttendanceState(
          AttendanceList: List.from(state.AttendanceList)
            ..add(event.Attendance)));
    }
  }
}
