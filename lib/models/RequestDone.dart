// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:first_prj/main.dart';
import 'package:first_prj/models/RequestDeleted.dart';

// ignore: must_be_immutable
class RequestDone extends StatefulWidget {
  String tempo = "";
  String input = "";
  String emergency = "";
  var tipo = "";
  RequestDone(this.tempo, this.input, this.emergency, this.tipo, {Key? key})
      : super(key: key);
  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _RequestDone createState() => _RequestDone(tempo, input, emergency, tipo);
}

class _RequestDone extends State<RequestDone> {
  String tempo = "";
  String input = "";
  String emergency = "";
  var tipo = "";
  _RequestDone(this.tempo, this.input, this.emergency, this.tipo);
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(emergency, style: const TextStyle(fontSize: 30)),
                    Container(
                      width: 80,
                      height: 40,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: (emergency == "Transport")
                                  ? const AssetImage('images/car.png')
                                  : (emergency == "Health")
                                      ? const AssetImage('images/health.png')
                                      : (emergency == "Safety")
                                          ? const AssetImage('images/alert.png')
                                          : (emergency == "House")
                                              ? const AssetImage(
                                                  'images/house.png')
                                              : const AssetImage(
                                                  'images/hands.png'),
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
                                  ? const AssetImage('images/puncture.png')
                                  : (tipo == "Fuel")
                                      ? const AssetImage('images/fuel.png')
                                      : (emergency == "Ride")
                                          ? const AssetImage('images/ride.png')
                                          : (emergency == "Other")
                                              ? const AssetImage(
                                                  'images/other.png')
                                              : const AssetImage(
                                                  'images/other.png'),
                              scale: 1)),
                    ),
                    Text(input, style: const TextStyle(fontSize: 20)),
                  ],
                ),
                Text(
                  "Time selected: $tempo",
                  style: const TextStyle(fontSize: 20),
                ),
                ElevatedButton(
                  child: const Text("DELETE REQUEST"),
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
    MyApp app = const MyApp();
    return app.build(context);
  }
}
