// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types, non_constant_identifier_names, file_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StudentLogin extends StatefulWidget {
  const StudentLogin({super.key});

  @override
  State<StudentLogin> createState() => Student_LoginState();
}

class Student_LoginState extends State<StudentLogin> {
  final _nameController = TextEditingController();
  final _TeleController = TextEditingController();
  final _PhoneController = TextEditingController();
  final _CodeController = TextEditingController();

  void StudentLogin() {
    http
        .post(
            Uri.parse('https://elitestudents.link/wp-json/custom_users/login/'),
            body: {
              'username': _CodeController.text.trim(),
              'password': _CodeController.text.trim(),
            })
        .then((res) => jsonDecode(res.body))
        .then((json) => Navigator.popAndPushNamed(context, '/StudentHome',
            arguments: json['data']['ID'].toString()))

            // .then((json) => http.post(
        //         Uri.parse(
        //             'https://elitestudents.link/wp-json/custom_users/update'),
        //         body: {
        //           'ID': json.data.ID,
        //           'first_name': _nameController.text.trim(),
        //           'last_name': _PhoneController.text.trim(),
        //           'nickname': _TeleController.text.trim(),
        //         })
        // .then((res) => Hive.box('box').put('data', {
        //       'ID': res,
        //   'role': 'instructor',
        // })))
        //// you can navigate him then saving the data in storage
        .catchError((err) => print(err));
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
                          controller: _CodeController,
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
                      onPressed: () => StudentLogin(),
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
