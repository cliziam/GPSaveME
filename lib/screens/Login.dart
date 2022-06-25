// ignore_for_file: file_names
import 'dart:convert';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_prj/main.dart';
import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';
import '../models/AlertDialogPending.dart';
import '../models/Status.dart';
import 'SignUpNumber.dart';
import 'OtpSent.dart';
import 'package:first_prj/models/User.dart';

// ignore: prefer_typing_uninitialized_variables
var request;

// ignore: must_be_immutable
class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);
  String phoneNumber = "";
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
                    onPressed: () async {
                      bool b = await checkLogin(widget.phoneNumber);
                      if (b) {
                        // ignore: use_build_context_synchronously
                        instantiateUser(widget.phoneNumber);
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => OtpSent()));
                      } else {
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                  title: const Text("Login error!"),
                                  content: const Text(
                                      "The inserted number is not registered"),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Ok'),
                                      child: const Text('Ok'),
                                    )
                                  ],
                                ));
                      }
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
                          builder: (context) => SignUpNumber()));
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

Future<bool> checkLogin(String phone) async {
  // Create a storage reference from our app
  final storageRef = FirebaseStorage.instance
      .ref(); // scommentare se si vuole fare il download

  // Create a reference with an initial file path and name
  final pathReference =
      storageRef.child("userlist.json"); // questa linea funziona
  const oneMegabyte = 1024 * 1024;
  final Uint8List? data1 = await pathReference.getData(oneMegabyte);
  var list = data1!.toList();
  var jsonAsString = String.fromCharCodes(list);
  final data = await json.decode(jsonAsString);
  bool b = false;
  var lista = data["ids"];
  if (lista.contains(phone)) b = true;
  return b;
}

void instantiateUser(String phone) async {
  final userlistPath =
      FirebaseStorage.instance.ref().child("users/$phone/userdata.json");
  const oneMegabyte = 1024 * 1024;
  final Uint8List? data = await userlistPath.getData(oneMegabyte);
  var list = data!.toList();
  var jsonAsString = String.fromCharCodes(list);
  final jsonFile = await json.decode(jsonAsString);
  final userimagePath =
      FirebaseStorage.instance.ref().child("users/$phone/images/profile.jpg");
  var url = await userimagePath.getDownloadURL();
  Image profilePic = Image.network(url);
  u = User(jsonFile["name"], jsonFile["surname"], phone, profilePic, false, 0.0,
      0.0);

  if (jsonFile["waitingHelp"] == true) {
    Status.waitingHelp = true;
    alertDialogPendingWrapper();
  }
  if (jsonFile["helpAccepted"] == true) {
    Status.helpAccepted = true;
    //alertDialogPendingWrapper(); // manca la parte di front end rispettiva
  }
  if (jsonFile["waitingAcceptOrRefuse"] == true) {
    Status.waitingAcceptOrRefuse = true;
    //alertDialogPendingWrapper(); // manca la parte di front end rispettiva
  }
  if (jsonFile["proposalAccepted"] == true) {
    Status.proposalAccepted = true;
    var app = await u!.checkProposalStatus();
    request = app[1];
    //alertDialogPendingWrapper(); // manca la parte di front end rispettiva
  }
}

Future<String>? alertDialogPendingWrapper() async {
  var reqAttributes = await u!.getHelpRequest();
  AlertDialogPending.attributes = reqAttributes;
  return "done";
}
