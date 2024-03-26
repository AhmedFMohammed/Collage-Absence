part of 'attendance_bloc.dart';

abstract class AttendanceState extends Equatable {
  const AttendanceState();

  @override
  List<Object> get props => [];
}

class AttendanceInitial extends AttendanceState {}

class LoadedAttendanceState extends AttendanceState {
  late List<AttendanceModel> AttendanceList;
  LoadedAttendanceState({this.AttendanceList = const <AttendanceModel>[]});
  @override
  List<Object> get props => [AttendanceList];
}

class LoadingAttendanceState extends AttendanceState {}

class errorAttendanceState extends AttendanceState {}
