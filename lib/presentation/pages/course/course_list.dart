import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_management/config/constant/app_colors.dart';
import 'package:student_management/features/model/course_model.dart';
import 'package:student_management/features/repository/student_repository.dart';
import 'package:student_management/presentation/bloc/course/bloc/course_bloc.dart';
import 'package:student_management/presentation/widgets/card/course_card.dart';
import 'package:student_management/presentation/widgets/common/common_widget.dart';

class CourseList extends StatefulWidget {
  const CourseList({super.key});

  @override
  State<CourseList> createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.detailBG,
      appBar: AppBar(
        title: const Text("Course List"),
        backgroundColor: AppColors.primaryColor,
      ),
      body: BlocProvider(
        create: (context) => CourseBloc(
          RepositoryProvider.of<StudentRepository>(context),
        )..add(CourseLoadEvent()),
        child: BlocBuilder<CourseBloc, CourseState>(
          builder: (context, state) {
            if (state is CourseLoading) {
              return loadingIndicator();
            } else if (state is CourseErrorState) {
              return const Center(child: Text('Something went wrong'));
            } else if (state is CourseLoaded) {
              List<CourseModel> data = state.course;
              return ListView.separated(
                padding: const EdgeInsets.all(8),
                physics: const BouncingScrollPhysics(),
                itemCount: data.length,
                itemBuilder: (BuildContext context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/CourseDetails',
                          arguments: data[index]);
                    },
                    child: CourseCard(
                      model: data[index],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  height: 10,
                ),
              );
            }
            return emptyView(message: "No Course At this moment");
          },
        ),
      ),
    );
  }
}
