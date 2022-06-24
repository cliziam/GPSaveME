//import 'package:flutter/cupertino.dart';
// ignore_for_file: file_names
import 'package:flutter/material.dart';

import 'Status.dart';
//import 'package:first_prj/main.dart';
//import '../screens/HomePage.dart';
//import 'Status.dart';

class AlertAroundYouPending extends StatefulWidget {
  const AlertAroundYouPending({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AlertAroundYouPendingState createState() => _AlertAroundYouPendingState();
}

class _AlertAroundYouPendingState extends State<AlertAroundYouPending> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 8,
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 1.3,
        height: MediaQuery.of(context).size.height / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Icon(Status.waitingAcceptOrRefuse? Icons.pending_outlined: Icons.warning_amber_rounded,
                color:Status.waitingAcceptOrRefuse? Colors.green: Colors.red, size: 100.0),
            // ignore: prefer_const_constructors
            Column(
              children: [
                Text(
                  Status.waitingHelp? "You can't help someone if you have a pending help request!": "Refresh the page to see if the user accepted your help",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
