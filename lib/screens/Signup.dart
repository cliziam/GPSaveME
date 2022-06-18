// ignore_for_file: file_names
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_prj/main.dart';
import 'package:first_prj/screens/Login.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:first_prj/screens/HomePage.dart';
import 'package:image_picker/image_picker.dart';
import '../models/User.dart';

class SignUp extends StatefulWidget {
  static User user =
      User("", "", "", Image.memory(Uint8List.fromList([])), false, 0, 0);

  const SignUp({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUp> {
  //final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();

  DateTime _date = DateTime.now();
  String gender = "";
  String _birthdate = "";
  int age = 0;
  List<bool> validators = [false, false];

  void setAge(DateTime date) {
    /**function to set the age of the user*/
    DateTime today = DateTime.now();
    int ageCalculated = today.year - date.year;
    int month1 = today.month;
    int month2 = date.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = today.day;
      int day2 = date.day;
      if (day2 > day1) {
        age--;
      }
    }

    setState(() => age = ageCalculated);
  }

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
                          height: deviceHeight * 0.06,
                        )),
                  ),
                  ClipPath(
                      clipper: TopWaveClipper(),
                      child: Container(
                        color: const Color.fromRGBO(28, 158, 188, 1),
                        height: deviceHeight * 0.04,
                      )),
                ],
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Row(children: [
                  Stack(children: [
                    SizedBox(
                      width: 90,
                      height: 90,
                      child: Image.memory(Uint8List.fromList([])),
                    ),
                    // ClipOval(
                    //     child: Ink.image(
                    //   image: (SignUp.user.imageProfile),
                    //   fit: BoxFit.cover,
                    //   width: 90,
                    //   height: 90,
                    //   //child: InkWell(onTap: ),
                    // )),
                    Positioned(
                      bottom: 0,
                      right: 4,
                      child: ClipOval(
                        child: Container(
                          padding: EdgeInsets.all(deviceWidth * 0.02),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(deviceWidth * 0.9),
                              color: Colors.green),
                          child: InkWell(
                            onTap: () => _openImagePicker(),
                            child: const Icon(
                              Icons.add_a_photo_outlined,
                              color: Colors.white,
                              size: 14,
                            ),
                          ),
                        ),
                      ),
                    )
                  ]),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Take a selfie!",
                    style: TextStyle(fontSize: 16),
                  )
                ]),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    errorStyle: const TextStyle(fontSize: 10),
                    labelText: 'Name',
                    errorText: validators[0] == false
                        ? null
                        : 'Please write your name.',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: TextField(
                  controller: surnameController,
                  decoration: InputDecoration(
                    errorStyle: const TextStyle(fontSize: 10),
                    labelText: 'Surname',
                    errorText: validators[1] == false
                        ? null
                        : 'Please write your surname.',
                  ),
                ),
              ),

              Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Date of birth",
                        style: TextStyle(
                            fontSize: 15, color: Colors.grey.shade700),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      ButtonTheme(
                        minWidth: 400.0,
                        height: 100.0,
                        child: OutlinedButton(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Icon(Icons.calendar_month_outlined,
                                        size: 14, color: Colors.grey.shade700),
                                  ),
                                  const WidgetSpan(
                                    child: SizedBox(
                                      width: 10,
                                    ),
                                  ),
                                  TextSpan(
                                      text: _birthdate != ""
                                          ? _birthdate
                                          : "Select your birth date",
                                      style: TextStyle(
                                          color: Colors.grey.shade500)),
                                ],
                              ),
                            ),
                            onPressed: () async {
                              final newDate = await showDatePicker(
                                context: context,
                                initialDate: _date,
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100),
                              );
                              if (newDate == null) return;
                              setState(() => _date = newDate);
                              setState(() => _birthdate =
                                  "${_date.year}-${_date.month}-${_date.day}");
                              setAge(_date);
                            }),
                      ),
                    ]),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Text(
                  "Gender",
                  style: TextStyle(fontSize: 15, color: Colors.grey.shade700),
                ),
                for (var i in ["M", "F", "Other"])
                  OutlinedButton(
                      onPressed: () {
                        setState(() {
                          gender = i;
                        });
                      },
                      // ignore: sort_child_properties_last
                      child: Text(
                        i,
                        style: TextStyle(
                          color: (gender == i)
                              ? const Color.fromRGBO(255, 183, 3, 1)
                              : const Color.fromRGBO(33, 158, 188, 1),
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          side: BorderSide(
                              width: 2,
                              color: (gender == i)
                                  ? const Color.fromRGBO(255, 183, 3, 1)
                                  : const Color.fromRGBO(33, 158, 188, 1))))
              ]),
              Container(
                margin: const EdgeInsets.fromLTRB(220, 20, 20, 0),
                child: TextButton(
                    // ignore: sort_child_properties_last
                    child: Text("Sign up!".toUpperCase(),
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
                      setState(() {
                        nameController.text.isEmpty
                            ? validators[0] = true
                            : validators[0] = false;
                      });
                      setState(() {
                        surnameController.text.isEmpty
                            ? validators[1] = true
                            : validators[1] = false;
                      });
                      bool check = true;
                      for (var i in validators) {
                        if (i == true) {
                          check = false;
                          break;
                        }
                      }
                      if (check) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const HomePage()));
                      } else {
                        return;
                      }
                    }),
              ),
              Stack(
                children: <Widget>[
                  Opacity(
                    opacity: 0.5,
                    child: ClipPath(
                        clipper: BottomWaveClipper(),
                        child: Container(
                          color: const Color.fromRGBO(255, 183, 3, 1),
                          height: deviceHeight * 0.06,
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
                            height: deviceHeight * 0.04,
                          )),
                    ],
                  ),
                ],
              ),
            ]),
      ),
    );
  }

  Future<void> _openImagePicker() async {
    final picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() async {
        print("ciao");
        final byteData = await pickedImage.readAsBytes();
        String tempPath = (await getTemporaryDirectory()).path;
        // crea il file nella cache
        File toupload = await File('$tempPath/profile.jpeg').create();
        await toupload.writeAsBytes(byteData.buffer
            .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
        // punta a un percorso nel cloud storage
        var phone = "333"; // cambia quando re-implementiamo il SignUp
        final path = "users/$phone/images/profile.jpg";
        final ref = FirebaseStorage.instance.ref().child(path);
        // carica il file
        ref.putFile(toupload);
      });
    }
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
