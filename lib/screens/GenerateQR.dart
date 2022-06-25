// ignore_for_file: file_names, prefer_const_constructors, unrelated_type_equality_checks

import 'package:first_prj/screens/ScanQrPage.dart';
import 'package:first_prj/screens/SignUpNumber.dart';
import 'package:flutter/material.dart';
import 'package:first_prj/main.dart';
import 'package:qr_flutter/qr_flutter.dart';

// ignore: must_be_immutable
class GenerateQR extends StatefulWidget {
  final String title = "GPSaveMe";
  final qrKey = GlobalKey();
  bool isTheHelper;

  GenerateQR(this.isTheHelper, {Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _GenerateQR createState() => _GenerateQR();
}

class _GenerateQR extends State<GenerateQR> {
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
                  'Scan QR Code!',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(padding: const EdgeInsets.fromLTRB(10, 10, 10, 10)),
          SizedBox(
            width: deviceWidth / 1.2,
            height: deviceHeight / 1.7,
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: //RepaintBoundary is necessary for saving QR to user's phone
                  Column(children: [
                Padding(padding: const EdgeInsets.fromLTRB(10, 10, 10, 10)),
                if (widget.isTheHelper) ...[
                  Center(
                    child: RepaintBoundary(
                      key: widget.qrKey,
                      child: QrImage(
                        data: u!
                            .phoneNumber, //This is the part we give data to our QR
                        //  embeddedImage: , You can add your custom image to the center of your QR
                        //  semanticsLabel:'', You can add some info to display when your QR scanned
                        size: 250,
                        backgroundColor: Colors.white,
                        version:
                            QrVersions.auto, //You can also give other versions
                      ),
                    ),
                  )
                ] else ...[
                  Padding(
                    padding: EdgeInsets.only(top: deviceHeight * 0.25),
                  )
                ],
                if (widget.isTheHelper) ...[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () => {},
                    child: const Text('Let the other person scan this!'),
                  ),
                ] else ...[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () => {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => ScanQrPage()))
                    },
                    child: const Text('Scan QR Code'),
                  ),
                ]
              ]),
            ),
          ),
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
