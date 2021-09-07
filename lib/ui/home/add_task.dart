import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:workos/logic/work_logic/cubit/work_cubit.dart';
import 'package:workos/model/task_model.dart';
import 'package:workos/ui/widgets.dart';

import '../../colors.dart';

// ignore: must_be_immutable
class AddTask extends StatelessWidget {
  var taskNameController = TextEditingController();
  var desController = TextEditingController();
  var timeController = TextEditingController();
  var deadController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child:
                    buildText("Task Name : ", textColor, 20, FontWeight.bold),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Cannot be Empty";
                      } else {
                        return null;
                      }
                    },
                    controller: taskNameController,
                    cursorColor: primaryColor,
                    style: GoogleFonts.quicksand(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Task Name',
                        hintStyle: GoogleFonts.quicksand(
                          fontSize: 20,
                          color: Colors.grey,
                        )),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: buildText(
                    "Task Descreption : ", textColor, 20, FontWeight.bold),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Cannot be Empty";
                      } else {
                        return null;
                      }
                    },
                    controller: desController,
                    cursorColor: primaryColor,
                    style: GoogleFonts.quicksand(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Task descreption',
                        hintStyle: GoogleFonts.quicksand(
                          fontSize: 20,
                          color: Colors.grey,
                        )),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: buildText(
                    "Uploaded Time : ", textColor, 20, FontWeight.bold),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  child: TextFormField(
                    onTap: () async {
                      var date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2025));
                      var format = DateFormat().add_yMMMd();
                      if (date == null) {
                        var formated = format.format(DateTime.now());
                        timeController.text = formated;
                      } else {
                        var formated = format.format(date);
                        timeController.text = formated.toString();
                      }
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Cannot be Empty";
                      } else {
                        return null;
                      }
                    },
                    readOnly: true,
                    controller: timeController,
                    cursorColor: primaryColor,
                    style: GoogleFonts.quicksand(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Task Time',
                        hintStyle: GoogleFonts.quicksand(
                          fontSize: 20,
                          color: Colors.grey,
                        )),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: buildText(
                    "Task Deadline : ", textColor, 20, FontWeight.bold),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  child: TextFormField(
                    onTap: () async {
                      var date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2025));
                      var format = DateFormat().add_yMMMd();
                      if (date == null) {
                        var formated = format.format(DateTime.now());
                        deadController.text = formated;
                      } else {
                        var formated = format.format(date);
                        deadController.text = formated.toString();
                      }
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Cannot be Empty";
                      } else {
                        return null;
                      }
                    },
                    readOnly: true,
                    controller: deadController,
                    cursorColor: primaryColor,
                    style: GoogleFonts.quicksand(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Task Deadline',
                        hintStyle: GoogleFonts.quicksand(
                          fontSize: 20,
                          color: Colors.grey,
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              BlocBuilder<WorkCubit, WorkState>(
                builder: (context, state) {
                  var work = WorkCubit.get(context);
                  return state is UploadTaskLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : buildButton("ADD TASK", primaryColor, () {
                          work.addNewTask(
                              taskModel: TaskModel(
                                  name: taskNameController.text,
                                  id: '',
                                  writerId: work.currentUser.uid,
                                  des: desController.text,
                                  isDone: false,
                                  time: timeController.text,
                                  deadline: deadController.text,
                                  writer: work.currentUser.name));
                          work.getTasks();
                          taskNameController.clear();
                          timeController.clear();
                          deadController.clear();
                          desController.clear();
                        });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
