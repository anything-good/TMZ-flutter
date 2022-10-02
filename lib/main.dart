// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types, non_constant_identifier_names, avoid_print, unused_local_variable, unnecessary_new, await_only_futures

import 'package:TMZFlutter/screens/Landing.dart';
import 'package:TMZFlutter/screens/Students%20Screens/StudentsTests.dart';
import 'package:TMZFlutter/screens/Students%20Screens/SubmitAnswer.dart';
import 'package:TMZFlutter/screens/Teacher%20Screens/StudentsAnswers.dart';
import 'package:flutter/material.dart';




import 'package:TMZFlutter/screens/Teacher%20Screens/TeacherTestsScreen.dart';
import 'package:TMZFlutter/screens/assistant%20Screens/AssistantHomeScreen.dart';
import 'package:TMZFlutter/screens/Students%20Screens/LeaderBoard.dart';
import 'package:TMZFlutter/screens/Students%20Screens/StudentHomeScreen.dart';
import 'package:TMZFlutter/screens/Teacher%20Screens/TeacherHome.dart';
import 'package:TMZFlutter/screens/assistant%20Screens/CorrectionScreen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

     initialRoute: '/Landing',
      routes: {
        '/Landing': (context) => Landing(),
        '/StudentHome': (context) => StudentHomeScreen(),
        '/TeacherHome': (context) => TeacherHome(),
        '/AssistantorHome': (context) => AssistantHomeScreen(),
        '/Teacher': (context) => TeacherHome(),
        '/LeaderBoard': (context) => LeaderBoard(),
        '/Correction': (context) => CorrectionScreen(),
        '/TeacherTests': (context) => TeacherTestsScreen(),
        '/StudentAnswers' : (context) => StudentsAnswers(),
        '/StudentsTests':(context) => StudentsTests(),
        '/SubmitAnswer':(context) => SubmitAnswer(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
    );
  }
}

