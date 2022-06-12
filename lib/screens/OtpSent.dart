// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:first_prj/screens/HomePage.dart';
import 'package:first_prj/screens/Login.dart';
import 'package:first_prj/main.dart';
//import 'package:flutter_otp/flutter_otp.dart';

class OtpSent extends StatefulWidget {
  const OtpSent({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _OtpSentPageState createState() => _OtpSentPageState();
}

class _OtpSentPageState extends State<OtpSent> {
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Opacity(
                        opacity: 0.5,
                        child: ClipPath(
                            clipper: TopWaveClipper(),
                            child: Container(
                              color: const Color.fromRGBO(28, 158, 188, 1),
                              height: deviceHeight * 0.17,
                            )),
                      ),
                      ClipPath(
                          clipper: TopWaveClipper(),
                          child: Container(
                            color: const Color.fromRGBO(28, 158, 188, 1),
                            height: deviceHeight * 0.15,
                          )),
                    ],
                  ),
                  Container(
                      margin: const EdgeInsets.all(20),
                      child: TextField(
                        decoration: const InputDecoration(
                            labelText: "Insert the code sent by SMS"),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ], // Only numbers can be entered
                      )),
                  Container(
                      margin: const EdgeInsets.fromLTRB(20, 20, 20, 2),
                      child: TextButton(
                          child: Text("Login".toUpperCase(),
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white)),
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.all(15)),
                              //foregroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(33, 158, 188, 1)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color.fromRGBO(33, 158, 188, 1)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(
                                          color: Color.fromRGBO(
                                              33, 158, 188, 1))))),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => HomePage()));
                          })),
                  Stack(
                    children: <Widget>[
                      Opacity(
                        opacity: 0.5,
                        child: ClipPath(
                            clipper: BottomWaveClipper(),
                            child: Container(
                              color: const Color.fromRGBO(255, 183, 3, 1),
                              height: deviceHeight * 0.17,
                            )),
                      ),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: deviceHeight * 0.02),
                          ),
                          ClipPath(
                              clipper: BottomWaveClipper(),
                              child: Container(
                                color: const Color.fromRGBO(255, 183, 3, 1),
                                height: deviceHeight * 0.15,
                              )),
                        ],
                      ),
                    ],
                  ),
                ])));
  }
}
