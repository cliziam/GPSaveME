import 'dart:typed_data';

import 'package:firebase_core/firebase_core.dart';
import 'package:first_prj/screens/AroundYou.dart';
import 'package:flutter/material.dart';
import 'package:first_prj/screens/HomePage.dart';
//import 'package:first_prj/screens/HomePage2.dart';
import 'package:first_prj/screens/Profile.dart';
import 'package:location/location.dart';
import 'package:first_prj/screens/Login.dart';
// import 'package:first_prj/screens/Login.dart'; // da scommentare
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

import 'models/User.dart';

double deviceWidth = 0, deviceHeight = 0;
User user = User('Marge', 'Simpson', '339862948',
    Image.memory(Uint8List.fromList([])), false, 0, 0);
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  static int coins = 3;
  static int selectedIndex = 0;

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return MaterialApp(
      title: "GPSaveMe",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Login(),
    );
  }

  static void navigateToNextScreen(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const HomePage()));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          getLocation();
          return AroundYou();
        }));
        break;
      case 2:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const Profile()));
        break;
    }
  }
}

Future<bool> getLocation() async {
  Location location = Location();
  bool serviceEnabled;
  PermissionStatus permissionGranted;

  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return false;
    }
  }

  permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      return false;
    }
  }
  LocationData locationData = await location.getLocation();
  user.latitude = locationData.latitude!;
  user.longitude = locationData.longitude!;

  return true;
}

//Future<String> loadAsset() async {
//  return await rootBundle.loadString('storage/prova.txt');
//}
