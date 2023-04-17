part of 'course_bloc.dart';

@immutable
abstract class CourseState {}

class CourseInitial extends CourseState {
  List<Object?> get props => [];
}
class CourseLoading extends CourseState {
  List<Object?> get props => [];
}
class CourseLoaded extends CourseState {
  final List<CourseModel> course;
  CourseLoaded(this.course);
  List<Object?> get props => [course];
}
class CourseErrorState extends CourseState {
  final String message;
  CourseErrorState(this.message);
  List<Object?> get props => [message];
}
class CourseEmptyState extends CourseState {
  List<Object?> get props => [];
}
