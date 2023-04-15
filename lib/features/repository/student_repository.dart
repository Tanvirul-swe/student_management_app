import 'package:sqflite/sqflite.dart';
import 'package:student_management/core/helper/database_helper.dart';
import 'package:student_management/features/model/student_model.dart';

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
}
