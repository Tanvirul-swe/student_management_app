import 'package:flutter/material.dart';
import 'package:student_management/config/constant/app_colors.dart';
import 'package:student_management/config/constant/app_style.dart';
import 'package:student_management/config/constant/size_config.dart';
import 'package:student_management/core/util/date_time_convert.dart';
import 'package:student_management/features/model/student_model.dart';

class StudentDetails extends StatelessWidget {
  final StudentModel model;
  const StudentDetails({super.key, required this.model});

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
                "Name : ${model.name}",
                style: AppStyle.title,
              ),
              SizedBox(
                height: textFieldGap,
              ),
              Text("Student Id : ${model.studentid}", style: AppStyle.subtitle),
              SizedBox(
                height: textFieldGap / 2,
              ),
              Text(
                "Date of birth : ${DateTimeConverter.millisecondToRealDate(millisecond: model.dateofbirth)}",
                style: AppStyle.subtitle,
              ),
              SizedBox(
                height: textFieldGap / 2,
              ),
              Text(
                "Class : ${model.classNo}",
                style: AppStyle.subtitle,
              ),
              SizedBox(
                height: textFieldGap / 2,
              ),
              Text(
                "Course : ${model.course}",
                style: AppStyle.subtitle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
