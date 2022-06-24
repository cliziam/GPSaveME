//import 'dart:io';
//import 'dart:typed_data';
// ignore_for_file: file_names
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:first_prj/main.dart';
import 'package:first_prj/models/User.dart';
import '../screens/HomePage.dart';
import 'package:first_prj/screens/SignUpNumber.dart';
import 'Status.dart';

class AlertDialogPending extends StatefulWidget {
  const AlertDialogPending({Key? key}) : super(key: key);
  static List<User> helpers = [];
  static List<dynamic> attributes = [];
  @override
  // ignore: library_private_types_in_public_api
  _AlertDialogPendingState createState() => _AlertDialogPendingState();
}

class _AlertDialogPendingState extends State<AlertDialogPending> {
  var attributes = AlertDialogPending.attributes;
  var priority = AlertDialogPending.attributes[0];
  var reqType = AlertDialogPending.attributes[1];
  var reqSubType = AlertDialogPending.attributes[2] == ""
      ? "alert"
      : AlertDialogPending.attributes[2];
  var reqText = AlertDialogPending.attributes[3];

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 8,
        child: SizedBox(
            width: MediaQuery.of(context).size.width / 1.1,
            height: MediaQuery.of(context).size.width / 2.3,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Padding(padding: EdgeInsets.fromLTRB(32, 0, 0, 0)),
                      Text(reqType,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      const Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 0)),
                      SizedBox(
                        width: deviceWidth * 0.1,
                        height: deviceWidth * 0.1,
                        child: Image.asset(
                          reqType == "Transportation"
                              ? "images/car.png"
                              : reqType == "Health"
                                  ? "images/health.png"
                                  : reqType == "House & Gardening"
                                      ? "images/house.png"
                                      : reqType == "General"
                                          ? "images/hands.png"
                                          : "images/safety.png",
                        ),
                      ),
                    ],
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    const Padding(padding: EdgeInsets.fromLTRB(32, 0, 0, 0)),
                    SizedBox(
                      width: deviceWidth * 0.1,
                      height: deviceWidth * 0.1,
                      child: Image.asset(
                        "images/${reqSubType.toLowerCase()}.png",
                      ),
                    ),
                    const Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 0)),
                    Text(reqText,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black38))
                  ]),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromRGBO(33, 158, 188, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    onPressed: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          title: const Text(
                              'Do you want to delete your help request?'),
                          // content: const Text('AlertDialog description'),
                          actions: <Widget>[
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
                                  child: const Text('Cancel'),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary:
                                        const Color.fromRGBO(255, 183, 3, 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                  onPressed: () async {
                                    await u!.deleteRequest();
                                    if (!mounted) return;
                                    Status.waitingHelp = false;
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HomePage()),
                                    ).then((value) => setState(() {}));
                                  },
                                  child: const Text('DELETE'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Text("DELETE REQUEST"),
                  ),
                ])),
      ),
      // ignore: prefer_const_constructors
      Padding(padding: EdgeInsets.fromLTRB(0, deviceHeight * 0.01, 0, deviceHeight * 0.03)),
      Text("See who wants to help you",
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black38)),
      CarouselSlider(
        items: [
          //1st Image of Slider
          for (var helper in AlertDialogPending.helpers)
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
              child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1.1,
                  height: MediaQuery.of(context).size.height / 5,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.transparent,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(40.0),
                              child: helper.imageProfile,
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(left: 0.2)),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${helper.name} ${helper.surname}",
                                  style:
                                      // ignore: prefer_const_constructors
                                      TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),
                              Text(User.getDistance(u!, helper),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black38)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(helper.reviewMean,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black38)),
                                  const Padding(
                                      padding: EdgeInsets.only(right: 5)),
                                  for (int i = 0; i < 5; i++)
                                    Icon(Icons.star,
                                        size: 12,
                                        color: (i <
                                                double.parse(helper.reviewMean)
                                                    .round())
                                            ? const Color.fromRGBO(
                                                255, 183, 3, 1)
                                            : Colors.grey)
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromRGBO(33, 158, 188, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            onPressed: () {
                              u!.rejectRequest(helper.phoneNumber);
                            },
                            child: const Text('REJECT'),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromRGBO(255, 183, 3, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            onPressed: () {
                              u!.acceptRequest(helper.phoneNumber);
                            },
                            child: const Text('ACCEPT'),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
        ],
        //Slider Container properties
        options: CarouselOptions(
          enlargeCenterPage: true,
          autoPlay: true,
          aspectRatio: 15 / 4,
          height: deviceHeight / 4,
          autoPlayCurve: Curves.fastLinearToSlowEaseIn,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          viewportFraction: 0.92,
        ),
      )
    ]);
  }
}
