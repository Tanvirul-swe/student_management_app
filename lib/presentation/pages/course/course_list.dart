import 'package:flutter/material.dart';
import 'package:student_management/config/constant/app_colors.dart';
import 'package:student_management/features/model/course_model.dart';
import 'package:student_management/features/repository/student_repository.dart';
import 'package:student_management/presentation/widgets/card/course_card.dart';
import 'package:student_management/presentation/widgets/common/common_widget.dart';

class CourseList extends StatefulWidget {
  const CourseList({super.key});

  @override
  State<CourseList> createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.detailBG,
      appBar: AppBar(
        title: const Text("Course List"),
        backgroundColor: AppColors.primaryColor,
      ),
      body: FutureBuilder<List<CourseModel>>(
          future: StudentRepository.getAllCourseList(),
          builder: (context, AsyncSnapshot<List<CourseModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return loadingIndicator();
            } else if (snapshot.hasError) {
              return errorText();
            } else if (snapshot.data!.isEmpty) {
              return emptyView(message: "No Course At this moment");
            }

            List<CourseModel> courseList = snapshot.data!;
            return ListView.separated(
              padding: const EdgeInsets.all(8),
              physics: const BouncingScrollPhysics(),
              itemCount: courseList.length,
              itemBuilder: (BuildContext context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/CourseDetails',
                        arguments: courseList[index]);
                  },
                  child: CourseCard(
                    model: courseList[index],
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
}
