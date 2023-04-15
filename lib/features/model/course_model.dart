import 'package:student_management/core/helper/database_helper.dart';

class CourseModel {
  final int? id;
  final String courseCode;
  final String courseName;
  final String facultyName;
  final int credit;
  CourseModel({
    this.id,
    required this.courseCode,
    required this.courseName,
    required this.facultyName,
    required this.credit,
  });

  factory CourseModel.fromLocalDB(Map<String, dynamic> json) => CourseModel(
        id: json[DatabaseHelper.columnId],
        courseCode: json[DatabaseHelper.columnCourseId],
        courseName: json[DatabaseHelper.columnCourseName],
        facultyName: json[DatabaseHelper.columnFacultyName],
        credit: json[DatabaseHelper.columnCredit],
      );

  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.columnCourseId: courseCode,
      DatabaseHelper.columnCourseName: courseName,
      DatabaseHelper.columnFacultyName: facultyName,
      DatabaseHelper.columnCredit: credit,
    };
  }
}
