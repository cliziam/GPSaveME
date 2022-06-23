/*
// ignore_for_file: file_names, prefer_const_constructors, unrelated_type_equality_checks
import 'package:flutter/material.dart';
import 'package:first_prj/main.dart';
import 'package:first_prj/models/HelpCard.dart';
import '../models/Request.dart';
import '../models/Status.dart';
import 'dart:typed_data';
import '../models/AlertDialogPending.dart';
import '../models/User.dart';


class Riepilogo extends StatefulWidget {
  final String title = "GPSaveMe";
  // ignore: non_constant_identifier_names
  
  Riepilogo({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _Riepilogo createState() => _Riepilogo();
}

class _Riepilogo extends State<Riepilogo> {
  @override
  Widget build(BuildContext context) {

  Request helpedRequest = Request(
        0,
        3,
        REQUEST_TYPE.transportation,
        'out of fuel',
        User('Marge', 'Simpson', '339862948',
            Image.memory(Uint8List.fromList([])), false, 41.908236221281534, 
            12.535103079414553),
        "images/fuel.png");
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
            margin: EdgeInsets.all(30),
            child: Column(
            children: [
              
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: 
                [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: Image.asset(
                    "",
                  )),
                 Text("${helpedRequest.getUser().name} ${helpedRequest.getUser().surname}", 
                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                 Icon(Icons.verified, color: helpedRequest.getUser().profileCheck ? Colors.green : Colors.grey),]),
                  Padding(padding: EdgeInsets.all(10),),
                  Row(children: [
                    Text("{rating}"),
                    for (var i = 0; i < 5; i++)
                      Icon(Icons.star, color: i <= 3
                       ? Colors.yellow : Colors.grey)
                  ],),
                
                 Padding(padding: EdgeInsets.all(10),),
                  Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                      Text(
                        // ignore: prefer_interpolation_to_compose_strings
                        "distanza|"
                      ),
                      // ignore: prefer_interpolation_to_compose_strings
                      Padding(padding: EdgeInsets.only(right: 3),),
                      Text("Priority of the request: " + helpedRequest.getPriorityAsString().toLowerCase())
                  ],
                  ),
                  Padding(padding: EdgeInsets.all(10),),
                  Row(children: [Text(helpedRequest.description, style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black38))]),
                  Padding(padding: EdgeInsets.all(10),),
                  Row(children: [FloatingActionButton.extended(
                  label: Row(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(right: 5)),
                      // ignore: prefer_interpolation_to_compose_strings
                      Text("CALL ${helpedRequest.getUser().name.toUpperCase()}"),
                    ],
                  ),
                  backgroundColor: Color.fromARGB(255, 95, 222, 100),
                  icon: const Icon(Icons.local_phone),
                  onPressed: () {})]),
                  SizedBox(
                    width: 200,
                    height: 250,
                  )      
            ],
          )
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary:
                  const Color.fromRGBO(33, 158, 188, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onPressed: () =>
                    Navigator.pop(context, 'Cancel'),
                child: const Text('DISCARD'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary:
                  const Color.fromRGBO(255, 183, 3, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onPressed: () => {},
                child: const Text('ACCEPT'),
              ),
          ],)
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
*/