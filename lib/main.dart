import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workos/colors.dart';
import 'package:workos/helper/shared_pref.dart';
import 'package:workos/logic/auth_logic/cubit/auth_cubit.dart';
import 'package:workos/logic/work_logic/cubit/work_cubit.dart';
import 'package:workos/logic/work_logic/cubit_observer.dart';
import 'package:workos/ui/auth/login_screen.dart';
import 'package:workos/ui/home/home_page.dart';
import 'package:workos/ui/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPref.initialize();
  Bloc.observer = MyBlocObserver();
  CURRENTUSERID = await SharedPref.getStringFromSHaredPref(key: 'logined');
  print(CURRENTUSERID);
  runApp(MyApp(
    result: CURRENTUSERID,
  ));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  var result;

  MyApp({required this.result});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => WorkCubit()..getCurrentUser(),
        )
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter workos',
          //themeMode: isDark?ThemeMode.dark:The,
          theme: ThemeData(
            scaffoldBackgroundColor: Color(0xFFEDE7DC),
            primarySwatch: Colors.red,
            appBarTheme: AppBarTheme(
                centerTitle: true,
                color: baseColor,
                elevation: 00,
                iconTheme: IconThemeData(color: Colors.black)),
          ),
          darkTheme: ThemeData(
            scaffoldBackgroundColor: Colors.grey[900],
            primarySwatch: Colors.red,
            appBarTheme: AppBarTheme(
                centerTitle: true,
                color: Colors.grey[900],
                elevation: 00,
                iconTheme: IconThemeData(color: Colors.white)),
          ),
          home: result == null ? LoginScreen() : HomePage()),
    );
  }
}
