import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workos/colors.dart';
import 'package:workos/logic/work_logic/cubit/work_cubit.dart';
import 'package:workos/model/task_model.dart';
import 'package:workos/ui/home/comments_screen.dart';
import 'package:workos/ui/widgets.dart';

class TaskDetails extends StatelessWidget {
  final TaskModel taskModel;

  const TaskDetails({required this.taskModel});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: buildText("Task", primaryColor, 22, FontWeight.bold),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  buildText("Task Name : ", textColor, 20, FontWeight.w500),
                  buildText(taskModel.name, primaryColor, 20, FontWeight.w500)
                ],
              ),
              SizedBox(
                height: 40,
                child: Divider(
                  color: Colors.grey.shade400,
                ),
              ),
              buildText("Task Descreption : ", textColor, 20, FontWeight.w500),
              Flexible(
                  child: buildText(
                      taskModel.des, secTextColor, 20, FontWeight.w500,
                      maxline: 5)),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  buildText("Uploaded Time : ", textColor, 20, FontWeight.w500),
                  buildText(taskModel.time, secTextColor, 20, FontWeight.w500)
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  buildText("deadline : ", textColor, 20, FontWeight.w500),
                  buildText(
                      taskModel.deadline, secTextColor, 20, FontWeight.w500)
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  buildText("Done State : ", textColor, 20, FontWeight.w500),
                  buildText(
                      taskModel.isDone ? "Completed" : "Pending",
                      taskModel.isDone ? Colors.green : Colors.orange,
                      20,
                      FontWeight.w500)
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  buildText("Uploaded by : ", textColor, 20, FontWeight.w500),
                  buildText(taskModel.writer, Colors.blue, 20, FontWeight.w500)
                ],
              ),
              SizedBox(
                height: 50,
              ),
              buildButton("Comments", primaryColor, () {
                naviagteTo(context, CommentsScreen(id: taskModel.id));
              }),
              CURRENTUSERID == taskModel.writerId
                  ? Column(
                      children: [
                        SizedBox(
                          height: 40,
                          child: Divider(
                            color: Colors.grey.shade900,
                          ),
                        ),
                        buildText(
                            "Manage Task", textColor, 27, FontWeight.w500),
                        SizedBox(
                          height: 10,
                        ),
                        BlocBuilder<WorkCubit, WorkState>(
                          builder: (context, state) {
                            var work = WorkCubit.get(context);
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    work.changeDoneState(
                                        taskId: taskModel.id,
                                        doneOrNot: taskModel.isDone);
                                    Navigator.pop(context);
                                  },
                                  child: buildText("Change Done State ",
                                      Colors.green, 20, FontWeight.w500),
                                ),
                                state is DeleteTaskLoading
                                    ? CircularProgressIndicator()
                                    : InkWell(
                                        onTap: () {
                                          work.deleteTask(taskId: taskModel.id);
                                          Navigator.pop(context);
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      )
                              ],
                            );
                          },
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
