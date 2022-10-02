// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types, non_constant_identifier_names, unused_import, prefer_interpolation_to_compose_strings, prefer_typing_uninitialized_variables, avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:http/http.dart' as http;

class TeacherHome extends HookWidget {
  TeacherHome({super.key});

  Widget build(BuildContext context) {
    const list = [
      {
        'title': 'لوحة الصدارة ',
        'image':
            'https://elitestudents.link/wp-content/uploads/2022/09/2817802.png',
        'path': '/LeaderBoard'
      },
      {
        'title': 'المحاضرات ',
        'image':
            'https://elitestudents.link/wp-content/uploads/2022/09/ZOOM-Cloud-Meetings_-logo.jpg',
        'path': '/StudentLectures'
      },
      {
        'title': 'الاختبارات',
        'image':
            'https://elitestudents.link/wp-content/uploads/2022/09/2792474.png',
        'path': '/TeacherTests'
      },
      {
        'title': 'التصحيح',
        'image':
            'https://elitestudents.link/wp-content/uploads/2022/09/4961759.png',
        'path': '/StudentAnswers'
      },
    ];

    final instructorID = ModalRoute.of(context)!.settings.arguments;

    final courses = useState([]);

    print(courses.value[0]['ID']);

    useEffect(() {
      http
          .get(
              Uri.parse(
                  'https://elitestudents.link/wp-json/llms/v1/instructors/${instructorID}'),
              headers: {
                'authorization':
                    'Basic Y2tfY2I1NzE5Y2UzNWE0YWMxOGNjZTM0NzBiZGFlNjYxYTRhZGUzNjE1Yjpjc19kNGQzYTY5YmVkNDMwYTIyMzIzOGJmYmNhNTA0ZWM3MzQxZDk5YTk4'
              })
          .then((res) => jsonDecode(res.body))
          .then((json) => courses.value = json['courses'])
          .catchError((err) => print(err));
    }, []);

    return Scaffold(
      //  bottomNavigationBar: GNav(
      //       padding: EdgeInsets.all(18),
      //       gap: 10,
      //       backgroundColor: Colors.yellow,
      //       color: Colors.black,
      //       tabBackgroundColor: Colors.white,
      //       tabs: [
      //         GButton(
      //           icon: Icons.home,
      //           text: 'الرئيسية',
      //         ),
      //         GButton(
      //           icon: Icons.upload,
      //           text: 'اختبار',
      //           margin: EdgeInsets.all(10),
      //         ),
      //         GButton(
      //           icon: Icons.work_history,
      //           text: 'تصحيح',
      //         ),
      //         GButton(
      //           icon: Icons.leaderboard,
      //           text: 'الصدارة',
      //         ),
      //       ]),

      appBar: AppBar(
        backgroundColor: Colors.yellowAccent[400],
        title: Center(
          child: Text(
            ' منصة  التميز',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 9 / 12),
          children: [
            for (var item in list)
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Card(
                  child: InkWell(
                    onTap: () => showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(25),
                          ),
                        ),
                        context: context,
                        builder: ((context) => Column(children: [
                              Text(
                                'اختر الدورة',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 20),
                              ),
                              Divider(
                                color: Colors.black,
                              ),
                              for (final c in courses.value)
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: InkWell(
                                    onTap: () => Navigator.pushNamed(
                                        context, item['path']!,
                                        arguments: {
                                          'instructor_id	': instructorID,
                                          'course_id': c['ID'],
                                        }),
                                    child: SizedBox(
                                      width: 300,
                                      height: 60,
                                      child: Card(
                                        color: Colors.yellow,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            c['post_title'].toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                            ]))),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Image.network(
                            item['image'].toString(),
                            height: 125,
                            width: 125,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.yellow,
                            ),
                            child: Text(
                              item['title'].toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
