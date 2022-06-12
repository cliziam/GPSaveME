import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';
import 'package:first_prj/main.dart';
import 'package:first_prj/models/RequestDeleted.dart';

class RequestDeletedPage extends StatefulWidget {
  String tempo = "";
  String input = "";
  String emergency = "";
  var tipo = "";
  RequestDeletedPage(String tempo, String input, String emergency, var tipo) {
    this.tempo = tempo;
    this.input = input;
    this.emergency = emergency;
    this.tipo = tipo;
  }
  @override
  _RequestDeletedPage createState() => _RequestDeletedPage(tempo, input, emergency, tipo);
}

class _RequestDeletedPage extends State<RequestDeletedPage> {
  String tempo = "";
  String input = "";
  String emergency = "";
  var tipo = "";
  _RequestDeletedPage(String tempo, String input, String emergency, var tipo) {
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
                                  RequestDeleted(tempo, input, emergency, tipo)),
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
