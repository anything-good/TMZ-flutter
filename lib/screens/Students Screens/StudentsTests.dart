// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types, non_constant_identifier_names, avoid_print, unused_local_variable, prefer_interpolation_to_compose_strings

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;

class StudentsTests extends HookWidget {
  const StudentsTests({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;

    var AllTestsIDs = useState([]) as List;
    var TakenTestsIDs = useState([]) as List;
    var TestsNotTaken = useState([]) as List;

    print(AllTestsIDs);
    useEffect(() => ()async{
      http
          .post(
              Uri.parse('https://elitestudents.link/wp-json/correction/tests'),
              body: {
                "course_id": arguments['course_id'],
              })
          .then((res) => jsonDecode(res.body))
          .then((AllTests) => AllTests.map((t) => t['wp_media_id']))
          .then((All_IDS) => AllTestsIDs = All_IDS)
          .catchError((err) => print(err));

      http
          .post(
              Uri.parse(
                  'https://elitestudents.link/wp-json/correction/answers'),
              body: {
                'course_id': arguments['course_id'],
                'student_id': arguments['student_id']
              })
          .then((res) => jsonDecode(res.body))
          .then((TakenTests) => TakenTests.map((t) => t['wp_media_id']))
          .then((Taken_IDS) => AllTestsIDs = Taken_IDS)
          .catchError((err) => print(err));

      var TestsNotTaken =
          AllTestsIDs.map((t) => TakenTestsIDs.indexOf(t) > -1 ? null : t);
      TestsNotTaken = TestsNotTaken;

// defining the not taken list and seting it state
    });

    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.yellowAccent[400],
          title: Center(
            child: Text(
              'اختبارات الدورة',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Text(
                  'الاوراق الجديدة',
                  style: TextStyle(fontSize: 20),
                ),
                Divider(
                  color: Colors.black,
                  thickness: 2,
                ),
                for (var c in TestsNotTaken)
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SizedBox(
                      height: 125,
                      width: 350,
                      child: InkWell(
                        onTap: () => Navigator.pushNamed(context, '/Correction',
                            arguments: {
                              'student_id': c['student_id'],
                              'img_url':
                                  'https://elitestudents.link/wp-content/uploads/' +
                                      c['image_name']
                            }),
                        child: Card(
                          color: Colors.yellow,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 40),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.green,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'اجابة جديدة',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                ),
                              ),
                              Text(
                                c['student_name'],
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                Divider(
                  thickness: 2,
                  color: Colors.black,
                ),
                Text(
                  'الاوراق المصححة',
                  style: TextStyle(fontSize: 20),
                ),
                for (var c in TakenTestsIDs)
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SizedBox(
                      height: 100,
                      width: 350,
                      child: InkWell(
                        onTap: () => Navigator.pushNamed(context, '/Correction',
                            arguments: {
                              'student_id': c['student_id'],
                              'img_url':
                                  'https://elitestudents.link/wp-content/uploads/' +
                                      c['image_name']
                            }),
                        child: Card(
                          color: Colors.blueGrey,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                c['student_name'],
                                style: TextStyle(fontSize: 20),
                              ),
                              Image.network(
                                  'https://elitestudents.link/wp-content/uploads/download.jpg'),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.green,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text(
                                    'اجابة جديدة',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ));
  }
}
