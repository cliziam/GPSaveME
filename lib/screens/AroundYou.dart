// ignore_for_file: file_names
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:first_prj/models/User.dart';
import 'package:flutter/material.dart';
import 'package:first_prj/main.dart';
import 'package:first_prj/models/Request.dart';
import '../models/AlertAroundYouPending.dart';
import '../models/Status.dart';

class AroundYou extends StatefulWidget {
  final String title = "GPSaveMe";
  User user= User('Marge', 'Simpson', '339862948',
            Image.memory(Uint8List.fromList([])), false, 0, 0);
  static List<Request> requestList = [
    Request(
        0,
        3,
        REQUEST_TYPE.transportation,
        'out of fuel',
        User('Marge', 'Simpson', '339862948',
            Image.memory(Uint8List.fromList([])), false, 41.908236221281534, 12.535103079414553),
        "images/fuel.png"),
    Request(
        1,
        2,
        REQUEST_TYPE.health,
        'need a med',
        User('Chiara', 'Griffin', '392164553',
            Image.memory(Uint8List.fromList([])), false,41.908236221281534, 12.535103079414553),
        "images/fuel.png")
  ];

  AroundYou({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _AroundYouState createState() => _AroundYouState();
}

class _AroundYouState extends State<AroundYou> {
  final GlobalKey<AnimatedListState> _key = GlobalKey();
  bool accepted= false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        automaticallyImplyLeading: false,
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
        children: <Widget>[
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
                Text('Help requests around you',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.white,
                    )),
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(
                  0, deviceWidth * 0.02, 0, deviceWidth * 0.01)),
          InkWell(
              child: Container(
                width: deviceWidth * 0.6,
                height: deviceHeight * 0.07,
                // ignore: sort_child_properties_last
                child: 
                  Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    const Text('Refresh',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.white,
                        )),
                    Padding(padding: EdgeInsets.only(left: deviceWidth * 0.13)),
                    const Icon(Icons.refresh),
                    Padding(
                        padding: EdgeInsets.only(right: deviceWidth * 0.03)),
                  ],
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromRGBO(255, 183, 3, 1)),
              ),
              onTap: () async {
                // ignore: avoid_print
                if (accepted) print("Refreshing...");
              }),
           if (!Status.requestDone)...[
            Expanded(
            child: AnimatedList(
                key: _key,
                initialItemCount: AroundYou.requestList.length,
                padding: const EdgeInsets.all(10),
                itemBuilder: (context, index, animation) {
                  return _buildItem(
                      AroundYou.requestList[index], animation, index);
                }),
           )
          ]else...[
            const Padding(padding: EdgeInsets.all(10)), const AlertAroundYouPending()]
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
          if(index==1){
             accepted=await getLocation();
          }
       
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            
              icon: Icon(Icons.gps_fixed), 
              label: 'Around You'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
        ],
      ),
    );
  }

  Widget _buildItem(Request item, Animation<double> animation, int index) {
    return SizeTransition(
      key: UniqueKey(),
      sizeFactor: animation,
      child: Card(
        margin: const EdgeInsets.all(10),
        elevation: 2,
        color: const Color.fromRGBO(222, 240, 248, 1),
        child: ListTile(
          onTap: () {
            _offerHelp(context, item);
          },
          contentPadding: const EdgeInsets.all(15),
          title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(AroundYou.requestList[index].getName(),
                    style: const TextStyle(fontSize: 16)),
                Row(
                  children: <Widget>[
                    Text(AroundYou.requestList[index].getUser().reviewMean),
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                    )
                  ],
                )
              ]),
          trailing: Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AroundYou.requestList[index].getPriority() == 1
                      ? Colors.green
                      : AroundYou.requestList[index].getPriority() == 2
                          ? Colors.yellow
                          : AroundYou.requestList[index].getPriority() == 3
                              ? Colors.red
                              : Colors.black,
                  shape: BoxShape.circle),
              child: SizedBox(
                  width: 40,
                  height: 40,
                  child: Image.asset(
                    getPath(AroundYou.requestList[index].getType()),
                  ))),
          leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset("images/distance.png", width: 40, height: 40),
                const Text("200m"),
              ]),
        ),
      ),
    );
  }

  String getPath(REQUEST_TYPE requestType) {
    String path = requestType == REQUEST_TYPE.house
        ? "images/house.png"
        : requestType == REQUEST_TYPE.transportation
            ? "images/car.png"
            : requestType == REQUEST_TYPE.health
                ? "images/health.png"
                : requestType == REQUEST_TYPE.general
                    ? "images/hands.png"
                    : requestType == REQUEST_TYPE.safety
                        ? "images/safety.png"
                        : "images/distance.png";
    return path;
  }

  void _offerHelp(BuildContext context, Request item) async {
   
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0))),
                title: Row(
                  children: <Widget>[
                    SizedBox(
                        width: 40,
                        height: 40,
                        child: Image.asset(
                          item.getImagePath(),
                        )),
                    Padding(
                        padding: EdgeInsets.only(left: deviceWidth * 0.025)),
                    Text(item.getName())
                  ],
                ),
                content:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        item.getDistance(user.latitude, user.longitude, 41.90853481013936, 12.538626627581532)
                        //item.getDistance(user.latitude, user.longitude, AroundYou.requestList[0].getUser().latitude, AroundYou.requestList[0].getUser().longitude),
                      ),
                      Text(" | Request: ${item.getPriorityAsString()}")
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.only(bottom: deviceHeight * 0.02)),
                  Row(
                    children: <Widget>[
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: deviceWidth * 0.01)),
                      Text(item.getUser().reviewMean)
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.only(bottom: deviceHeight * 0.025)),
                  Row(children: const <Widget>[
                    Text(
                      "Description:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ]),
                  Padding(
                      padding: EdgeInsets.only(bottom: deviceHeight * 0.005)),
                  Row(
                    children: <Widget>[
                      Text(
                        item.getDescription(),
                      )
                    ],
                  ),
                ]),
                actions: [
                  TextButton(
                      onPressed: () => {Navigator.pop(context)},
                      child: const Text("CANCEL")),
                  TextButton(
                    onPressed: () {},
                    child: const Text("SEND HELP"),
                  ),
                ],
                actionsAlignment: MainAxisAlignment.spaceEvenly,
              ));
    
  }




}
