import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_management/features/model/course_model.dart';
import 'package:student_management/features/repository/student_repository.dart';

part 'course_event.dart';
part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final StudentRepository courseRepository;
  CourseBloc(this.courseRepository) : super(CourseInitial()) {
    on<CourseLoadEvent>((event, emit) async {
      try {
        emit(CourseLoading());
        final course = await courseRepository.getAllCourseList();
        if (course.isEmpty) {
          emit(CourseEmptyState());
        } else {
          emit(CourseLoaded(course));
        }
      } catch (e) {
        emit(CourseErrorState(e.toString()));
      }
    });
  }
}
