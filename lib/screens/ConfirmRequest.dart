import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:first_prj/main.dart';
import 'DeleteRequest.dart';

class MyApp2 extends StatelessWidget {
  String tempo = "";
  String input = "";
  String emergency = "";
  var tipo = "";
  MyApp2(String tempo, String input, String emergency, var tipo) {
    this.tempo = tempo;
    this.input = input;
    this.emergency = emergency;
    this.tipo = tipo;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "GPSaveMe",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Ao(tempo, input, emergency, tipo),
    );
  }
}

class Ao extends StatefulWidget {
  String tempo = "";
  String input = "";
  String emergency = "";
  var tipo = "";
  Ao(String tempo, String input, String emergency, var tipo) {
    this.tempo = tempo;
    this.input = input;
    this.emergency = emergency;
    this.tipo = tipo;
  }
  @override
  _Ao createState() => _Ao(tempo, input, emergency, tipo);
}

class _Ao extends State<Ao> {
  String tempo = "";
  String input = "";
  String emergency = "";
  var tipo = "";
  _Ao(String tempo, String input, String emergency, var tipo) {
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
                                  ? AssetImage('assets/images/Car.png')
                                  : (emergency == "Health")
                                      ? AssetImage('assets/images/Heart.png')
                                      : (emergency == "Safety")
                                          ? AssetImage(
                                              'assets/images/Alert.png')
                                          : (emergency == "House")
                                              ? AssetImage(
                                                  'assets/images/House.png')
                                              : AssetImage(
                                                  'assets/images/General.png'),
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
                                  ? AssetImage('assets/images/Puncture.png')
                                  : (tipo == "Fuel")
                                      ? AssetImage('assets/images/Fuel.png')
                                      : (emergency == "Ride")
                                          ? AssetImage('assets/images/Ride.png')
                                          : (emergency == "Other")
                                              ? AssetImage(
                                                  'assets/images/Other.png')
                                              : AssetImage(
                                                  'assets/images/Panizzi.png'),
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
                              MyApp3(tempo, input, emergency, tipo)),
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
