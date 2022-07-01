// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names
import 'package:first_prj/screens/NFC.dart';
import 'package:flutter/material.dart';
import 'package:first_prj/main.dart';
import '../models/Request.dart';
import '../models/User.dart';
import 'SignUpNumber.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  GoogleMapController? mapController; //contrller for Google map
  Set<Marker> markers = {};
  @override
  void initState() {
    LatLng showLocation = LatLng(widget.helpedRequest.getUser().latitude,
        widget.helpedRequest.getUser().latitude);

    markers.add(Marker(
      //add marker on google map
      markerId: MarkerId(showLocation.toString()),
      position: showLocation, //position of marker
      // ignore: prefer_const_constructors
      infoWindow: InfoWindow(
        //popup info
        title: 'My Custom Title ',
        snippet: "My Custom Subtitle",
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));

    //you can add more markers here
    super.initState();
  }

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
      body: SingleChildScrollView(
          child: Column(
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(deviceHeight * 0.015),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 48,
                            backgroundColor: Colors.transparent,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child:
                                  widget.helpedRequest.getUser().imageProfile,
                            ),
                          ),
                          Column(children: [
                            Row(
                              children: [
                                Text(
                                  "${widget.helpedRequest.getUser().name} ${widget.helpedRequest.getUser().surname}",
                                  // ignore: prefer_const_constructors
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: deviceWidth * 0.02),
                                ),
                                Icon(Icons.verified,
                                    size: 20,
                                    color: widget.helpedRequest
                                            .getUser()
                                            .profileCheck
                                        ? Colors.green
                                        : Colors.grey),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.all(deviceHeight * 0.002),
                            ),
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 10),
                                ),
                                Text(widget.helpedRequest.getUser().reviewMean,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black38)),
                                const Padding(
                                  padding: EdgeInsets.only(right: 8),
                                ),
                                for (var i = 0; i < 5; i++)
                                  Icon(Icons.star,
                                      size: 15,
                                      color: i <
                                              double.parse(widget.helpedRequest
                                                  .getUser()
                                                  .reviewMean)
                                          ? Colors.yellow
                                          : Colors.grey)
                              ],
                            ),
                          ]),
                        ]),
                    const Padding(
                      padding: EdgeInsets.all(15),
                    ),
                    Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: deviceWidth * 0.050),
                        ),
                        Text(
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black38),
                            // ignore: prefer_interpolation_to_compose_strings
                            "${User.getDistance(u!, widget.helpedRequest.getUser())} | "),
                        // ignore: prefer_interpolation_to_compose_strings
                        const Padding(
                          padding: EdgeInsets.only(right: 3),
                        ),
                        // ignore: prefer_interpolation_to_compose_strings
                        Text(
                            // ignore: prefer_interpolation_to_compose_strings
                            "Priority: " +
                                widget.helpedRequest
                                    // ignore: deprecated_member_use_from_same_package
                                    .getPriorityAsString()
                                    .toLowerCase(),
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black38))
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(deviceHeight * 0.008),
                    ),
                    Row(children: [
                      Padding(
                        padding: EdgeInsets.only(left: deviceWidth * 0.050),
                      ),
                      Flexible(
                          child: Text(widget.helpedRequest.description,
                              style: const TextStyle(
                                  fontSize: 17,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black38),
                              overflow: TextOverflow.fade))
                    ]),
                    Padding(
                      padding: EdgeInsets.all(deviceHeight * 0.01),
                    ),
                    Row(children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                      ),
                      FloatingActionButton.extended(
                          label: Row(
                            children: <Widget>[
                              const Padding(padding: EdgeInsets.only(right: 5)),
                              // ignore: prefer_interpolation_to_compose_strings
                              Text(
                                  "CALL ${widget.helpedRequest.getUser().name.toUpperCase()}"),
                            ],
                          ),
                          backgroundColor:
                              const Color.fromARGB(255, 95, 222, 100),
                          icon: const Icon(Icons.local_phone),
                          onPressed: () {})
                    ]),
                    Padding(
                      padding: EdgeInsets.all(deviceHeight * 0.008),
                    ),
                    SizedBox(
                      height: deviceHeight * 0.255,
                      child: GoogleMap(
                        //Map widget from google_maps_flutter package
                        zoomGesturesEnabled: true, //enable Zoom in, out on map
                        // ignore: prefer_const_constructors
                        initialCameraPosition: CameraPosition(
                          //innital position in map
                          // ignore: prefer_const_constructors
                          target:
                              // ignore: prefer_const_constructors
                              LatLng(
                                  widget.helpedRequest.getUser().latitude,
                                  widget.helpedRequest
                                      .getUser()
                                      .longitude), //initial position
                          zoom: 10.0, //initial zoom level
                        ),
                        markers: markers, //markers to show on map
                        mapType: MapType.normal, //map type
                        onMapCreated: (controller) {
                          //       //method called when map is created
                          setState(() {
                            mapController = controller;
                          });
                        },
                      ),
                    ),
                  ])),
          FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => NFC(true)));
            },
            label: const Text("Confirm your help"),
            // ignore: prefer_const_constructors
            backgroundColor: Color.fromRGBO(33, 158, 188, 1),
          )
        ],
      )),
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
