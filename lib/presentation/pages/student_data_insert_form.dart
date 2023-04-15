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

class StudentDataInsertForm extends StatefulWidget {
  const StudentDataInsertForm({super.key});

  @override
  State<StudentDataInsertForm> createState() => _StudentDataInsertFormState();
}

class _StudentDataInsertFormState extends State<StudentDataInsertForm> {
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
                StudentRepository.insertStudent(
                  StudentModel(
                    studentid: idController.text,
                    name: nameController.text,
                    fathername: fatherNameController.text,
                    mobilenumber: mobileNumberController.text,
                    dateofbirth: pickedDate!.millisecondsSinceEpoch,
                    classNo: int.parse(classController.text),
                    course: selectedSubj,
                  ),
                ).then((value) {
                  if (value > 0) {
                    showCustomSnackBar(context, "Data Inserted Successfully");
                    Navigator.pop(context);
                  } else {
                    showCustomSnackBar(context, "Data Inserted Failed");
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
                    decoration: InputDecoration(
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
                        labelStyle: const TextStyle(
                            fontFamily: 'Nunito',
                            color: AppColors.primaryColor),
                        contentPadding: const EdgeInsets.only(
                            left: 21, top: 10, bottom: 10),
                        focusColor: AppColors.primaryColor,
                        //icon of text field
                        labelText: "Date of Birth" //label text of field
                        ),
                    readOnly: true,
                    //set it true, so that user will not able to edit text
                    onTap: () async {
                      pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1920),
                        lastDate: DateTime.now(),
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                            data: ThemeData(
                              primarySwatch: Colors.grey,
                              splashColor: Colors.black,
                              textTheme: const TextTheme(
                                titleMedium: TextStyle(color: Colors.black),
                                labelLarge: TextStyle(color: Colors.black),
                              ),
                              colorScheme: const ColorScheme.light(
                                primary: AppColors.primaryColor,
                                primaryContainer: Colors.black,
                                secondaryContainer: Colors.black,
                                onSecondary: Colors.black,
                                onPrimary: Colors.white,
                                surface: Colors.black,
                                onSurface: Colors.black,
                                secondary: Colors.black,
                              ),
                              dialogBackgroundColor: Colors.white,
                            ),
                            child: child ?? const Text(""),
                          );
                        },
                      );
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
                    labelText: "Select Course", //'Select year',
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
