import 'package:flutter/material.dart';
import 'package:student_management/config/constant/app_colors.dart';
import 'package:student_management/config/constant/app_style.dart';
import 'package:student_management/config/constant/size_config.dart';
import 'package:student_management/features/model/course_model.dart';

class CourseDetails extends StatelessWidget {
  final CourseModel model;
  const CourseDetails({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.detailBG,
      appBar: AppBar(
        title: const Text("Details"),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.all(SizeConfig.defaultSize),
          width: SizeConfig.screenWidth,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                  color: Colors.white10, blurRadius: 16, offset: Offset(0, 12))
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Course Name: ${model.courseName}",
                style: AppStyle.title,
              ),
              SizedBox(
                height: textFieldGap,
              ),
              Text("Course Code : ${model.courseCode}",
                  style: AppStyle.subtitle),
              SizedBox(
                height: textFieldGap / 2,
              ),
              Text(
                "Faculty : ${model.facultyName}",
                style: AppStyle.subtitle,
              ),
              SizedBox(
                height: textFieldGap / 2,
              ),
              Text(
                "Credit : ${model.credit}",
                style: AppStyle.subtitle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
