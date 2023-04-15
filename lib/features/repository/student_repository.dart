import 'package:sqflite/sqflite.dart';
import 'package:student_management/core/helper/database_helper.dart';
import 'package:student_management/features/model/course_model.dart';
import 'package:student_management/features/model/student_model.dart';
import 'package:student_management/presentation/widgets/common/common_widget.dart';

class StudentRepository {
  static Future<int> insertStudent(StudentModel student) async {
    Database? db = await DatabaseHelper.instance.database();
    return await db!.insert(DatabaseHelper.studentTable, student.toMap());
  }

  Future<List<StudentModel>> getAllStudentList() async {
    Database? db = await DatabaseHelper.instance.database();
    List<Map<String, dynamic>> result =
        await db!.query(DatabaseHelper.studentTable);
    return result.map((e) => StudentModel.fromLocalDB(e)).toList();
  }

  static Future<CourseModel?> insertCourse(CourseModel model) async {
    Database? db = await DatabaseHelper.instance.database();
    var hasData = await db!.query(DatabaseHelper.courseTable,
        where: '${DatabaseHelper.columnCourseId} = ?',
        whereArgs: [model.courseCode]);
    if (hasData.isEmpty) {
      await db.insert(DatabaseHelper.courseTable, model.toMap());
      return model;
    }
    return null;
  }

  static Future<List<CourseModel>> getAllCourseList() async {
    Database? db = await DatabaseHelper.instance.database();
    List<Map<String, dynamic>> result =
        await db!.query(DatabaseHelper.courseTable);
    return result.map((e) => CourseModel.fromLocalDB(e)).toList();
  }

  static Future<List<StudentModel>> searchStudent(String searchValue) async {
    Database? db = await DatabaseHelper.instance.database();
    List<Map<String, dynamic>> result = await db!.query(
      DatabaseHelper.studentTable,
      where:
          '${DatabaseHelper.columnName} LIKE ? OR ${DatabaseHelper.columnMobileNumber} LIKE ?',
      whereArgs: ['%$searchValue%', '%$searchValue%'],
    );
    return result.map((e) => StudentModel.fromLocalDB(e)).toList();
  }

  Future<List<String>> fetchSuggestions(String searchValue) async {
    searchSuggestion.add(searchValue);
    final result = await StudentRepository.searchStudent(searchValue);
    List<String> temp = [];
    for (var element in result) {
      temp.add(element.name);
    }
    return temp;
  }
}
