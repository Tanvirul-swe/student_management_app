import 'package:flutter/material.dart';
import 'package:student_management/config/constant/app_colors.dart';

final List<String> searchSuggestion = [];
void showCustomSnackBar(BuildContext context, String message,
    {bool isError = false}) {
  if (message.isNotEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        dismissDirection: DismissDirection.horizontal,
        // margin: const EdgeInsets.all(8),
        duration: const Duration(seconds: 3),
        backgroundColor: isError ? Colors.red : AppColors.primaryColor,
        behavior: SnackBarBehavior.fixed,
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Text(message,
            style: const TextStyle(fontSize: 15, color: AppColors.white))));
  }
}

Widget errorText() {
  return const Center(
      child: Text(
    "Something went wrong",
    style: TextStyle(color: Colors.red),
  ));
}

Widget loadingIndicator() {
  return const Center(
    child: CircularProgressIndicator(),
  );
}

Widget emptyView({required String message}) {
  return Center(
      child: Text(
    message,
    style: const TextStyle(color: Colors.red),
  ));
}
