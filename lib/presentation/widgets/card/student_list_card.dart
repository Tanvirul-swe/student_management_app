// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_management/config/constant/app_colors.dart';
import 'package:student_management/config/constant/app_style.dart';
import 'package:student_management/config/constant/size_config.dart';
import 'package:student_management/core/util/date_time_convert.dart';
import 'package:student_management/features/model/student_model.dart';
import 'package:student_management/presentation/bloc/student/bloc/student_bloc.dart';

class StudentListCard extends StatefulWidget {
  StudentModel model;
  StudentBloc studentBloc;
  StudentListCard({super.key, required this.model, required this.studentBloc});

  @override
  State<StudentListCard> createState() => _StudentListCardState();
}

class _StudentListCardState extends State<StudentListCard> {
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
                          arguments: widget.model.id)
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
                "ID : ${widget.model.studentid}",
                style: AppStyle.title,
              ),
              Text(
                "Name : ${widget.model.name}",
                style: AppStyle.title,
              ),
              Text(
                DateTimeConverter.millisecondToRealDate(
                    millisecond: widget.model.dateofbirth),
                style: AppStyle.subtitle,
              ),
              Text(
                "Class : ${widget.model.classNo}",
                style: AppStyle.subtitle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
