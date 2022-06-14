// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:first_prj/models/RequestDeletedPage.dart';

// ignore: must_be_immutable
class RequestDeleted extends StatelessWidget {
  String tempo = "";
  String input = "";
  String emergency = "";
  var tipo = "";
  RequestDeleted(String tempo, String input, String emergency, var tipo,
      {Key? key})
      : super(key: key) {
    // ignore: prefer_initializing_formals
    this.tempo = tempo;
    // ignore: prefer_initializing_formals
    this.input = input;
    // ignore: prefer_initializing_formals
    this.emergency = emergency;
    // ignore: prefer_initializing_formals
    this.tipo = tipo;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "GPSaveMe",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: RequestDeletedPage(tempo, input, emergency, tipo),
    );
  }
}
