// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:first_prj/main.dart';
import 'package:first_prj/models/RequestDeleted.dart';

// ignore: must_be_immutable
class RequestDeletedPage extends StatefulWidget {
  String tempo = "";
  String input = "";
  String emergency = "";
  var tipo = "";
  RequestDeletedPage(String tempo, String input, String emergency, var tipo,
      {Key? key})
      : super(key: key) {
    // ignore: prefer_initializing_formals
    this.tempo = tempo;
    // ignore: prefer_initializing_formals
    this.input = input;
    // ignore: prefer_initializing_formals
    this.emergency = emergency;
    // ignore: prefer_initializing_formals
    this.tipo = tipo;
  }
  @override
  // ignore: library_private_types_in_public_api
  _RequestDeletedPage createState() =>
      // ignore: no_logic_in_create_state
      _RequestDeletedPage(tempo, input, emergency, tipo);
}

class _RequestDeletedPage extends State<RequestDeletedPage> {
  String tempo = "";
  String input = "";
  String emergency = "";
  var tipo = "";
  _RequestDeletedPage(this.tempo, this.input, this.emergency, this.tipo);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          // ignore: sized_box_for_whitespace
          content: Container(
            width: 250,
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
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
                      // ignore: sort_child_properties_last
                      child: const Text("CANCEL"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (
                            context,
                          ) =>
                                  RequestDeleted(
                                      tempo, input, emergency, tipo)),
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
                      // ignore: sort_child_properties_last
                      child: const Text("CONFIRM"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (
                            context,
                          ) =>
                                  const MyApp()),
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
    MyApp app = const MyApp();
    return app.build(context);
  }
}
