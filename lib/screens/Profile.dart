// ignore_for_file: file_names
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:first_prj/main.dart';
import 'package:image_picker/image_picker.dart';
import '../models/User.dart';

class Profile extends StatefulWidget {
  final String title = "GPSaveMe";
  static Document document = Document(false, false, false);
  static User user =
      User("Marge", "Simpson", "383965213", File("images/marge.jpeg"), false);

  const Profile({Key? key}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), actions: <Widget>[
        Row(
          children: <Widget>[
            ElevatedButton.icon(
                icon: const Icon(Icons.diamond),
                label: Text(MyApp.coins.toString()),
                onPressed: () => {})
          ],
        )
      ]),
      body: Column(
        children: <Widget>[
          Container(
            height: 60.0,
            decoration: const BoxDecoration(
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(15.0)),
              color: Color.fromRGBO(142, 202, 230, 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text('Profile',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.white,
                    )),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                  margin: EdgeInsets.all(deviceWidth * 0.095),
                  child: Stack(
                    children: [
                      ClipOval(
                        child: Material(
                          color: Colors.transparent,
                          child: Ink.image(
                            image: FileImage(Profile.user.imageProfile),
                            fit: BoxFit.cover,
                            width: 120,
                            height: 120,
                            //child: InkWell(onTap: ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 4,
                        child: ClipOval(
                          child: Container(
                            padding: EdgeInsets.all(deviceWidth * 0.02),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(deviceWidth * 0.9),
                                border:
                                    Border.all(width: 4, color: Colors.white),
                                color: Colors.green),
                            child: InkWell(
                              onTap: () => _openImagePicker(),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              Padding(padding: EdgeInsets.all(deviceWidth * 0.003)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Profile.user.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    Profile.user.surname,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  Padding(padding: EdgeInsets.all(deviceWidth * 0.003)),
                  Row(
                    children: <Widget>[
                      Text(Profile.user.getReview()),
                      const Icon(
                        Icons.star,
                        color: Color.fromRGBO(255, 183, 3, 1),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(
                left: deviceWidth * 0.04, right: deviceWidth * 0.13),
            child: Row(children: [
              const Icon(
                Icons.person,
                color: Colors.grey,
              ),
              const Padding(padding: EdgeInsets.only(left: 12)),
              Profile.document.check
                  ? Row(children: [
                      const Text("Profile Verified",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      Padding(
                          padding: EdgeInsets.only(right: deviceWidth * 0.03)),
                      const Icon(
                        Icons.verified_user,
                        color: Colors.green,
                      )
                    ])
                  : const Text("Verify your profile",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ]),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(
                  0, deviceWidth * 0.02, 0, deviceWidth * 0.01)),
          Container(
            constraints: BoxConstraints(maxWidth: deviceWidth * 1),
            padding: EdgeInsets.all(deviceWidth * 0.03),
            alignment: Alignment.center,
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: deviceWidth * 0.11,
                child: ElevatedButton(
                  onPressed: () async {
                    Profile.document.frontcheck
                        ? null
                        : _openDocumentPicker(true);
                  },
                  style: Profile.document.frontcheck
                      ? ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey[300]),
                          elevation: MaterialStateProperty.all(0.0),
                          splashFactory: NoSplash.splashFactory)
                      : ElevatedButton.styleFrom(
                          primary: const Color.fromRGBO(255, 183, 3, 1)),
                  child: Row(children: [
                    const Text("Upload front document",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.black)),
                    Padding(padding: EdgeInsets.only(left: deviceWidth * 0.38)),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Profile.document.frontcheck
                            ? const Icon(Icons.access_time, color: Colors.black)
                            : const Icon(Icons.add, color: Colors.black))
                  ]),
                )),
          ),
          Container(
            constraints: BoxConstraints(maxWidth: deviceWidth * 1),
            padding: EdgeInsets.all(deviceWidth * 0.03),
            alignment: Alignment.center,
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: deviceWidth * 0.11,
                child: ElevatedButton(
                  onPressed: () async {
                    Profile.document.retrocheck
                        ? null
                        : _openDocumentPicker(false);
                  },
                  style: Profile.document.retrocheck
                      ? ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey[300]),
                          elevation: MaterialStateProperty.all(0.0),
                          splashFactory: NoSplash.splashFactory)
                      : ElevatedButton.styleFrom(
                          primary: const Color.fromRGBO(255, 183, 3, 1)),
                  child: Row(children: [
                    const Text("Upload retro document",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.black)),
                    Padding(padding: EdgeInsets.only(left: deviceWidth * 0.38)),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Profile.document.retrocheck
                            ? const Icon(Icons.access_time, color: Colors.black)
                            : const Icon(Icons.add, color: Colors.black))
                  ]),
                )),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromRGBO(255, 183, 3, 1),
        selectedItemColor: const Color.fromRGBO(33, 158, 188, 1),
        unselectedItemColor: Colors.white,
        currentIndex: MyApp.selectedIndex,
        onTap: (_index) {
          if (MyApp.selectedIndex != _index) {
            setState(() {
              MyApp.selectedIndex = _index;
            });
            MyApp.navigateToNextScreen(context, _index);
          }
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.gps_fixed), label: 'Around You'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
        ],
      ),
    );
  }

  // Implementing the image picker
  Future<void> _openImagePicker() async {
    final _picker = ImagePicker();
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        Profile.user.imageProfile = File(pickedImage.path);
      });
    }
  }

  Future<void> _openDocumentPicker(bool typeDoc) async {
    final _picker = ImagePicker();
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        //true-->front
        //false-->retro
        if (typeDoc) {
          Profile.document.front = File(pickedImage.path);
          Profile.document.frontcheck = true;
        } else {
          Profile.document.retro = File(pickedImage.path);
          Profile.document.retrocheck = true;
        }
      });
    }
  }
}
