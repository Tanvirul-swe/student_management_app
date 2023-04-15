import 'package:student_management/core/helper/database_helper.dart';

class StudentModel {
  final int? id;
  final String studentid;
  final String name;
  final String fathername;
  final String mobilenumber;
  final int dateofbirth;
  final int classNo;
  final String course;
  StudentModel({
    this.id,
    required this.studentid,
    required this.name,
    required this.fathername,
    required this.mobilenumber,
    required this.dateofbirth,
    required this.classNo,
    required this.course,
  });

  factory StudentModel.fromLocalDB(Map<String, dynamic> json) => StudentModel(
        id: json[DatabaseHelper.columnId],
        studentid: json[DatabaseHelper.columnStudentId],
        name: json[DatabaseHelper.columnName],
        fathername: json[DatabaseHelper.columnFatherName],
        mobilenumber: json[DatabaseHelper.columnMobileNumber],
        dateofbirth: json[DatabaseHelper.columnDateOfBirth],
        classNo: json[DatabaseHelper.columnClass],
        course: json[DatabaseHelper.columnCourse],
      );

  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.columnStudentId: studentid,
      DatabaseHelper.columnName: name,
      DatabaseHelper.columnFatherName: fathername,
      DatabaseHelper.columnMobileNumber: mobilenumber,
      DatabaseHelper.columnDateOfBirth: dateofbirth,
      DatabaseHelper.columnClass: classNo,
      DatabaseHelper.columnCourse: course,
    };
  }
}
