// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:student_management/config/constant/app_colors.dart';
import 'package:student_management/config/constant/app_style.dart';

class DropdownButtonWidget extends StatelessWidget with ChangeNotifier {
  String? dropDownValue;
  final String labelText;
  late final ValueChanged<String?>? onChanged;
  final List<DropdownMenuItem<String>>? items;
  final String? Function(String?)? validator;
  bool isExpanded;

  // String? Function(String?)? validator;

  DropdownButtonWidget({
    Key? key,
    this.onChanged,
    this.items,
    required this.labelText,
    this.dropDownValue,
    this.validator,
    required this.isExpanded,
  }) : super(key: key);

  void setChangedListener(ValueChanged<String?>? onChanged) {
    this.onChanged = onChanged;
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      isExpanded: isExpanded,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
            fontFamily: 'Nunito', color: AppColors.primaryColor),
        focusColor: AppColors.primaryColor,
        contentPadding:
            const EdgeInsets.only(left: 21, top: 10, bottom: 10, right: 5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            width: 2,
            color: AppColors.primaryColor,
          ),
        ),
        floatingLabelStyle: AppStyle.floatingTitleStyle,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            width: 2,
            color: AppColors.primaryColor,
          ),
        ),
      ),
      style: AppStyle.body,
      focusColor: AppColors.primaryColor,
      onChanged: onChanged,
      elevation: 10,
      items: items,
      value: dropDownValue,
      hint: Text(" $labelText"),
      validator: validator,
    );
  }
}
