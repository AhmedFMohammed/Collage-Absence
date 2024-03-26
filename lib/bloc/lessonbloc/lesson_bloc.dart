import 'package:schoolattendance/repository/API/LocalServerAPI/APIdate/APIlesson.dart';
import 'package:schoolattendance/services/models/lesson.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'lesson_event.dart';
part 'lesson_state.dart';

class LessonBloc extends Bloc<LessonEvent, LessonState> {
  APILesson _apiLesson = APILesson();
  LessonBloc() : super(LessonInitial()) {
    on<AllLessonEvent>(_onAllLessonEvent);
    on<AddLessonEvent>(_onAddLessonEvent);
    on<EditLessonEvent>(_onEditLessonEvent);
    on<DeleteLessonEvent>(_onDeleteLessonEvent);
  }

  void _onAllLessonEvent(
      AllLessonEvent event, Emitter<LessonState> emit) async {
    event.lessonList = await _apiLesson.getLesson();
    emit(LoadedLessonState(LessonsList: event.lessonList));
  }

  void _onAddLessonEvent(
      AddLessonEvent event, Emitter<LessonState> emit) async {
    final state = this.state;
    if (state is LoadedLessonState) {
      await _apiLesson.AddLesson(event.lesson);
      emit(LoadedLessonState(
          LessonsList: List.from(state.LessonsList)..add(event.lesson)));
    }
  }

  void _onEditLessonEvent(
      EditLessonEvent event, Emitter<LessonState> emit) async {
    final state = this.state;
    if (state is LoadedLessonState) {
      await _apiLesson.EditLesson(event.lesson);
      emit(LoadedLessonState(LessonsList: List.from(state.LessonsList)));
    }
  }

  void _onDeleteLessonEvent(
      DeleteLessonEvent event, Emitter<LessonState> emit) async {
    final state = this.state;
    if (state is LoadedLessonState) {
      await _apiLesson.DeleteLesson(event.lesson);
      emit(LoadedLessonState(
          LessonsList: List.from(state.LessonsList)..remove(event.lesson)));
    }
  }
}
