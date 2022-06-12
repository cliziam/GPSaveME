import 'package:first_prj/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:first_prj/models/ImageDialog.dart';
import 'dart:math' as math;

class RoundedCard extends StatelessWidget {
  String path = "";
  String text = "";

  RoundedCard(String path, String text) {
    this.path = path;
    this.text = text;
  }

  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (_) => ImageDialog(text, path));
      },
      child: Card(
        shape: CircleBorder(),
        color: Colors.yellow[200],
        child: Container(
            height: 120,
            width: 120,
            child: Column(children: [
              Image(
                image: AssetImage(path),
                height: 85,
                width: 85,
              ),
              Text(text, style: TextStyle(fontSize: 20)),
            ])),
      ),
    );
  }
}
