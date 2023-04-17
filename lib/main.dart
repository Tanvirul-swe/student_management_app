import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_management/config/routes/route_generator.dart';
import 'package:student_management/features/repository/student_repository.dart';
import 'package:student_management/presentation/pages/student/student_list.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,
      home:  RepositoryProvider(
        create: (context) => StudentRepository(),
        child: const StudentList(),
      ),
    );
  }
}
