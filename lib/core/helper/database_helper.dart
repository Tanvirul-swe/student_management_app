// ignore_for_file: avoid_print,

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  final _databaseName = "studentDB.db";
  final _databaseVersion = 1;
  // make this a singleton class
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database

  Future<Database?> database() async {
    Database? database;
    var databasesPath = await getDatabasesPath();
    deleteDatabase(databasesPath);
    if (database != null) {
      return database;
    } else {
      database = await _initDatabase();
    }

    return database;
  }

// SQL code to initialize database
  Future<Database> _initDatabase() async {
    await getApplicationDocumentsDirectory();
    var databasesPath = await getDatabasesPath();
    String path = "$databasesPath/$_databaseName";

    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  // Student Table
  static const String studentTable = 'student';
  static const String columnCourse = 'course';
  static const String columnId = '_id';
  static const String columnStudentId = 'student_id';
  static const String columnName = 'name';
  static const String columnFatherName = 'father_name';
  static const String columnMobileNumber = 'mobile_number';
  static const String columnDateOfBirth = 'date_of_birth';
  static const String columnClass = 'class';

  // course Table
  static const String courseTable = 'course';
  static const String columnCourseId = 'course_id';
  static const String columnCourseName = 'course_name';
  static const String columnFacultyName = 'faculty_name';
  static const String columnCredit = 'credit';

  Future _onCreate(Database db, int version) async {
    try {
      await db.execute('''
        CREATE TABLE $studentTable(
          $columnId INTEGER PRIMARY KEY,
          $columnStudentId TEXT NOT NULL,
          $columnCourse TEXT NOT NULL,
          $columnName TEXT NOT NULL,
          $columnFatherName TEXT NOT NULL,
          $columnMobileNumber TEXT NOT NULL,
          $columnDateOfBirth INT NOT NULL,
          $columnClass INT NOT NULL
        )
      ''');

      await db.execute('''
        CREATE TABLE $courseTable(
          $columnId INTEGER PRIMARY KEY,
          $columnCourseId TEXT NOT NULL,
          $columnCourseName TEXT NOT NULL,
          $columnFacultyName TEXT NOT NULL,
          $columnCredit INT NOT NULL
        )
      ''');
    } catch (e) {
      print("Error in creating table: $e");
    }
  }
}
