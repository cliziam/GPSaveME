import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';
import 'package:first_prj/main.dart';
import 'package:first_prj/models/RequestDeletedPage.dart';

class RequestDeleted extends StatelessWidget {
  String tempo = "";
  String input = "";
  String emergency = "";
  var tipo = "";
  RequestDeleted(String tempo, String input, String emergency, var tipo) {
    this.tempo = tempo;
    this.input = input;
    this.emergency = emergency;
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
