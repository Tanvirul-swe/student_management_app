part of 'student_bloc.dart';

@immutable
abstract class StudentEvent extends Equatable{
  const StudentEvent();
}
class StudentLoadEvent extends StudentEvent {
  @override
  List<Object?> get props => [];
}
