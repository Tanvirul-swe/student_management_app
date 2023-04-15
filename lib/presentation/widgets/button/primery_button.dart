import 'package:flutter/material.dart';
import 'package:student_management/config/constant/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String name;
  final VoidCallback onPressed;

  const PrimaryButton({super.key, required this.name, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(12),
      child: MaterialButton(
        onPressed: onPressed,
        height: 55,
        minWidth: screenWidth,
        elevation: 0,
        color: AppColors.primaryColor,
        splashColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          name,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
