import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workos/logic/auth_logic/cubit/auth_cubit.dart';
import 'package:workos/ui/auth/login_screen.dart';
import 'package:workos/ui/home/add_task.dart';
import 'package:workos/ui/home/profile.dart';
import 'package:workos/ui/home/users_screen.dart';

import '../colors.dart';

// ignore: non_constant_identifier_names
late var CURRENTUSERID;
late var currentUserId;

var textColor = Colors.black;
var secTextColor = Colors.blueGrey;
Widget buildText(
    String txt, Color color, double fontSize, FontWeight fontWeight,
    {int maxline = 1}) {
  return Text(
    txt,
    maxLines: maxline,
    style: GoogleFonts.quicksand(
        fontSize: fontSize, fontWeight: fontWeight, color: color),
  );
}

Widget buildButton(String text, Color color, onClick) {
  return Center(
    child: GestureDetector(
      onTap: onClick,
      child: Container(
        height: 40,
        width: 140,
        child:
            Center(child: buildText(text, Colors.white, 15, FontWeight.bold)),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
  );
}

naviagteTo(context, widget) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => widget,
  ));
}

naviagteToAndReplace(context, widget) {
  Navigator.of(context).pushReplacement(MaterialPageRoute(
    builder: (context) => widget,
  ));
}

buildCardItem(
    {required bool isDone,
    required String name,
    required String des,
    required context}) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.12,
    child: Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Icon(
              isDone ? Icons.done_rounded : Typicons.stopwatch,
              color: isDone ? Colors.green : Colors.orange,
              size: 50,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Container(
                width: 1,
                height: double.infinity,
                color: Colors.grey.shade300,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildText(name, primaryColor, 18, FontWeight.bold),
                  buildText(des, Colors.grey, 15, FontWeight.normal),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    ),
  );
}

buildMyDrawer({
  required String name,
  required String position,
  required String image,
  required context,
  required userModel,
}) {
  return Drawer(
    child: Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: 220,
            width: double.infinity,
            color: primaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.black,
                    child: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(image),
                      radius: 32,
                    ),
                  ),
                ),
                buildText(name, Colors.black, 30, FontWeight.bold),
                buildText(position, Colors.black, 18, FontWeight.normal),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              children: [
                ListTile(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    leading: Icon(
                      FontAwesome5.tasks,
                      color: textColor,
                    ),
                    title:
                        buildText("All Tasks", textColor, 20, FontWeight.bold),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: textColor,
                    )),
                ListTile(
                    onTap: () {
                      naviagteTo(context, ProfileScreen(userModel: userModel));
                    },
                    leading: Icon(
                      Icons.account_circle,
                      color: textColor,
                    ),
                    title:
                        buildText("My Account", textColor, 20, FontWeight.bold),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: textColor,
                    )),
                ListTile(
                    onTap: () {
                      naviagteTo(context, UsersPage());
                    },
                    leading: Icon(
                      Icons.workspaces,
                      color: textColor,
                    ),
                    title: buildText(
                        "Registered Workers", textColor, 20, FontWeight.bold),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: textColor,
                    )),
                ListTile(
                    onTap: () {
                      naviagteTo(context, AddTask());
                    },
                    leading: Icon(
                      Icons.add_task,
                      color: textColor,
                    ),
                    title:
                        buildText("Add Task", textColor, 20, FontWeight.bold),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: textColor,
                    )),
                ListTile(
                    onTap: () {
                      AuthCubit.get(context).logOut();
                      naviagteToAndReplace(context, LoginScreen());
                    },
                    leading: Icon(
                      FontAwesome.logout,
                      color: textColor,
                    ),
                    title: buildText("Logout", textColor, 20, FontWeight.bold),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: textColor,
                    )),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

showCircleProgress() {
  return CircularProgressIndicator();
}
