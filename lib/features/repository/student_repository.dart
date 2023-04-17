import 'package:sqflite/sqflite.dart';
import 'package:student_management/core/helper/database_helper.dart';
import 'package:student_management/features/model/course_model.dart';
import 'package:student_management/features/model/student_model.dart';
import 'package:student_management/presentation/widgets/common/common_widget.dart';

class StudentRepository {
  /// This method is used to insert student data into local database
  static Future<int> insertStudent(StudentModel student) async {
    Database? db = await DatabaseHelper.instance.database();
    return await db!.insert(DatabaseHelper.studentTable, student.toMap());
  }

// This method is used to update student data into local database
  static Future<int> updateStudentInfo(
      {required StudentModel student, required int localId}) async {
    Database? db = await DatabaseHelper.instance.database();
    return await db!.update(DatabaseHelper.studentTable, student.toMap(),
        where: '${DatabaseHelper.columnId} = ?', whereArgs: [localId]);
  }

  /// This method is used to get student all data from local database
  Future<List<StudentModel>> getAllStudentList() async {
    Database? db = await DatabaseHelper.instance.database();
    List<Map<String, dynamic>> result =
        await db!.query(DatabaseHelper.studentTable);
    return result.map((e) => StudentModel.fromLocalDB(e)).toList();
  }

  // This method is used to get student data by id from local database
  static Future<StudentModel> getStudentById({required int localId}) async {
    Database? db = await DatabaseHelper.instance.database();
    List<Map<String, dynamic>> result = await db!.query(
      DatabaseHelper.studentTable,
      where: '${DatabaseHelper.columnId} = ?',
      whereArgs: [localId],
    );
    return StudentModel.fromLocalDB(result.first);
  }

  /// This method is used to insert course data into local database
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

  // This method is used to update course data into local database
  static Future<int> updateCourse(
      {required CourseModel model, required int localId}) async {
    Database? db = await DatabaseHelper.instance.database();
    var hasData = await db!.query(DatabaseHelper.courseTable,
        where: '${DatabaseHelper.columnCourseId} = ?',
        whereArgs: [model.courseCode]);
    if (hasData.isEmpty) {
      return await db.update(DatabaseHelper.courseTable, model.toMap(),
          where: '${DatabaseHelper.columnId} = ?', whereArgs: [localId]);
    }
    return 0;
  }

  /// This method is used to get all course list from local database
   Future<List<CourseModel>> getAllCourseList() async {
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

  // This method is used to get course data by id from local database
  static Future<CourseModel> getCourseById({required int localId}) async {
    Database? db = await DatabaseHelper.instance.database();
    List<Map<String, dynamic>> result = await db!.query(
      DatabaseHelper.courseTable,
      where: '${DatabaseHelper.columnId} = ?',
      whereArgs: [localId],
    );
    return CourseModel.fromLocalDB(result.first);
  }
}
