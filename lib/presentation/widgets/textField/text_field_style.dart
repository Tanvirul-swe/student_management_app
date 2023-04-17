// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:student_management/config/constant/app_colors.dart';
import 'package:student_management/config/constant/app_style.dart';

final KtextField = InputDecoration(
  focusColor: AppColors.primaryColor,
  hintText: '',
  hintStyle: const TextStyle(color: AppColors.primaryColor),
  contentPadding: const EdgeInsets.only(left: 21, top: 10, bottom: 10),
  labelStyle: const TextStyle(
    fontFamily: 'Nunito',
    color: AppColors.primaryColor,
  ),
  floatingLabelStyle: AppStyle.floatingTitleStyle,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: const BorderSide(
      color: AppColors.primaryColor,
    ),
  ),
);

var dateTimeInputDecoration = InputDecoration(
    suffixIcon: const Icon(
      Icons.calendar_month_rounded,
      color: Colors.black,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(
        color: AppColors.primaryColor,
      ),
    ),
    labelStyle:
        const TextStyle(fontFamily: 'Nunito', color: AppColors.primaryColor),
    contentPadding: const EdgeInsets.only(left: 21, top: 10, bottom: 10),
    focusColor: AppColors.primaryColor,
    //icon of text field
    labelText: "Date of Birth" //label text of field
    );
