import 'package:first_prj/screens/AroundYou.dart';
import 'package:flutter/material.dart';
import 'package:first_prj/screens/HomePage.dart';
import 'package:first_prj/screens/Profile.dart';
import 'package:location/location.dart';

double deviceWidth = 0, deviceHeight = 0;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static int coins = 3;
  static int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "GPSaveMe",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }

  static void navigateToNextScreen(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HomePage()));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          getLocation();
          return AroundYou();
        }));
        break;
      case 2:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Profile()));
        break;
    }
  }
}

Future<bool> getLocation() async {
  Location location = Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return false;
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return false;
    }
  }
  return true;
}
