import 'package:flutter/material.dart';
import 'package:student_management/config/constant/app_style.dart';
import 'package:student_management/config/constant/size_config.dart';
import 'package:student_management/features/model/course_model.dart';

class CourseCard extends StatelessWidget {
  final CourseModel model;
  const CourseCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            "Course Name : ${model.courseName}",
            style: AppStyle.title,
          ),
          Text(
            "Course Code : ${model.courseCode}",
            style: AppStyle.title,
          ),
          Text(
            "Course Credit : ${model.credit}",
            style: AppStyle.subtitle,
          ),
        ],
      ),
    );
  }
}
