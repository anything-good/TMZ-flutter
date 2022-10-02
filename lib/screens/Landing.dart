// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types, non_constant_identifier_names, use_build_context_synchronously, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'TeacherLogin.dart';
import 'StudentLogin.dart';

class Landing extends StatelessWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {
   
       

      // if (data != null)
      //   data.role == 'student'
      //       ? Navigator.pushNamed(context, '/StudentHome')
      //       : data.role == 'instructor'
      //           ? Navigator.pushNamed(context, '/TeacherHome')
      //           : Navigator.pushNamed(context, '/assistantorHome');
      // }


  // await Hive.initFlutter();
  // var box = await Hive.openBox('box');
  // var data = await box.get('data');
  // data != null ? print('grdbuivddddddddddddddddddddddddddddddddddddddddddddddddddddddd')
  // :print(null);
  // runApp(MyApp());

  
  


    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text(
            "تسجيل الدخول - منصة التميز",
          ),
          shadowColor: Colors.orange,
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'الطلبة',
                icon: Icon(PhosphorIcons.student),
              ),
              Tab(
                text: 'المدرسين',
                icon: Icon(PhosphorIcons.chalkboardTeacherLight),
              ),
              Tab(
                text: 'المساعدين',
                icon: Icon(PhosphorIcons.personThin),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            StudentLogin(),
            TeacherLogin(),
            TeacherLogin(),
          ],
        ),
      ),
    );
  }
}
