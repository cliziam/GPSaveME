import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class FirstRow extends StatelessWidget {
  String emergenza = "";
  String path = "";
  FirstRow(String emergenza, String path) {
    this.emergenza = emergenza;
    this.path = path;
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          emergenza,
          style: TextStyle(fontSize: 25),
        ),
        Image(
          image: AssetImage(path),
          height: 70,
          width: 70,
        ),
        InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.close)),
      ],
    );
  }
}