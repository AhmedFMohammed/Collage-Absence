part of 'attendance_bloc.dart';

abstract class AttendanceEvent extends Equatable {
  const AttendanceEvent();

  @override
  List<Object> get props => [];
}

class AllAttendanceEvent extends AttendanceEvent {
  late List<AttendanceModel> AttendanceList;
  AllAttendanceEvent({this.AttendanceList = const <AttendanceModel>[]});

  @override
  List<Object> get props => [AttendanceList];
}

class FilterAttendanceEvent extends AttendanceEvent {
  late List<AttendanceModel> AttendanceList;
  int lesson;
  FilterAttendanceEvent(
      {this.AttendanceList = const <AttendanceModel>[], required this.lesson});

  @override
  List<Object> get props => [AttendanceList, lesson];
}

class AddAttendanceEvent extends AttendanceEvent {
  late AttendanceModel Attendance;
  AddAttendanceEvent({required this.Attendance});

  @override
  List<Object> get props => [Attendance];
}

class DeleteAttendanceEvent extends AttendanceEvent {
  late AttendanceModel Attendance;
  DeleteAttendanceEvent({required this.Attendance});

  @override
  List<Object> get props => [Attendance];
}
