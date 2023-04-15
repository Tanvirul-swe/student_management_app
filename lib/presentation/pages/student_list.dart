import 'package:flutter/material.dart';
import 'package:student_management/config/constant/app_colors.dart';
import 'package:student_management/config/constant/size_config.dart';
import 'package:student_management/features/model/student_model.dart';
import 'package:student_management/features/repository/student_repository.dart';
import 'package:student_management/presentation/widgets/card/student_list_card.dart';

class StudentList extends StatefulWidget {
  const StudentList({super.key});

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: AppColors.detailBG,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text('Student List'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/StudentDataInsertForm')
                    .then((value) {
                  setState(() {});
                });
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      body: FutureBuilder<List<StudentModel>>(
          future: StudentRepository().getAllStudentList(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }

            if (snapshot.hasData) {
              List<StudentModel> studentList = snapshot.data!;
              return ListView.separated(
                padding: const EdgeInsets.all(8),
                physics: const BouncingScrollPhysics(),
                itemCount: studentList.length,
                itemBuilder: (BuildContext context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/StudentDetails',
                          arguments: studentList[index]);
                    },
                    child: StudentListCard(
                      model: studentList[index],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  height: 10,
                ),
              );
            }
            return const Center(
                child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ));
          }),
    );
  }
}
