import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workos/colors.dart';
import 'package:workos/logic/work_logic/cubit/work_cubit.dart';
import 'package:workos/ui/home/task_details.dart';
import 'package:workos/ui/widgets.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WorkCubit, WorkState>(
      listener: (context, state) {},
      builder: (context, state) {
        var work = WorkCubit.get(context);
        return state is GetCurrentUserLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : state is GetTasksLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Scaffold(
                    appBar: AppBar(
                      title: buildText(
                          "WorkOS", primaryColor, 30, FontWeight.bold),
                    ),
                    drawer: buildMyDrawer(
                      name: work.currentUser.name,
                      position: work.currentUser.position,
                      image: work.currentUser.image,
                      context: context,
                      userModel: work.currentUser,
                    ),
                    body: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            child: buildText(
                                "Tasks : ", textColor, 26, FontWeight.w500),
                          ),
                          Expanded(
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: work.tasks.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  child: buildCardItem(
                                      isDone: work.tasks[index].isDone,
                                      name: work.tasks[index].name,
                                      des: work.tasks[index].des,
                                      context: context),
                                  onTap: () {
                                    naviagteTo(
                                        context,
                                        TaskDetails(
                                            taskModel: work.tasks[index]));
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ));
      },
    );
  }
}
