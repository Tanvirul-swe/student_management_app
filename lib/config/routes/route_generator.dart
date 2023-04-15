import 'package:flutter/material.dart';
import 'package:student_management/features/model/course_model.dart';
import 'package:student_management/features/model/student_model.dart';
import 'package:student_management/presentation/pages/course/course_create_insert_form.dart';
import 'package:student_management/presentation/pages/course/course_details.dart';
import 'package:student_management/presentation/pages/course/course_list.dart';
import 'package:student_management/presentation/pages/error_screen.dart';
import 'package:student_management/presentation/pages/student_data_insert_form.dart';
import 'package:student_management/presentation/pages/student_details.dart';
import 'package:student_management/presentation/pages/student_list.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/StudentList':
        return MaterialPageRoute(builder: (_) => const StudentList());
      case '/CourseCreateForm':
        return MaterialPageRoute(builder: (_) => const CourseCreateForm());

        case '/CourseDetails':
        return MaterialPageRoute(
            builder: (_) => CourseDetails(
                  model: args as CourseModel,
                ));
     case '/CourseList':
        return MaterialPageRoute(builder: (_) => const CourseList());
      case '/StudentDataInsertForm':
        return MaterialPageRoute(builder: (_) => const StudentDataInsertForm());
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
