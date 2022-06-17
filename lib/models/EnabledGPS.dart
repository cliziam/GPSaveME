// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:first_prj/models/RequestDone.dart';

// ignore: must_be_immutable
class EnabledGPS extends StatelessWidget {
  String tempo = "";
  String input = "";
  String emergency = "";
  var tipo = "";
  EnabledGPS(String tempo, String input, String emergency, var tipo, {Key? key})
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
      home: RequestDone(tempo, input, emergency, tipo),
    );
  }
}
