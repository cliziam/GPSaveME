import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class SecondRow extends StatefulWidget {
  String emergency = "";
  int cont = 0;
  int clickato = -1;
  SecondRow(String emergency) {
    this.emergency = emergency;
  }

  @override
  _SecondRow createState() => _SecondRow(emergency);

}

class _SecondRow extends State<SecondRow> {
  String emergency = "";
  bool isSwitched = false;
  var _color1 = Colors.white60;
  var _color2 = Colors.white60;
  var _color3 = Colors.white60;
  var _color4 = Colors.white60;
  bool isActive1 = false;
  bool isActive2 = false;
  bool isActive3 = false;
  bool isActive4 = false;


  
  _SecondRow(String emergency) {
    this.emergency = emergency;
  }


  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: () {
            if (!isActive1) {
              super.widget.clickato = 0;
              super.widget.cont += 1;
              setState(() => _color1 = Colors.yellow);
              isActive1 = true;
              isActive2 = false;
              isActive3 = false;
              isActive4 = false;
              setState(() => _color2 = Colors.white60);
              setState(() => _color3 = Colors.white60);
              setState(() => _color4 = Colors.white60);
            }
            ;
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: _color1,
            child: Container(
                height: 70,
                width: 70,
                child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: (emergency == "Transport")
                            ? AssetImage("images/Puncture.png")
                            : (emergency == "Health")
                                ? AssetImage("images/Panizzi.png")
                                : (emergency == "Safety")
                                    ? AssetImage("images/Panizzi.png")
                                    : (emergency == "House")
                                        ? AssetImage("images/Panizzi.png")
                                        : AssetImage("images/Panizzi.png"),
                        height: 50,
                        width: 50,
                      ),
                      Text(
                          (emergency == "Transport")
                              ? "Puncture"
                              : (emergency == "Health")
                                  ? "Meds"
                                  : (emergency == "Safety")
                                      ? "Stalking"
                                      : (emergency == "House")
                                          ? "Spendings"
                                          : "Boh",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                    ])),
          ),
        ),
        InkWell(
          onTap: () {
            if (!isActive2) {
              super.widget.clickato = 1;
              super.widget.cont += 1;
              setState(() => _color2 = Colors.yellow);
              isActive2 = true;
              isActive1 = false;
              isActive3 = false;
              isActive4 = false;
              setState(() => _color1 = Colors.white60);
              setState(() => _color3 = Colors.white60);
              setState(() => _color4 = Colors.white60);
            }
            ;
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: _color2,
            child: Container(
                height: 70,
                width: 70,
                child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: (emergency == "Transport")
                            ? AssetImage("images/fuel.png")
                            : (emergency == "Health")
                                ? AssetImage("images/Panizzi.png")
                                : (emergency == "Safety")
                                    ? AssetImage("images/Panizzi.png")
                                    : (emergency == "House")
                                        ? AssetImage("images/Panizzi.png")
                                        : AssetImage("images/Panizzi.png"),
                        height: 50,
                        width: 50,
                      ),
                      Text(
                          (emergency == "Transport")
                              ? "Out of fuel"
                              : (emergency == "Health")
                                  ? "Boh"
                                  : (emergency == "Safety")
                                      ? "Boh"
                                      : (emergency == "House")
                                          ? "Boh"
                                          : "Boh",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                    ])),
          ),
        ),
        InkWell(
          onTap: () {
            if (!isActive3) {
              super.widget.clickato = 2;
              super.widget.cont += 1;
              setState(() => _color3 = Colors.yellow);
              isActive3 = true;
              isActive1 = false;
              isActive2 = false;
              isActive4 = false;
              setState(() => _color1 = Colors.white60);
              setState(() => _color2 = Colors.white60);
              setState(() => _color4 = Colors.white60);
            }
            ;
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: _color3,
            child: Container(
                height: 70,
                width: 70,
                child: Column(children: [
                  Image(
                    image: (emergency == "Transport")
                        ? AssetImage("images/Ride.png")
                        : (emergency == "Health")
                            ? AssetImage("images/Panizzi.png")
                            : (emergency == "Safety")
                                ? AssetImage("images/Panizzi.png")
                                : (emergency == "House")
                                    ? AssetImage("images/Panizzi.png")
                                    : AssetImage("images/Panizzi.png"),
                    height: 50,
                    width: 50,
                  ),
                  Text(
                      (emergency == "Transport")
                          ? "Take a ride"
                          : (emergency == "Health")
                              ? "Boh"
                              : (emergency == "Safety")
                                  ? "Boh"
                                  : (emergency == "House")
                                      ? "Boh"
                                      : "Boh",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ])),
          ),
        ),
        InkWell(
          onTap: () {
            if (!isActive4) {
              super.widget.clickato = 3;
              super.widget.cont += 1;
              setState(() => _color4 = Colors.yellow);
              isActive4 = true;
              isActive1 = false;
              isActive2 = false;
              isActive3 = false;
              setState(() => _color1 = Colors.white60);
              setState(() => _color2 = Colors.white60);
              setState(() => _color3 = Colors.white60);
            }
            ;
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: _color4,
            child: Container(
                height: 70,
                width: 70,
                child: Column(children: [
                  Image(
                    image: (emergency == "Transport")
                        ? AssetImage("images/Other.png")
                        : (emergency == "Health")
                            ? AssetImage("images/Panizzi.png")
                            : (emergency == "Safety")
                                ? AssetImage("images/Panizzi.png")
                                : (emergency == "House")
                                    ? AssetImage("images/Panizzi.png")
                                    : AssetImage("images/Panizzi.png"),
                    height: 50,
                    width: 50,
                  ),
                  Text("Other",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ])),
          ),
        ),
      ],
    );
  }
}