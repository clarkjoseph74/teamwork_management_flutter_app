import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:workos/colors.dart';
import 'package:workos/logic/work_logic/cubit/work_cubit.dart';
import 'package:workos/model/user_model.dart';
import 'package:workos/ui/widgets.dart';

class ProfileScreen extends StatelessWidget {
  final UserModel userModel;

  const ProfileScreen({required this.userModel});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WorkCubit, WorkState>(
      listener: (context, state) {},
      builder: (context, state) {
        var work = WorkCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Column(
              children: [
                _buildHeader(
                    image: work.profilePicUrl == ''
                        ? userModel.image
                        : work.profilePicUrl),
                SizedBox(
                  height: 20,
                ),
                _buildInformationSection(userModel: userModel),
                Spacer(),
                CURRENTUSERID == userModel.uid
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: buildButton("CHANGE PICTURE", primaryColor, () {
                          work.pickImageFromGallary(context);
                        }))
                    : Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        FontAwesome5.whatsapp,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      buildText("Send A Message", Colors.white,
                                          15, FontWeight.bold)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                work.sendWhatsappMessage(
                                    phoneNumber: userModel.phone);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Row(
                                    children: [
                                      Icon(
                                        FontAwesome5.phone_alt,
                                        color: Colors.white,
                                        size: 23,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      buildText("Make A Call", Colors.white, 15,
                                          FontWeight.bold)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
              ],
            ),
          ),
        );
      },
    );
  }

  _buildHeader({required String image}) {
    return CircleAvatar(
      backgroundColor: primaryColor,
      radius: 50,
      child: CircleAvatar(
        radius: 45,
        backgroundImage: CachedNetworkImageProvider(image),
      ),
    );
  }

  _buildInformationSection({required UserModel userModel}) {
    return Column(
      children: [
        buildText(userModel.name, primaryColor, 30, FontWeight.bold),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              buildText("Email : ", textColor, 20, FontWeight.bold),
              buildText(userModel.email, Colors.blue, 20, FontWeight.w500),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              buildText("Phone : ", textColor, 20, FontWeight.bold),
              buildText(userModel.phone, Colors.blue, 20, FontWeight.w500),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              buildText("Position : ", textColor, 20, FontWeight.bold),
              buildText(userModel.position, Colors.blue, 20, FontWeight.w500),
            ],
          ),
        ),
      ],
    );
  }
}
