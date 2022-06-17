// ignore_for_file: file_names
import 'package:first_prj/main.dart';
import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'Signup.dart';
import 'OtpSent.dart';
//import 'package:flutter_otp/flutter_otp.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
                "Login",
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
              ),
              // ignore: prefer_const_constructors
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: const Text(
                      "Enter your mobile phone to continue, \nwe will send you OTP to verify",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black38))),
              Container(
                margin: const EdgeInsets.all(10),
                child: PhoneFormField(
                    defaultCountry: IsoCode.IT,
                    countrySelectorNavigator:
                        const CountrySelectorNavigator.modalBottomSheet(
                      favorites: [IsoCode.IT, IsoCode.US],
                    ),
                    //onSaved: (number) {print('saved $p');},
                    onChanged: (number) {
                      // ignore: avoid_print
                      print('changed $number');
                    }),
              ),
              Container(
                  margin: const EdgeInsets.fromLTRB(20, 20, 20, 2),
                  child: TextButton(
                    // ignore: sort_child_properties_last
                    child: Text("Sign in".toUpperCase(),
                        style:
                            const TextStyle(fontSize: 14, color: Colors.white)),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.all(15)),
                        //foregroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(33, 158, 188, 1)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromRGBO(33, 158, 188, 1)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: const BorderSide(
                                        color:
                                            Color.fromRGBO(33, 158, 188, 1))))),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const OtpSent()));
                    },
                  )),
              Row(children: [
                const Padding(
                    padding: EdgeInsets.only(left: 100),
                    child: Text("Not registered yet?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black38))),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SignUp()));
                    },
                    child: const Text('Sign up',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(33, 158, 188, 1)))),
              ]),
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
            ],
          ),
        ));
  }
}

class TopWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    debugPrint(size.width.toString());
    var path = Path();
    path.lineTo(0, size.height);
    var firstStart = Offset(size.width / 5, size.height);
    var firstEnd = Offset(size.width / 2.25, size.height - 50.0);
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);
    var secondStart =
        Offset(size.width - (size.width / 3.24), size.height - 105);
    var secondEnd = Offset(size.width, size.height - 10);
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    debugPrint(size.width.toString());
    var path = Path();
    var startingPoint = 0.0;

    path.lineTo(0, 0);
    var firstStart = Offset(size.width / 5, startingPoint);
    var firstEnd = Offset(size.width / 2.25, startingPoint + 50.0);
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);
    var secondStart =
        Offset(size.width - (size.width / 3.24), startingPoint + 105);
    var secondEnd = Offset(size.width, startingPoint + 10);
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);
    path.lineTo(size.width, deviceHeight);
    path.lineTo(0, deviceHeight);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
