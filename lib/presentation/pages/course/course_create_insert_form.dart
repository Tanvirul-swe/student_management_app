import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_management/config/constant/app_colors.dart';
import 'package:student_management/config/constant/size_config.dart';
import 'package:student_management/features/model/course_model.dart';
import 'package:student_management/features/repository/student_repository.dart';
import 'package:student_management/presentation/widgets/button/primery_button.dart';
import 'package:student_management/presentation/widgets/common/common_widget.dart';
import 'package:student_management/presentation/widgets/textField/text_field_style.dart';

class CourseCreateForm extends StatefulWidget {
  const CourseCreateForm({super.key});

  @override
  State<CourseCreateForm> createState() => _CourseCreateFormState();
}

class _CourseCreateFormState extends State<CourseCreateForm> {
  final TextEditingController courseNameController = TextEditingController();

  final TextEditingController courseIdController = TextEditingController();

  final TextEditingController courseFacultyController = TextEditingController();
  final TextEditingController creditController = TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _validateForm() {
    bool isValid = formKey.currentState!.validate();

    return isValid;
  }

  DateTime? pickedDate;
  String selectedSubj = "";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: const Text(
            'Student Data Insert Form',
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: PrimaryButton(
            name: 'Save',
            onPressed: () {
              if (_validateForm()) {
                StudentRepository.insertCourse(
                  CourseModel(
                    courseName: courseNameController.text,
                    courseCode: courseIdController.text,
                    facultyName: courseFacultyController.text,
                    credit: int.parse(creditController.text),
                  ),
                ).then((value) {
                  if (value != null) {
                    showCustomSnackBar(context, "Course Create Successfully");
                    Navigator.pushReplacementNamed(
                      context,
                      '/CourseList',
                    );
                  } else {
                    showCustomSnackBar(context, "Course Code Already Exist");
                  }
                });
              }
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: courseNameController,
                    decoration: KtextField.copyWith(
                      hintText: 'Enter Course Name',
                      labelText: 'Course Name',
                    ),
                    validator: (input) =>
                        input!.isEmpty ? 'Please enter course Name' : null,
                  ),
                  SizedBox(
                    height: textFieldGap,
                  ),
                  TextFormField(
                    controller: courseIdController,
                    decoration: KtextField.copyWith(
                      hintText: 'Enter Course ID',
                      labelText: 'Course ID',
                    ),
                    validator: (input) =>
                        input!.isEmpty ? 'Please enter course Id' : null,
                  ),
                  SizedBox(
                    height: textFieldGap,
                  ),
                  TextFormField(
                    controller: courseFacultyController,
                    decoration: KtextField.copyWith(
                      hintText: 'Enter Faculty Name',
                      labelText: 'Student Father Name',
                    ),
                    validator: (input) =>
                        input!.isEmpty ? 'Please enter faculty Name' : null,
                  ),
                  SizedBox(
                    height: textFieldGap,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r"[0-9]")),
                    ],
                    controller: creditController,
                    decoration: KtextField.copyWith(
                      hintText: 'Enter Course credit',
                      labelText: 'Course credit',
                    ),
                    validator: (input) =>
                        input!.isEmpty ? 'Please enter course credit' : null,
                  ),
                  SizedBox(
                    height: textFieldGap,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
