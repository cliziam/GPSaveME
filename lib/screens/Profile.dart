// ignore_for_file: file_names
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_prj/screens/AroundYou.dart';
import 'package:flutter/material.dart';
import 'package:first_prj/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:first_prj/screens/SignUpNumber.dart';

import '../models/Status.dart';

class Profile extends StatefulWidget {
  final String title = "GPSaveMe";

  const Profile({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      CircleAvatar(
                        radius: deviceWidth * 0.15,
                        backgroundColor: Colors.transparent,
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(deviceWidth * 0.15),
                          child: u!.imageProfile,
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
                                color: const Color.fromRGBO(255, 183, 3, 1)),
                            child: InkWell(
                              onTap: () => _openImagePicker(),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 8,
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
                      Text(u!.reviewMean,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black38)),
                      IconButton(
                        icon: const Icon(Icons.star,
                            color: Color.fromRGBO(255, 183, 3, 1)),
                        onPressed: () async {
                          var reviews = await u!.getReviews();
                          _showReviews(u!.imageProfile, reviews);
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
              u!.profileCheck
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
            alignment: Alignment.centerLeft,
            child: SizedBox(
                width: MediaQuery.of(context).size.width - deviceWidth * 0.125,
                height: deviceWidth * 0.11,
                child: ElevatedButton(
                  onPressed: () async {
                    u!.frontCheck ? null : _openDocumentPicker(true);
                  },
                  style: u!.frontCheck
                      ? ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey[300]),
                          elevation: MaterialStateProperty.all(0.0),
                          splashFactory: NoSplash.splashFactory)
                      : ElevatedButton.styleFrom(
                          primary: const Color.fromRGBO(255, 183, 3, 1)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Upload front document",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black)),
                      //   Padding(padding: EdgeInsets.only(left: deviceWidth * 0.38)),
                      u!.frontCheck
                          ? const Icon(Icons.access_time, color: Colors.black)
                          : const Icon(Icons.add, color: Colors.black)
                    ],
                  ),
                )),
          ),
          Container(
            constraints: BoxConstraints(maxWidth: deviceWidth * 1),
            padding: EdgeInsets.all(deviceWidth * 0.03),
            alignment: Alignment.centerLeft,
            child: SizedBox(
                width: MediaQuery.of(context).size.width - deviceWidth * 0.125,
                height: deviceWidth * 0.11,
                child: ElevatedButton(
                  onPressed: () async {
                    u!.retroCheck ? null : _openDocumentPicker(false);
                  },
                  style: u!.retroCheck
                      ? ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey[300]),
                          elevation: MaterialStateProperty.all(0.0),
                          splashFactory: NoSplash.splashFactory)
                      : ElevatedButton.styleFrom(
                          primary: const Color.fromRGBO(255, 183, 3, 1)),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Upload retro document",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.black)),
                        // Padding(padding: EdgeInsets.only(left: deviceWidth * 0.38)),
                        u!.retroCheck
                            ? const Icon(Icons.access_time, color: Colors.black)
                            : const Icon(Icons.add, color: Colors.black)
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
        onTap: (index) async {
          if (MyApp.selectedIndex != index) {
            setState(() {
              MyApp.selectedIndex = index;
            });
            if (index == 1) {
              if (Status.areAllFalse()) {
                await u!.updateLocation();
                await buildRequests();
              } else if (Status.proposalAccepted) {
                await u!.getLocation();
              }
            }
            if (!mounted) return;

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
          u!.frontCheck = true;
        } else {
          // punta a un percorso nel cloud storage
          final path = "users/${u!.phoneNumber}/images/${name}doc.jpg";
          final ref = FirebaseStorage.instance.ref().child(path);
          // carica il file
          ref.putFile(toupload);
          u!.retroCheck = true;
        }
      });
    }
  }

  void _showReviews(Image imageProfile, dynamic reviews) {
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
                    padding: const EdgeInsets.fromLTRB(0, 45, 12, 320),
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: deviceWidth * 0.9,
                      height: deviceHeight * 0.4,
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text("Reviews",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left),
                   for (int i = 0; i < (reviews.length < 2 ? reviews.length : 2); i++)  
                        // ignore: sized_box_for_whitespace
                        Container(
                          
                          height: deviceHeight * 0.08,
                          child: Card( 
                            shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8,2,0,2),
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                           
                          Text(reviews[i][1].length > 20 ? reviews[i][1].substring(0, 20) + "..." : reviews[i][1], overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                          ),
                          ],),

                          ),
                      Row(
                      children: [
                          for (int j = 0; j < 5; j++) Icon(Icons.star,
                      color: (j < reviews[i][0]) ?  const Color.fromRGBO(255, 183, 3, 1) : Colors.grey)],),],
                      ),),
                        ),
                ], ),),
                ),
                Positioned(
                  top: -70,
                  child: CircleAvatar(
                        radius: deviceWidth * 0.15,
                        backgroundColor: Colors.transparent,
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(deviceWidth * 0.15),
                          child: u!.imageProfile,
                        ),),
                ),

              ],
            )));
  }  
}
