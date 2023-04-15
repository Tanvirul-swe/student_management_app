import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_management/config/constant/app_colors.dart';
import 'package:student_management/config/constant/app_style.dart';
import 'package:student_management/config/constant/size_config.dart';
import 'package:student_management/features/model/student_model.dart';
import 'package:student_management/features/repository/student_repository.dart';
import 'package:student_management/presentation/widgets/card/student_list_card.dart';
import 'package:student_management/presentation/widgets/common/common_widget.dart';

class StudentList extends StatefulWidget {
  const StudentList({super.key});

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  String searchValue = '';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: AppColors.detailBG,
      appBar: EasySearchBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: AppColors.primaryColor,
          title: Text(
            'Student List',
            style: AppStyle.title.copyWith(color: Colors.white),
          ),
          onSearch: (value) => setState(() => searchValue = value),
          asyncSuggestions: (value) async {
            return await StudentRepository().fetchSuggestions(value);
          }),
      drawer: Drawer(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.close,
                          size: 32,
                        ))
                  ],
                ),
              ),
              ListView(
                shrinkWrap: true,
                children: [
                  menuItems('All Student', 0),
                  menuItems('New Student', 1),
                  menuItems('All Courses', 2),
                  menuItems('New Course', 3),
                ],
              ),
            ],
          ),
        ),
      ),
      body: FutureBuilder<List<StudentModel>>(
          future: StudentRepository().getAllStudentList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return loadingIndicator();
            } else if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            } else if (snapshot.data!.isEmpty) {
              return emptyView(message: "No Student At this moment");
            }

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
          }),
    );
  }

  menuItems(String title, int index) {
    return ListTile(
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: AppColors.primaryColor,
      ),
      title: Text(
        title,
        style: AppStyle.title,
      ),
      onTap: () async {
        switch (index) {
          case 0:
            {
              Navigator.pushNamed(context, '/StudentList');

              break;
            }
          case 1:
            {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/StudentDataInsertForm')
                  .then((value) {
                setState(() {});
              });

              break;
            }
          case 2:
            {
              Navigator.pushNamed(context, '/CourseList');

              break;
            }
          case 3:
            {
              Navigator.pushNamed(context, '/CourseCreateForm');

              break;
            }
        }
      },
    );
  }
}
