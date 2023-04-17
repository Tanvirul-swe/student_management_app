import 'package:flutter/material.dart';
import 'package:student_management/config/constant/app_colors.dart';
import 'package:student_management/config/constant/app_style.dart';
import 'package:student_management/config/constant/size_config.dart';
import 'package:student_management/features/model/course_model.dart';

class CourseCard extends StatefulWidget {
  final CourseModel model;
  const CourseCard({super.key, required this.model});

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
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
      child: Stack(
        children: [
          Positioned(
              right: 0,
              child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/UpdateCourseInfo',
                            arguments: widget.model.id)
                        .then((value) {
                      if (value != null && value as bool) {
                        setState(() {});
                      }
                    });
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: AppColors.primaryColor,
                  ))),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Course Name : ${widget.model.courseName}",
                style: AppStyle.title,
              ),
              Text(
                "Course Code : ${widget.model.courseCode}",
                style: AppStyle.title,
              ),
              Text(
                "Course Credit : ${widget.model.credit}",
                style: AppStyle.subtitle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
