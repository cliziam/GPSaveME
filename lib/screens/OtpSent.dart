// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_otp/flutter_otp.dart';

class otpSent extends StatefulWidget {
  @override
  _otpSentPageState createState() => _otpSentPageState();
}

class _otpSentPageState extends State<otpSent> {
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/sfondo.png"), fit: BoxFit.cover),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.all(20),
                      child: new TextField(
                        decoration: new InputDecoration(
                            labelText: "Insert the code sent by SMS"),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ], // Only numbers can be entered
                      )),
                  Container(
                      margin: EdgeInsets.fromLTRB(20, 20, 20, 2),
                      child: TextButton(
                          child: Text("Login".toUpperCase(),
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white)),
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.all(15)),
                              //foregroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(33, 158, 188, 1)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromRGBO(33, 158, 188, 1)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          color: Color.fromRGBO(
                                              33, 158, 188, 1))))),
                          onPressed: () => null))
                ])));
  }
}
