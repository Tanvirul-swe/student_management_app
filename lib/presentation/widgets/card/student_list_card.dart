// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_management/config/constant/app_colors.dart';
import 'package:student_management/config/constant/app_style.dart';
import 'package:student_management/config/constant/size_config.dart';
import 'package:student_management/core/util/date_time_convert.dart';
import 'package:student_management/features/model/student_model.dart';
import 'package:student_management/presentation/bloc/student/bloc/student_bloc.dart';

class StudentListCard extends StatelessWidget {
  StudentModel model;
  StudentListCard({
    super.key,
    required this.model,
  });

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
                onPressed: () async {
                  await Navigator.pushNamed(context, '/UpdateStudentInfo',
                          arguments: model.id)
                      .then((value) {
                    if (value != null && value as bool) {
                      context.read<StudentBloc>().add(StudentLoadEvent());
                    }
                  });
                },
                icon: const Icon(
                  Icons.edit,
                  color: AppColors.primaryColor,
                )),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "ID : ${model.studentid}",
                style: AppStyle.title,
              ),
              Text(
                "Name : ${model.name}",
                style: AppStyle.title,
              ),
              Text(
                DateTimeConverter.millisecondToRealDate(
                    millisecond: model.dateofbirth),
                style: AppStyle.subtitle,
              ),
              Text(
                "Class : ${model.classNo}",
                style: AppStyle.subtitle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
