import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workos/colors.dart';
import 'package:workos/logic/work_logic/cubit/work_cubit.dart';
import 'package:workos/ui/home/home_page.dart';
import 'package:workos/ui/home/profile.dart';
import 'package:workos/ui/widgets.dart';

class UsersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WorkCubit, WorkState>(
      bloc: WorkCubit()..getUsers(),
      listener: (context, state) {
        if (state is GetCurrentUserLoading) {
          showCircleProgress();
        }
        if (state is GetCurrentUserFailed) {
          naviagteToAndReplace(context, HomePage());
        }
      },
      builder: (context, state) {
        var work = WorkCubit.get(context);
        work.getUsers();
        return Scaffold(
          appBar: AppBar(
            title: buildText("Workers", primaryColor, 28, FontWeight.bold),
          ),
          body: state is GetCurrentUserLoading
              ? Center(child: CircularProgressIndicator())
              : work.users.length == 0
                  ? Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 30,
                              child: Divider(),
                            );
                          },
                          physics: BouncingScrollPhysics(),
                          itemCount: work.users.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                naviagteTo(
                                    context,
                                    ProfileScreen(
                                        userModel: work.users[index]));
                              },
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.black,
                                      child: CircleAvatar(
                                        radius: 27,
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                                work.users[index].image),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        buildText(work.users[index].name,
                                            primaryColor, 20, FontWeight.bold),
                                        buildText(work.users[index].position,
                                            textColor, 18, FontWeight.w500),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
        );
      },
    );
  }
}
