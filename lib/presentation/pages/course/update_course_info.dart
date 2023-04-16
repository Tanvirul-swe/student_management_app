import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_management/config/constant/app_colors.dart';
import 'package:student_management/config/constant/size_config.dart';
import 'package:student_management/features/model/course_model.dart';
import 'package:student_management/features/repository/student_repository.dart';
import 'package:student_management/presentation/widgets/button/primery_button.dart';
import 'package:student_management/presentation/widgets/common/common_widget.dart';
import 'package:student_management/presentation/widgets/textField/text_field_style.dart';

class UpdateCourseInfo extends StatefulWidget {
  final int localId;
  const UpdateCourseInfo({super.key, required this.localId});

  @override
  State<UpdateCourseInfo> createState() => _UpdateCourseInfoState();
}

class _UpdateCourseInfoState extends State<UpdateCourseInfo> {
  final TextEditingController courseNameController = TextEditingController();

  final TextEditingController courseIdController = TextEditingController();

  final TextEditingController courseFacultyController = TextEditingController();
  final TextEditingController creditController = TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime? pickedDate;
  String selectedSubj = "";

  bool _validateForm() {
    bool isValid = formKey.currentState!.validate();

    return isValid;
  }

  Future<void> loadCourseInfo() async {
    final course =
        await StudentRepository.getCourseById(localId: widget.localId);
    setState(() {
      courseNameController.text = course.courseName;
      courseIdController.text = course.courseCode;
      courseFacultyController.text = course.facultyName;
      creditController.text = course.credit.toString();
    });
  }

  @override
  void initState() {
    loadCourseInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: const Text(
            'Update Course info',
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: PrimaryButton(
            name: 'Update',
            onPressed: () {
              if (_validateForm()) {
                StudentRepository.updateCourse(
                  model: CourseModel(
                    courseName: courseNameController.text,
                    courseCode: courseIdController.text,
                    facultyName: courseFacultyController.text,
                    credit: int.parse(creditController.text),
                  ),
                  localId: widget.localId,
                ).then((value) {
                  if (value > 0) {
                    showCustomSnackBar(context, "Course Update Successfully");
                    Navigator.pop(context, true);
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
