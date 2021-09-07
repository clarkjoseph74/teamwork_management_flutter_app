import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workos/colors.dart';
import 'package:workos/logic/work_logic/cubit/work_cubit.dart';
import 'package:workos/ui/widgets.dart';

// ignore: must_be_immutable
class CommentsScreen extends StatelessWidget {
  var commentController = TextEditingController();
  var id;
  CommentsScreen({required this.id});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WorkCubit, WorkState>(
      bloc: WorkCubit.get(context).getComments(taskId: id),
      listener: (context, state) {},
      builder: (context, state) {
        var work = WorkCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: buildText("Comments", primaryColor, 20, FontWeight.bold),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    child: ListView.separated(
                      reverse: true,
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: Colors.green.shade700,
                        );
                      },
                      physics: BouncingScrollPhysics(),
                      itemCount: work.comments.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.green,
                                  radius: 20,
                                  child: CircleAvatar(
                                    radius: 18,
                                    backgroundImage: NetworkImage(
                                        work.comments[index].userImage),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        buildText(work.comments[index].userName,
                                            primaryColor, 18, FontWeight.bold),
                                        Text('    |    '),
                                        buildText(
                                            work.comments[index].userPosition,
                                            textColor,
                                            15,
                                            FontWeight.w400),
                                      ],
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      child: buildText(
                                          work.comments[index].comment,
                                          textColor,
                                          15,
                                          FontWeight.w400),
                                    ),
                                    buildText(work.comments[index].time,
                                        textColor, 15, FontWeight.w400),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Row(
                      children: [
                        Container(
                          width: 200,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Cannot be Empty";
                              } else {
                                return null;
                              }
                            },
                            controller: commentController,
                            cursorColor: primaryColor,
                            style: GoogleFonts.quicksand(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Write a Comment..',
                                hintStyle: GoogleFonts.quicksand(
                                  fontSize: 20,
                                  color: Colors.grey,
                                )),
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              work.addComments(
                                  taskId: id, comment: commentController.text);
                              commentController.clear();
                            },
                            child: buildText("Add Comment", Colors.blue, 15,
                                FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
