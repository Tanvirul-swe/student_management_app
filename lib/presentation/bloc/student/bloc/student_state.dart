part of 'student_bloc.dart';

@immutable
abstract class StudentState extends Equatable {}

class StudentInitial extends StudentState {
  @override
  List<Object?> get props => [];
}

class StudentLoading extends StudentState {
  @override
  List<Object?> get props => [];
}

class StudentLoaded extends StudentState {
  final List<StudentModel> student;
  StudentLoaded(this.student);
  @override
  List<Object?> get props => [student];
}

class StudentErrorState extends StudentState {
  final String message;
  StudentErrorState(this.message);
  @override
  List<Object?> get props => [message];
}
class StudentEmptyState extends StudentState {
  @override
  List<Object?> get props => [];
}
