import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:workos/helper/shared_pref.dart';

import 'package:workos/model/user_model.dart';
import 'package:workos/ui/home/home_page.dart';
import 'package:workos/ui/widgets.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);

  signIn(String email, String password, context) {
    emit(LoginLoading());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(LoginSuccess());
      currentUserId = value.user!.uid;
      oneTimeLogin(uid: value.user!.uid);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Login Success'),
        backgroundColor: Colors.green,
      ));
      naviagteToAndReplace(context, HomePage());
    }).catchError((err) {
      print(err);
      emit(LoginFailed());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(err.toString()),
        backgroundColor: Colors.red,
      ));
    });
  }

  signUpUsingEmailAndPassword(
      {required String email,
      required String password,
      required String fullName,
      required String position,
      required String phone,
      required context}) {
    emit(SignUpLoading());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      var uId = value.user!.uid;
      saveUserData(
          userId: uId,
          name: fullName,
          email: email,
          position: position,
          phone: phone);
      emit(SignUpSuccess());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Registreded"),
        backgroundColor: Colors.green,
      ));
    }).catchError((err) {
      emit(SignUpFailed());
      print(err.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(err.toString()),
        backgroundColor: Colors.red,
      ));
    });
  }

  saveUserData({
    required String userId,
    required String name,
    required String email,
    required String position,
    required String phone,
  }) {
    UserModel userModel = UserModel(
        uid: userId,
        name: name,
        email: email,
        position: position,
        phone: phone,
        image:
            "https://image.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg");
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set(userModel.toMap())
        .then((value) {
      emit(SaveDataSuccess());
    }).catchError((err) {
      print(err);
      emit(SaveDataFailed());
    });
  }

  oneTimeLogin({required String uid}) {
    SharedPref.saveStringInSHaredPref(key: 'logined', value: uid);
  }

  logOut() {
    FirebaseAuth.instance.signOut();
    SharedPref.shaerdClear();
    emit(LogoutState());
  }
}
