import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';
import 'package:first_prj/main.dart';
import 'package:first_prj/models/RequestDeleted.dart';

class RequestDone extends StatefulWidget {
  String tempo = "";
  String input = "";
  String emergency = "";
  var tipo = "";
  RequestDone(String tempo, String input, String emergency, var tipo) {
    this.tempo = tempo;
    this.input = input;
    this.emergency = emergency;
    this.tipo = tipo;
  }
  @override
  _RequestDone createState() => _RequestDone(tempo, input, emergency, tipo);
}

class _RequestDone extends State<RequestDone> {
  String tempo = "";
  String input = "";
  String emergency = "";
  var tipo = "";
  _RequestDone(String tempo, String input, String emergency, var tipo) {
    this.tempo = tempo;
    this.input = input;
    this.emergency = emergency;
    this.tipo = tipo;
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog<String>(
        context: context,
        builder: (BuildContext context) => new AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Container(
            width: 250,
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(emergency, style: TextStyle(fontSize: 30)),
                    Container(
                      width: 80,
                      height: 40,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: (emergency == "Transport")
                                  ? AssetImage('images/Car.png')
                                  : (emergency == "Health")
                                      ? AssetImage('images/health.png')
                                      : (emergency == "Safety")
                                          ? AssetImage('images/Alert.png')
                                          : (emergency == "House")
                                              ? AssetImage('images/house.png')
                                              : AssetImage('images/hands.png'),
                              scale: 1)),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 80,
                      height: 40,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: (tipo == "Puncture")
                                  ? AssetImage('images/Puncture.png')
                                  : (tipo == "Fuel")
                                      ? AssetImage('images/fuel.png')
                                      : (emergency == "Ride")
                                          ? AssetImage('images/Ride.png')
                                          : (emergency == "Other")
                                              ? AssetImage('images/Other.png')
                                              : AssetImage(
                                                  'images/Panizzi.png'),
                              scale: 1)),
                    ),
                    Text(input, style: TextStyle(fontSize: 20)),
                  ],
                ),
                Text(
                  "Time selected: " + tempo,
                  style: TextStyle(fontSize: 20),
                ),
                ElevatedButton(
                  child: new Text("DELETE REQUEST"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (
                        context,
                      ) =>
                              RequestDeleted(tempo, input, emergency, tipo)),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    MyApp app = new MyApp();
    return app.build(context);
  }
}