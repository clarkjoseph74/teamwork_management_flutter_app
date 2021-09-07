import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import 'package:workos/colors.dart';
import 'package:workos/model/commentModel.dart';
import 'package:workos/model/task_model.dart';
import 'package:workos/model/user_model.dart';
import 'package:workos/ui/widgets.dart';

part 'work_state.dart';

class WorkCubit extends Cubit<WorkState> {
  WorkCubit() : super(WorkInitial());

  static WorkCubit get(context) => BlocProvider.of(context);

  var usersCollection = FirebaseFirestore.instance.collection('users');
  var tasksCollection = FirebaseFirestore.instance.collection('tasks');

  late UserModel currentUser;
  getCurrentUser() async {
    emit(GetCurrentUserLoading());
    await usersCollection
        .doc(CURRENTUSERID ?? currentUserId)
        .get()
        .then((value) {
      currentUser = UserModel.fromMap(value.data()!);
      emit(GetCurrentUserSuccess());
      getTasks();
    }).catchError((err) {
      print(err);
      emit(GetCurrentUserFailed());
    });
  }

  List<UserModel> users = [];
  getUsers() async {
    emit(GetUsersLoading());
    usersCollection.get().then((value) {
      users = [];
      value.docs.forEach((element) {
        if (CURRENTUSERID != element.data()['uid']) {
          users.add(UserModel.fromMap(element.data()));
        }
        print(users.length);
      });
      emit(GetUsersSuccess());
    }).catchError((err) {
      print(err);
      emit(GetUsersFailed());
    });
  }

  List<TaskModel> tasks = [];
  getTasks() {
    emit(GetTasksLoading());
    tasks = [];

    tasksCollection.orderBy('time', descending: true).get().then((value) {
      print(value.docs.length);

      value.docs.forEach((task) {
        tasks.add(TaskModel.fromJson(task.data()));
      });

      emit(GetTasksSuccess());
    }).catchError((err) {
      print(err);
      emit(GetTasksFailed());
    });
  }

  final ImagePicker _picker = ImagePicker();
  XFile? pickedFile;
  File? profilePic;
  pickImageFromGallary(context) async {
    pickedFile =
        await _picker.pickImage(source: ImageSource.gallery).then((value) {
      if (value == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: buildText(
                "No Image Selcted", primaryColor, 15, FontWeight.bold)));
      } else {
        profilePic = File(value.path);
        uploadToStorage(file: profilePic!);
      }
      emit(GetImageSuccess());
    }).catchError((err) {
      emit(GetImageFailed());
    });
  }

  String profilePicUrl = '';
  uploadToStorage({required File file}) {
    FirebaseStorage.instance
        .ref()
        .child("users/${Uri.file(file.path).pathSegments.last}")
        .putFile(file)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        profilePicUrl = value;
        updateProfilePic(imageUrl: profilePicUrl);
      });
    }).catchError((err) {});
  }

  updateProfilePic({required String imageUrl}) {
    usersCollection
        .doc(CURRENTUSERID)
        .set({'image': imageUrl}, SetOptions(merge: true)).then((value) {
      emit(UpdateProfileSuccess());
    }).catchError((err) {
      emit(UpdateProfileFailed());
    });
  }

  sendWhatsappMessage({required String phoneNumber}) async {
    // await FlutterLaunch.launchWathsApp(phone: phoneNumber, message: '');
  }

  addNewTask({required TaskModel taskModel}) {
    emit(UploadTaskLoading());
    tasksCollection.add(taskModel.toJson()).then((value) {
      value.set({'id': value.id}, SetOptions(merge: true));
      emit(UploadTaskSuccess());
    }).catchError((err) {
      print(err);
      emit(UploadTaskFailed());
    });
  }

  deleteTask({required String taskId}) {
    emit(DeleteTaskLoading());
    tasksCollection.doc(taskId).delete().then((value) {
      getTasks();
      emit(DeleteTaskSuccess());
    }).catchError((err) {
      emit(DeleteTaskFailed());
    });
  }

  changeDoneState({required String taskId, required bool doneOrNot}) {
    tasksCollection
        .doc(taskId)
        .set({"isDone": !doneOrNot}, SetOptions(merge: true)).then((value) {
      getTasks();
      emit(UpdateDoneStateSuccess());
    }).catchError((error) {
      emit(UpdateDoneStateFailed());
    });
  }

  List<CommentModel> comments = [];
  getComments({required String taskId}) {
    comments = [];
    FirebaseFirestore.instance
        .collection('tasks')
        .doc(taskId)
        .collection('comments')
        .orderBy('time', descending: true)
        .snapshots()
        .listen((event) {
      comments = [];
      event.docs.forEach((element) {
        comments.add(CommentModel.fromMap(element.data()));
        print(comments.length);
      });
      emit(GetComments());
    }).onDone(() {});

    print(comments.length);
  }

  addComments({required String taskId, required String comment}) {
    emit(AddCommentLoading());
    var format = DateFormat.yMEd().add_jm();
    CommentModel commentModel = CommentModel(
        userName: currentUser.name,
        userImage: currentUser.image,
        comment: comment,
        time: format.format(DateTime.now()),
        userPosition: currentUser.position);
    FirebaseFirestore.instance
        .collection('tasks')
        .doc(taskId)
        .collection('comments')
        .add(commentModel.toMap())
        .then((value) {
      emit(AddCommentSuccess());
    }).catchError((err) {
      print(err);
      emit(AddCommentFailed());
    });
  }
}
