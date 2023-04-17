import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_management/config/constant/app_colors.dart';
import 'package:student_management/config/constant/app_const.dart';
import 'package:student_management/config/constant/size_config.dart';
import 'package:student_management/features/model/student_model.dart';
import 'package:student_management/features/repository/student_repository.dart';
import 'package:student_management/presentation/widgets/button/dropdown_button.dart';
import 'package:student_management/presentation/widgets/button/primery_button.dart';
import 'package:student_management/presentation/widgets/common/common_widget.dart';
import 'package:student_management/presentation/widgets/textField/text_field_style.dart';

class UpdateStudentInfo extends StatefulWidget {
  final int localId;
  const UpdateStudentInfo({super.key, required this.localId});

  @override
  State<UpdateStudentInfo> createState() => _UpdateStudentInfoState();
}

class _UpdateStudentInfoState extends State<UpdateStudentInfo> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController idController = TextEditingController();

  final TextEditingController fatherNameController = TextEditingController();

  final TextEditingController mobileNumberController = TextEditingController();

  final TextEditingController dateOfBirthController = TextEditingController();

  final TextEditingController classController = TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _validateForm() {
    bool isValid = formKey.currentState!.validate();

    return isValid;
  }

  DateTime? pickedDate;
  String selectedSubj = "";
  bool isLoading = true;
  Future<void> loadStudentInfo() async {
    final student =
        await StudentRepository.getStudentById(localId: widget.localId);
    setState(() {
      nameController.text = student.name;
      idController.text = student.studentid;
      fatherNameController.text = student.fathername;
      mobileNumberController.text = student.mobilenumber;
      dateOfBirthController.text = student.dateofbirth.toString();
      classController.text = student.classNo.toString();
      pickedDate = DateTime.fromMillisecondsSinceEpoch(student.dateofbirth);
      dateOfBirthController.text =
          "${pickedDate!.day}-${pickedDate!.month}-${pickedDate!.year}";
      selectedSubj = student.course;
      isLoading = false;
    });
  }

  @override
  void initState() {
    loadStudentInfo();
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
            'Update Student Info',
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: PrimaryButton(
            name: 'Save',
            onPressed: () {
              if (_validateForm()) {
                StudentRepository.updateStudentInfo(
                  student: StudentModel(
                    studentid: idController.text,
                    name: nameController.text,
                    fathername: fatherNameController.text,
                    mobilenumber: mobileNumberController.text,
                    dateofbirth: pickedDate!.millisecondsSinceEpoch,
                    classNo: int.parse(classController.text),
                    course: selectedSubj,
                  ),
                  localId: widget.localId,
                ).then((value) {
                  if (value > 0) {
                    showCustomSnackBar(
                        context, "Student Info Update Successfully");
                    Navigator.pop(context, true);
                  } else {
                    showCustomSnackBar(context, "Update Failed");
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
              child: isLoading?loadingIndicator(): Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: KtextField.copyWith(
                      hintText: 'Enter Student Name',
                      labelText: 'Student Name',
                    ),
                    validator: (input) =>
                        input!.isEmpty ? 'Please enter Student Name' : null,
                  ),
                  SizedBox(
                    height: textFieldGap,
                  ),
                  TextFormField(
                    controller: idController,
                    decoration: KtextField.copyWith(
                      hintText: 'Enter Student ID',
                      labelText: 'Student ID',
                    ),
                    validator: (input) =>
                        input!.isEmpty ? 'Please enter Student ID' : null,
                  ),
                  SizedBox(
                    height: textFieldGap,
                  ),
                  TextFormField(
                    controller: fatherNameController,
                    decoration: KtextField.copyWith(
                      hintText: 'Enter Student Father Name',
                      labelText: 'Student Father Name',
                    ),
                    validator: (input) => input!.isEmpty
                        ? 'Please enter Student Father Name'
                        : null,
                  ),
                  SizedBox(
                    height: textFieldGap,
                  ),
                  TextFormField(
                    controller: mobileNumberController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r"[0-9]")),
                      LengthLimitingTextInputFormatter(11),
                    ],
                    decoration: KtextField.copyWith(
                      hintText: "+880 ___ ___ __ __",
                      labelText: 'Mobile Number',
                    ),
                    validator: (input) => input!.isEmpty
                        ? 'Please enter Student Mobile Number'
                        : input.length < 11
                            ? "Invalid number formate"
                            : null,
                  ),
                  SizedBox(
                    height: textFieldGap,
                  ),
                  TextFormField(
                    controller: dateOfBirthController,
                    decoration: dateTimeInputDecoration,
                    readOnly: true,
                    //set it true, so that user will not able to edit text
                    onTap: () async {
                      pickedDate = await customDateTimePicker(context);
                      if (pickedDate != null) {
                        String formattedDate =
                            "${pickedDate!.day}-${pickedDate!.month}-${pickedDate!.year}";
                        dateOfBirthController.text = formattedDate;
                      }
                    },
                    validator: (input) => input!.isEmpty
                        ? "Please enter Student Date of Birth"
                        : null,
                  ),
                  SizedBox(
                    height: textFieldGap,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r"[0-9]")),
                    ],
                    controller: classController,
                    decoration: KtextField.copyWith(
                      hintText: 'Enter Student Class',
                      labelText: 'Student Class',
                    ),
                    validator: (input) =>
                        input!.isEmpty ? 'Please enter Student Class' : null,
                  ),
                  SizedBox(
                    height: textFieldGap,
                  ),
                  DropdownButtonWidget(
                    isExpanded: false,
                    labelText: "Select Course", //
                    dropDownValue: selectedSubj,
                    items: AppConstant.course.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(
                          items,
                          style: const TextStyle(
                              fontFamily: 'Nunito',
                              color: AppColors.primaryColor),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      selectedSubj = value!;
                    },
                    validator: (open) =>
                        selectedSubj.isEmpty ? "Select Course" : null,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
