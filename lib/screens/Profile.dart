// ignore_for_file: file_names, prefer_const_constructors
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
  static List<Review> listReviews = [Review(1,"Bravo",User('Marge', 'Simpson', "383965213", File("images/marge.jpeg"), false)),
    Review(5,"bella",User('Pippo', 'Simpson', "383965213", File("images/ride.jpeg"), false))];

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
                      Text(Profile.user.getReviewRating()),
                      IconButton(
                        icon: const Icon(Icons.star,
                            color: Color.fromRGBO(255, 183, 3, 1)),
                        onPressed: () {
                          _showReviews(Profile.user.imageProfile);
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
      setState(() {
        Profile.user.imageProfile = File(pickedImage.path);
      });
    }
  }

  Future<void> _openDocumentPicker(bool typeDoc) async {
    final picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.camera);
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


  void _showReviews(File imageProfile) {
    showDialog(
        context: context,
        builder: (_) => Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.all(10),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                    width: deviceWidth * 0.9,
                    height: deviceHeight * 0.8,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("images/sfondoreview.png"),
                            fit: BoxFit.fill)),
                    padding: const EdgeInsets.fromLTRB(0, 45, 12, 250),
                    alignment: Alignment.center,

                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [ 
                      // ignore: prefer_const_constructors, duplicate_ignore
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      Card(
                      margin:const EdgeInsets.fromLTRB(10, 0, 0, 10),
                  // ignore: prefer_const_constructors
                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(children: 
                      [
                      const Padding(padding: EdgeInsets.only(top: 3)),
                       Row( mainAxisAlignment: MainAxisAlignment.center,
                       
                       children: [
                      Text('${Profile.user.getReviewRating()}/5', style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
                       const Padding(padding: EdgeInsets.only(right: 3)),
                       Icon(Icons.star,
                       size: 50,
                            color: const Color.fromRGBO(255, 183, 3, 1))]),
                      const Padding(padding: EdgeInsets.all(3)),
                      Center(child: Text('Average rating', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
                      Text('Based on the opinions of ${Profile.listReviews.length} users', style: const TextStyle(fontSize: 15, 
                      fontWeight: FontWeight.bold, color: Colors.black38)),
                      const Padding(padding: EdgeInsets.all(3))
                      ],
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    const Text("Reviews",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center),
                        const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10)),
                        for (var reviews in Profile.listReviews)
                          Card(
                            margin:const EdgeInsets.fromLTRB(10, 0, 0, 10),
                            shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                    ),
                            child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                    child: ClipOval(
                                    child: Material(
                                    color: Colors.transparent,
                                    child: Ink.image(
                                        image: FileImage(reviews.getUser().imageProfile),
                                        fit: BoxFit.cover,
                                        width: 30,
                                        height: 30,

                                    ),),),),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(0,2,0,2),
                                        child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(reviews.getUser().name,
                                                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                          ),
                                          Padding(padding: EdgeInsets.only(bottom: deviceHeight * 0.02)),
                                          Text((reviews.description.length > 10) ? "${reviews.description.substring(0,10)}..." : reviews.description,
                                                style: const TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                                                ),
                                            ],
                                            ),
                                    ),
                                    Row(children: [
                                          for (int i = 0; i < 5; i++) 
                                          Icon(Icons.star,
                                          color: (i < reviews.voto) ?
                                                const Color.fromRGBO(255, 183, 3, 1): 
                                                Colors.grey)
                                        ],
                                    ),
                                ],
                             ),        
                 ),])),
                 Positioned(
                  top: -65,
                  child: CircleAvatar(
                      backgroundColor: const Color.fromRGBO(255, 178, 3, 1),
                      radius: 60,
                      child: CircleAvatar(
                        backgroundImage: FileImage(imageProfile),
                        radius: deviceWidth * 0.140,
                      )),
                ),
               
              ],
            )));
  }
}
