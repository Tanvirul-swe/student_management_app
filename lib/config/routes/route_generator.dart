import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_management/features/model/course_model.dart';
import 'package:student_management/features/model/student_model.dart';
import 'package:student_management/features/repository/student_repository.dart';
import 'package:student_management/presentation/pages/course/course_create_insert_form.dart';
import 'package:student_management/presentation/pages/course/course_details.dart';
import 'package:student_management/presentation/pages/course/course_list.dart';
import 'package:student_management/presentation/pages/course/update_course_info.dart';
import 'package:student_management/presentation/pages/error/error_screen.dart';
import 'package:student_management/presentation/pages/student/student_data_insert_form.dart';
import 'package:student_management/presentation/pages/student/student_details.dart';
import 'package:student_management/presentation/pages/student/student_list.dart';
import 'package:student_management/presentation/pages/student/update_student_info.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/StudentList':
        return MaterialPageRoute(
            builder: (_) => RepositoryProvider(
                  create: (context) => StudentRepository(),
                  child: const StudentList(),
                ));
      case '/CourseCreateForm':
        return MaterialPageRoute(builder: (_) => const CourseCreateForm());

      case '/CourseDetails':
        return MaterialPageRoute(
            builder: (_) => CourseDetails(
                  model: args as CourseModel,
                ));
      case '/CourseList':
        return MaterialPageRoute(
            builder: (_) =>  RepositoryProvider(
                  create: (context) => StudentRepository(),
                  child: const CourseList(),
                ));
      case '/StudentDataInsertForm':
        return MaterialPageRoute(builder: (_) => const StudentDataInsertForm());
      case '/UpdateStudentInfo':
        return MaterialPageRoute(
            builder: (_) => UpdateStudentInfo(
                  localId: args as int,
                ));
      case '/UpdateCourseInfo':
        return MaterialPageRoute(
            builder: (_) => UpdateCourseInfo(
                  localId: args as int,
                ));
      case '/StudentDetails':
        return MaterialPageRoute(
            builder: (_) => StudentDetails(
                  model: args as StudentModel,
                ));

      default:
        return MaterialPageRoute(builder: (_) => const Error404Screen());
    }
  }
}
