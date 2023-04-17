import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_management/features/model/student_model.dart';
import 'package:student_management/features/repository/student_repository.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final StudentRepository studentRepository;
  StudentBloc(this.studentRepository) : super(StudentInitial()) {
    on<StudentLoadEvent>((event, emit) async {
      try {
        emit(StudentLoading());
        final student = await studentRepository.getAllStudentList();
        if (student.isEmpty) {
          emit(StudentEmptyState());
        } else {
          emit(StudentLoaded(student));
        }
      } catch (e) {
        emit(StudentErrorState(e.toString()));
      }
    });
  }
}
