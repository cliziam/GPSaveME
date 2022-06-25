// ignore_for_file: file_names, prefer_const_constructors, unrelated_type_equality_checks
import 'package:first_prj/screens/NFC.dart';
import 'package:flutter/material.dart';
import 'package:first_prj/main.dart';
import '../models/Request.dart';
import '../models/User.dart';
import 'SignUpNumber.dart';

// ignore: must_be_immutable
class Riepilogo extends StatefulWidget {
  final String title = "GPSaveMe";
  Request helpedRequest;

  // ignore: non_constant_identifier_names

  Riepilogo(this.helpedRequest, {Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _Riepilogo createState() => _Riepilogo();
}

class _Riepilogo extends State<Riepilogo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Text(widget.title,
            textAlign: TextAlign.left, style: const TextStyle(fontSize: 25)),
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
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
                Text(
                  'Request accepted! ',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Card(
              margin: EdgeInsets.all(deviceHeight * 0.025),
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 90,
                          height: 90,
                          child: widget.helpedRequest.getUser().imageProfile,
                        ),
                        Text(
                          "${widget.helpedRequest.getUser().name} ${widget.helpedRequest.getUser().surname}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Icon(Icons.verified,
                            color: widget.helpedRequest.getUser().profileCheck
                                ? Colors.green
                                : Colors.grey),
                      ]),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                      ),
                      Text(widget.helpedRequest.getUser().reviewMean),
                      for (var i = 0; i < 5; i++)
                        Icon(Icons.star,
                            color: i <= 3 ? Colors.yellow : Colors.grey)
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                      ),
                      Text(
                          // ignore: prefer_interpolation_to_compose_strings
                          "${User.getDistance(u!, widget.helpedRequest.getUser())} | "),
                      // ignore: prefer_interpolation_to_compose_strings
                      Padding(
                        padding: EdgeInsets.only(right: 3),
                      ),
                      // ignore: prefer_interpolation_to_compose_strings
                      Text("Priority of the request: " +
                          widget.helpedRequest
                              // ignore: deprecated_member_use_from_same_package
                              .getPriorityAsString()
                              .toLowerCase())
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  Row(children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                    ),
                    Text(widget.helpedRequest.description,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black38))
                  ]),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  Row(children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                    ),
                    FloatingActionButton.extended(
                        label: Row(
                          children: <Widget>[
                            Padding(padding: EdgeInsets.only(right: 5)),
                            // ignore: prefer_interpolation_to_compose_strings
                            Text(
                                "CALL ${widget.helpedRequest.getUser().name.toUpperCase()}"),
                          ],
                        ),
                        backgroundColor: Color.fromARGB(255, 95, 222, 100),
                        icon: const Icon(Icons.local_phone),
                        onPressed: () {})
                  ]),
                  SizedBox(
                    width: deviceWidth * 0.4,
                    height: deviceHeight * 0.1,
                  )
                ],
              )),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: [
          //     ElevatedButton(
          //       style: ElevatedButton.styleFrom(
          //         primary: const Color.fromRGBO(33, 158, 188, 1),
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(20.0),
          //         ),
          //       ),
          //       onPressed: () => Navigator.pop(context, 'Cancel'),
          //       child: const Text('DISCARD'),
          //     ),
          //     ElevatedButton(
          //       style: ElevatedButton.styleFrom(
          //         primary: const Color.fromRGBO(255, 183, 3, 1),
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(20.0),
          //         ),
          //       ),
          //       onPressed: () => {},
          //       child: const Text('ACCEPT'),
          //     ),
          //   ],
          // )
          FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => NFC(true)));
            },
            label: Text("Confirm your help!"),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromRGBO(255, 183, 3, 1),
        selectedItemColor: const Color.fromRGBO(33, 158, 188, 1),
        unselectedItemColor: Colors.white,
        currentIndex: MyApp.selectedIndex,
        onTap: (index) async {
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
}
