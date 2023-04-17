part of 'course_bloc.dart';

@immutable
abstract class CourseEvent {
  const CourseEvent();
}
class CourseLoadEvent extends CourseEvent {
  @override
  List<Object?> get props => [];
}
