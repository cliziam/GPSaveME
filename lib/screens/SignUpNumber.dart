// ignore_for_file: file_names
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_prj/main.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'Signup.dart';
import 'package:first_prj/models/User.dart';

User? u;

// ignore: must_be_immutable
class SignUpNumber extends StatefulWidget {
  SignUpNumber({Key? key}) : super(key: key);
  String phoneNumber = "";
  @override
  // ignore: library_private_types_in_public_api
  _SignUpNumberPageState createState() => _SignUpNumberPageState();
}

class _SignUpNumberPageState extends State<SignUpNumber> {
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
                "Sign Up",
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
              ),
              // ignore: prefer_const_constructors
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: const Text(
                      "Enter your mobile phone to continue your registration",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black38))),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white60,
                  border: Border.all(
                    color: Colors.white,
                    width: 1,
                  ),
                ),
                margin: const EdgeInsets.all(10),
                child: PhoneFormField(
                    defaultCountry: IsoCode.IT,
                    countrySelectorNavigator:
                        const CountrySelectorNavigator.modalBottomSheet(
                      favorites: [IsoCode.IT, IsoCode.US],
                    ),
                    onSaved: (number) {
                      widget.phoneNumber = number!.nsn;
                    },
                    onChanged: (number) {
                      // ignore: avoid_print
                      widget.phoneNumber = number!.nsn;
                    }),
              ),
              Container(
                  margin: const EdgeInsets.fromLTRB(20, 20, 20, 2),
                  child: TextButton(
                    // ignore: sort_child_properties_last
                    child: Text("Sign Up".toUpperCase(),
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
                    onPressed: () async {
                      bool finished =
                          await createUser(widget.phoneNumber, context);
                      if (finished) {
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUp()));
                      }
                    },
                  )),

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

createUser(String phone, BuildContext context) async {
  final userlistPath = FirebaseStorage.instance.ref().child("userlist.json");
  const oneMegabyte = 1024 * 1024;
  final Uint8List? data = await userlistPath.getData(oneMegabyte);
  var list = data!.toList();
  var jsonAsString = String.fromCharCodes(list);
  final jsonFile = await json.decode(jsonAsString);
  if (!jsonFile["ids"].contains(phone)) {
    jsonFile["ids"].add(phone);

    var jsonString = jsonEncode(jsonFile);
    var bytes = utf8.encode(jsonString);
    var byteData = base64.encode(bytes);

    var arr = base64.decode(byteData);

    String tempPath = (await getTemporaryDirectory()).path;
    // crea il file nella cache
    File toupload = await File('$tempPath/userlist.json').create();
    await toupload.writeAsBytes(arr);
    final ref = FirebaseStorage.instance.ref().child("userlist.json");
    // carica il file
    await ref.putFile(toupload);
    Image blank = await User.getBlankImage();
    u = User("", "", "", blank, false, 0.0, 0.0);
    u!.phoneNumber = phone;
  } else {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text("Invalid number"),
              content: const Text("The inserted number is already registered."),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Ok'),
                  child: const Text('Ok'),
                )
              ],
            ));
  }
  return true;
}
