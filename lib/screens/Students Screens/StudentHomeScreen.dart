// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, sort_child_properties_last, unnecessary_string_interpolations, file_names, unnecessary_brace_in_string_interps, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StudentHomeScreen extends HookWidget {
  const StudentHomeScreen({super.key});
  static const list = [
    {
      'title': 'لوحة الصدارة',
      'image':
          'https://elitestudents.link/wp-content/uploads/2022/09/2817802.png',
      'path': '/LeaderBoard'
    },
    {
      'title': 'الدورات',
      'image': 'https://elitestudents.link/wp-content/uploads/courses.jpg',
      'path': '/StudentLectures'
    },
    {
      'title': 'الاختبارات',
      'image':
          'https://elitestudents.link/wp-content/uploads/2022/09/2792474.png',
      'path': '/StudentsTests'
    },
    {
      'title': 'المعلومات',
      'image':
          'https://elitestudents.link/wp-content/uploads/2022/09/2436683.png',
      'path': '/Profile'
    },
    {
      'title': 'مساعدة',
      'image':
          'https://elitestudents.link/wp-content/uploads/2022/09/4961759.png',
      'path': '/Help'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final student_id = ModalRoute.of(context)!.settings.arguments;
    print(student_id);

    final courses = useState([]);

    useEffect(() {
      http
          .post(
              Uri.parse(
                  'https://elitestudents.link/wp-json/llms/v1/students/${student_id}'),
              headers: {
                'authorization':
                    'Basic Y2tfY2I1NzE5Y2UzNWE0YWMxOGNjZTM0NzBiZGFlNjYxYTRhZGUzNjE1Yjpjc19kNGQzYTY5YmVkNDMwYTIyMzIzOGJmYmNhNTA0ZWM3MzQxZDk5YTk4'
              })
          .then((res) => jsonDecode(res.body))
          .then((json) => courses.value = json['MyEnrollments'])
          .catchError((err) => print(err));
    }, []);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellowAccent[400],
        title: Center(
          child: Text(
            'منصة  التميز',
            style: TextStyle(
              color: Colors.black,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ),
      body: GridView(
        children: [
          for (var item in list)
            Card(
              margin: EdgeInsets.all(15.0),
              child: InkWell(
                onTap: () =>

                    //Navigator.pushNamed(context, item['path']!),
                    showModalBottomSheet(
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
                              for (var c in courses.value)
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: InkWell(
                                    onTap: () => Navigator.of(context)
                                        .pushNamed(item['path'].toString(),
                                            arguments: {
                                          'student_id': student_id.toString(),
                                          'course_id': c['course_id'].toString(),
                                        }),
                                    child: SizedBox(
                                      width: 300,
                                      height: 60,
                                      child: Card(
                                        color: Colors.yellow,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            c['course_title'].toString(),
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
                        "${item['image'].toString()}",
                        height: 125,
                        width: 125,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.yellow,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            item['title'].toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
        ],
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 9 / 12),
      ),
    );
  }
}
