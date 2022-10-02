// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types, non_constant_identifier_names, avoid_print, prefer_interpolation_to_compose_strings, must_call_super, override_on_non_overriding_member, unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StudentsAnswer extends StatefulWidget {
  const StudentsAnswer({super.key});

  @override
  State<StudentsAnswer> createState() => _StudentsAnswerState();
}

class _StudentsAnswerState extends State<StudentsAnswer> {

  @override
 
  Widget build(BuildContext context) {
    var courses;

    
    return Scaffold(
        body: Column(
      children: [for (var c in courses) Card()],
    ));
  }
}
 
