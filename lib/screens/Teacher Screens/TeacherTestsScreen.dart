// ignore_for_file: prefer_const_constructors, unnecessary_new, await_only_futures

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class TeacherTestsScreen extends StatefulHookWidget {
  const TeacherTestsScreen({super.key});

  @override
  State<TeacherTestsScreen> createState() => _TeacherTestsScreen();
}

File? imgfile;

class _TeacherTestsScreen extends State<TeacherTestsScreen> {
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;


    // List data;
    // useEffect(() => () => http.post(Uri.parse('uri'), body: {
    //       'instructor_id	': arguments['instructor_id	'],
    //       'course_id': arguments['course_id'],
    //     }).then(
    //       (value) => setState((data = jsonDecode(value.body))),
    //     ));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الاختبارات',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.yellow,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: imgfile == null
              ? Column(children: [
                  InkWell(
                    onTap: () => ImagePicker()
                        .pickImage(source: ImageSource.gallery)
                        .then((image) =>
                            setState((() => imgfile = File(image!.path)))),
                    child: Image.network(
                      'https://elitestudents.link/wp-content/uploads/2022/09/4863279.png',
                      width: 200,
                      height: 200,
                    ),
                  )
                ])
              : Column(
                  children: [
                    Image.file(imgfile!),
                    ElevatedButton(
                        child: Text("ارسال الاختبار"),
                        onPressed: () async {
                          FormData formData = new FormData.fromMap({
                            'image': await MultipartFile.fromFileSync(
                              imgfile!.path,
                              filename: imgfile!.path.split('/').last,
                            ),
                            'type': 'image/jpeg',
                            'course_id': arguments['course_id'],
                            'instructor_id	': arguments['instructor_id	'],
                          });

                          setState(() {
                            imgfile = null;
                          });

                          SnackBar(content: Text('تم رفع الاختبار'));

                          Response res = await Dio().post(
                              'https://hook.eu1.make.com/bfrblorl3inxwkpwcie5pth74y0horwr',
                              data: formData,
                              options: Options(
                                headers: {
                                  'content-type': 'multipart/from-data'
                                },
                              ));
                        }),
                    ElevatedButton(
                      child: Text("الغاء الصورة "),
                      onPressed: () => setState(() {
                        imgfile = null;
                      }),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
