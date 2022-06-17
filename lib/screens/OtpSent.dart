// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:first_prj/screens/HomePage.dart';
import 'package:first_prj/screens/Login.dart';
import 'package:first_prj/main.dart';

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
                  const Text(
                    'Verification',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Enter your OTP code number sent by SMS",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black38,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _textFieldOTP(first: true, last: false),
                            _textFieldOTP(first: false, last: false),
                            _textFieldOTP(first: false, last: false),
                            _textFieldOTP(first: false, last: true),
                          ],
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const HomePage()));
                            },
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color.fromRGBO(255, 183, 3, 1)),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(14.0),
                              child: Text(
                                'Verify',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        const Text(
                          "Didn't you receive any code?",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black38,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        const Text(
                          "Resend New Code",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(33, 158, 188, 1),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
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

  Widget _textFieldOTP({required bool first, last}) {
    // ignore: sized_box_for_whitespace
    return Container(
      height: 85,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.isEmpty && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: const Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    width: 2, color: Color.fromRGBO(255, 183, 3, 1)),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}
