import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';
import 'package:first_prj/main.dart';
import 'package:first_prj/models/EnabledGPS.dart';
import 'package:first_prj/models/FirstRow.dart';
import 'package:first_prj/models/SecondRow.dart';

Map<String, Map<int, String>> dict = {
  "Transport": {0: "Puncture", 1: "Fuel", 2: "Ride", 3: "Other"},
  "Health": {0: "Meds", 1: "Boh", 2: "Boh", 3: "Other"},
  "Safety": {0: "Stalking", 1: "Boh", 2: "Boh", 3: "Other"},
  "House": {0: "Spesa", 1: "Boh", 2: "Boh", 3: "Other"},
  "General": {0: "Boh", 1: "Boh", 2: "Boh", 3: "Other"}
};

class ImageDialog extends StatefulWidget {
  String emergency = "";
  String path = "";
  ImageDialog(String emergency, String path) {
    this.emergency = emergency;
    this.path = path;
  }
  @override
  _ImageDialog createState() => _ImageDialog(emergency, path);
}

class _ImageDialog extends State<ImageDialog> {
  String emergency = "";
  String path = "";

  _ImageDialog(String emergency, String path) {
    this.emergency = emergency;
    this.path = path;
  }

  TimeOfDay selectedTime = TimeOfDay.now();
  bool isSwitched = false;
  var _color_1_pri = Colors.grey[300];
  var _color_2_pri = Colors.grey[300];
  var _color_3_pri = Colors.grey[300];
  var _color_help = Colors.grey;
  bool _isActive_pri1 = false;
  bool _isActive_pri2 = false;
  bool _isActive_pri3 = false;
  bool _switch = false;
  bool enable = false;
  final myController = TextEditingController();
  static String time = "";

  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.input,
      confirmText: "CONFIRM",
      cancelText: "NOT NOW",
      helpText: "BOOKING TIME",
    );

    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
      });
    }
  }

  enableGPS(String t, String i, String e, var act) async {
    Location location = new Location();
    bool ison = await location.serviceEnabled();
    if (!ison) {
      //if defvice is off
      bool isturnedon = await location.requestService();
      if (isturnedon) {
        print("GPS device is turned ON");
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (
            context,
          ) =>
                  EnabledGPS(t, i, e, act)),
        );
      } else {
        print("GPS Device is still OFF");
        Navigator.pop(context);
      }
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (
          context,
        ) =>
                EnabledGPS(t, i, e, act)),
      );
      // Navigator.pop(context);
    }
  }

  Widget build(BuildContext context) {
    FirstRow riga_1 = FirstRow(emergency, path);
    SecondRow riga_2 = SecondRow(emergency);
    int clickato = riga_2.clickato;
    
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0))),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            riga_1,
            riga_2,
            TextField(
                textAlign: TextAlign.start,
                controller: myController,
                decoration: InputDecoration(
                    hintText: "Write some info here...",
                    hintStyle:
                        TextStyle(fontSize: 15.0, color: Colors.black54))),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: Colors.black12,
                width: 1.5,
              ))),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Share your number",
                        style:
                            TextStyle(fontSize: 15.0, color: Colors.black54)),
                    Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        if (riga_2.cont > 0) enable = true;
                        setState(() {
                          isSwitched = value;
                          _switch = !_switch;
                        });
                      },
                    ),
                  ]),
            ),
            ElevatedButton(
              onPressed: () {
                _selectTime(context);
                time = selectedTime.format(context).toString();
              },
              child: Text("Choose Duration"),
            ),
            Text("Select the priority",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0, color: Colors.black)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              InkWell(
                onTap: () {
                  if (!_isActive_pri1) {
                    _isActive_pri1 = true;
                    _isActive_pri2 = false;
                    _isActive_pri3 = false;
                    setState(() => _color_1_pri = Colors.yellow[800]);
                    setState(() => _color_2_pri = Colors.grey[300]);
                    setState(() => _color_3_pri = Colors.grey[300]);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: _color_1_pri,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  width: 80,
                  height: 90,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        "High",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
             
              InkWell(
                onTap: () {
                  if (!_isActive_pri3) {
                    _isActive_pri3 = true;
                    _isActive_pri1 = false;
                    _isActive_pri2 = false;
                    setState(() => _color_3_pri = Colors.yellow[800]);
                    setState(() => _color_1_pri = Colors.grey[300]);
                    setState(() => _color_2_pri = Colors.grey[300]);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: _color_3_pri,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  width: 80,
                  height: 90,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green,
                        ),
                      ),
                      Text(
                        "Low",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ]),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("CANCEL",
                          style: TextStyle(color: Colors.blue, fontSize: 16))),
                  FlatButton(
                      onPressed: () {
                        if ((enable || riga_2.cont > 0) &&
                            myController.text != "" &&
                            _switch &&
                            time != "" &&
                            (_isActive_pri1 ||
                                _isActive_pri2 ||
                                _isActive_pri3)) {
                          enableGPS(time, myController.text, emergency,
                              dict[emergency]![clickato]);
                          //Navigator.pop(context);
                        }
                      },
                      child: Text(
                        "REQUEST HELP",
                        style: TextStyle(
                            color: (enable || riga_2.cont > 0) &&
                                    myController.text != "" &&
                                    _switch &&
                                    time != "" &&
                                    (_isActive_pri1 ||
                                        _isActive_pri2 ||
                                        _isActive_pri3)
                                ? Colors.blue
                                : Colors.grey,
                            fontSize: 16),
                      ))
                ])
          ],
        ),
      ),
    );
  }
}

