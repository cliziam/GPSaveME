import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:first_prj/main2.dart';
import 'ConfirmRequest.dart';

class MyApp3 extends StatelessWidget {
  String tempo = "";
  String input = "";
  String emergency = "";
  var tipo = "";
  MyApp3(String tempo, String input, String emergency, var tipo) {
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
      home: Ao2(tempo, input, emergency, tipo),
    );
  }
}

class Ao2 extends StatefulWidget {
  String tempo = "";
  String input = "";
  String emergency = "";
  var tipo = "";
  Ao2(String tempo, String input, String emergency, var tipo) {
    this.tempo = tempo;
    this.input = input;
    this.emergency = emergency;
    this.tipo = tipo;
  }
  @override
  _Ao2 createState() => _Ao2(tempo, input, emergency, tipo);
}

class _Ao2 extends State<Ao2> {
  String tempo = "";
  String input = "";
  String emergency = "";
  var tipo = "";
  _Ao2(String tempo, String input, String emergency, var tipo) {
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
                Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Text(
                      "Do you want to delete your help request?",
                      style: TextStyle(fontSize: 30),
                      textAlign: TextAlign.center,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      child: new Text("CANCEL"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (
                            context,
                          ) =>
                                  MyApp2(tempo, input, emergency, tipo)),
                        );
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ))),
                    ),
                    ElevatedButton(
                      child: new Text("CONFIRM"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (
                            context,
                          ) =>
                                  MyApp()),
                        );
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.yellow[700]),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ))),
                    ),
                  ],
                )
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
