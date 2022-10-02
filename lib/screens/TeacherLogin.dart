// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types, non_constant_identifier_names, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TeacherLogin extends StatefulWidget {
  const TeacherLogin({super.key});

  @override
  State<TeacherLogin> createState() => _TeacherLoginState();
}

class _TeacherLoginState extends State<TeacherLogin> {
  final _codeController = TextEditingController();

  void LoginTeacher() {
    http
        .post(
            Uri.parse('https://elitestudents.link/wp-json/custom_users/login/'),
            body: {
              'username': _codeController.text.trim(),
              'password': _codeController.text.trim(),
            })
        .then((res) => jsonDecode(res.body))
        // .then((json) => json['caps']['instructor']
        //     ? Hive.box('box')
        //         .put('data', {
        //           'ID': json['ID'],
        //           'role': 'instructor',
        //         })
        .then((json) => 
        Navigator.popAndPushNamed(
              context,
              '/TeacherHome',
              arguments: json['data']['ID'].toString(),
            ))
        .catchError((err) => print(err))

        // : json['caps']['instructors_assistant']
        //     ? Hive.box('box')
        //         .put('data', {
        //           'ID': json['ID'],
        //           'role': 'instructors_assistant',
        //         })
        .then((_) => Navigator.popAndPushNamed(context, '/CorrectorHome'));

    // : print('your are not allowed'))
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                'https://elitestudents.link/wp-content/uploads/2022/09/squar_tmz_logo.png',
                height: 150,
                width: 150,
              ),
              Form(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: 300,
                        height: 50,
                        child: TextField(
                          controller: _codeController,
                          decoration: InputDecoration(
                            labelText: 'الكود',
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onChanged: ((value) => ''),
                        ),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () => LoginTeacher(),
                      color: Colors.cyan,
                      textColor: Colors.white,
                      child: Text('تسجيل الدخول'),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
