// ignore_for_file: file_names
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:first_prj/main.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../models/User.dart';
import 'package:first_prj/screens/Login.dart';

class Profile extends StatefulWidget {
  final String title = "GPSaveMe";
  static Document document = Document(false, false, false);

  const Profile({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          uploadProfilePic();
        },
      ),
      appBar: AppBar(
        title: Text(widget.title),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Tooltip(
                  message: "Remaining coins to ask for help!",
                  triggerMode: TooltipTriggerMode.tap,
                  child: Icon(Icons.diamond_sharp),
                ),
                Text(MyApp.coins.toString()),
              ],
            ),
          ),
        ],
      ),
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
                      SizedBox(
                        width: 90,
                        height: 90,
                        child: u!.imageProfile,
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
                    u!.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    u!.surname,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  Padding(padding: EdgeInsets.all(deviceWidth * 0.003)),
                  Row(
                    children: <Widget>[
                      Text(u!.reviewMean),
                      IconButton(
                        icon: const Icon(Icons.star,
                            color: Color.fromRGBO(255, 183, 3, 1)),
                        onPressed: () {
                          _showReviews(u!.imageProfile);
                        },
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
                            : const Icon(Icons.add, color: Colors.black)),
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
        onTap: (index) {
          if (MyApp.selectedIndex != index) {
            setState(() {
              MyApp.selectedIndex = index;
            });
            MyApp.navigateToNextScreen(context, index);
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
    final picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      final byteData = await pickedImage.readAsBytes();
      String tempPath = (await getTemporaryDirectory()).path;
      // crea il file nella cache
      File toupload = await File('$tempPath/profile.jpeg').create();
      await toupload.writeAsBytes(byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
      setState(() {
        print("ciao");
        // punta a un percorso nel cloud storage
        final path = "users/${u!.phoneNumber}/images/profile.jpg";
        final ref = FirebaseStorage.instance.ref().child(path);
        // carica il file
        ref.putFile(toupload);
        u!.imageProfile = Image.memory(Uint8List.fromList(byteData));
      });
    }
  }

  Future<void> _openDocumentPicker(bool typeDoc) async {
    final picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      final byteData = await pickedImage.readAsBytes();
      String tempPath = (await getTemporaryDirectory()).path;
      // crea il file nella cache
      var name = typeDoc ? "front" : "retro";
      File toupload = await File('$tempPath/${name}doc.jpeg').create();
      await toupload.writeAsBytes(byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
      setState(() {
        //true-->front
        //false-->retro
        if (typeDoc) {
          // punta a un percorso nel cloud storage
          final path = "users/${u!.phoneNumber}/images/${name}doc.jpg";
          final ref = FirebaseStorage.instance.ref().child(path);
          // carica il file
          ref.putFile(toupload);
          Profile.document.frontcheck = true;
        } else {
          // punta a un percorso nel cloud storage
          final path = "users/${u!.phoneNumber}/images/${name}doc.jpg";
          final ref = FirebaseStorage.instance.ref().child(path);
          // carica il file
          ref.putFile(toupload);
          Profile.document.retrocheck = true;
        }
      });
    }
  }

  void _showReviews(Image imageProfile) {
    showDialog(
        context: context,
        builder: (_) => Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.all(10),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                    width: deviceWidth * 0.9,
                    height: deviceHeight * 0.70,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("images/sfondoreview.png"),
                            fit: BoxFit.fill)),
                    padding: const EdgeInsets.fromLTRB(0, 35, 12, 320),
                    alignment: Alignment.center,
                    child: const Text("Reviews",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left)),
                Positioned(
                  top: -70,
                  child: CircleAvatar(
                      backgroundColor: const Color.fromRGBO(255, 178, 3, 1),
                      radius: 60,
                      child: SizedBox(
                        width: 90,
                        height: 90,
                        child: u!.imageProfile,
                      )),
                ),
              ],
            )));
  }
}

uploadProfilePic() async {
  // recupera file dal file system com ByteData
  final byteData = await rootBundle.load('images/marge.jpeg');

  // se l'utente dà il permesso per l'accesso ai file
  if (await Permission.storage.request().isGranted) {
    // prendi l'indirizzo della cache
    String tempPath = (await getTemporaryDirectory()).path;
    // crea il file nella cache
    File file = await File('$tempPath/profile.jpeg').create();
    // trascrivi nel file i ByteData
    final toupload = await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    // punta a un percorso nel cloud storage
    final path = "users/${u!.phoneNumber}/images/profile.jpg";
    final ref = FirebaseStorage.instance.ref().child(path);
    // carica il file
    ref.putFile(toupload);
  }
}
