import 'package:firebase_core/firebase_core.dart';
import 'package:first_prj/screens/AroundYou.dart';
import 'package:first_prj/screens/Profile.dart';
import 'package:first_prj/screens/SignUpNumber.dart';
import 'package:flutter/material.dart';
import 'package:first_prj/screens/HomePage.dart';
import 'package:location/location.dart';
import 'package:first_prj/screens/Login.dart';
import 'dart:async' show Future;
import 'package:nfc_manager/nfc_manager.dart';

double deviceWidth = 0, deviceHeight = 0;

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
          return const AroundYou();
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
  u!.updateLocation();

  return true;
}

Future<bool> isNFCAvailable() async {
  // Check availability
  bool b = await NfcManager.instance.isAvailable();
  return b;
}

Future<bool> getNFC() async {
  ValueNotifier<dynamic> result = ValueNotifier(null);
  // Start Session
  //print("STO STARTANDO LA SESSIONE...");
  NfcManager.instance.startSession(
    onDiscovered: (NfcTag tag) async {
      // Do something with an NfcTag instance.
      result.value = tag.data;
      //print("PRINT PROVA");
      //print(result.value);
    },
  );

  return false;
}


//Future<String> loadAsset() async {
//  return await rootBundle.loadString('storage/prova.txt');
//}
