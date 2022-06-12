import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';
import 'package:first_prj/screens/ConfirmRequest.dart';

void main() => runApp(MyApp());

Map<String, Map<int, String>> dict = {
  "Transport": {0: "Puncture", 1: "Fuel", 2: "Ride", 3: "Other"},
  "Health": {0: "Meds", 1: "Injury", 2: "Other"},
  "Safety": {0: "Stalking", 1: "Wild animals", 2: "Boh", 3: "Other"},
  "House": {0: "Shopping", 1: "Furniture", 2: "Spendings", 3: "Other"},
  "General": {0: "Boh", 1: "Boh", 2: "Boh", 3: "Other"}
};

class MyApp extends StatelessWidget {
  static int coins = 3;

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "GPSaveMe",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  final String title = "GPSaveMe";
  static int coins = 3;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 25)),
        actions: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Tooltip(
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              children: <Widget>[
                Text(
                  'Ask for help',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                Tooltip(
                  message: "Send a help request!",
                  triggerMode: TooltipTriggerMode.tap,
                  child: Icon(Icons.add_alert_sharp, color: Colors.white60),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MyCard('assets/images/Car.png', "Transport"),
              MyCard('assets/images/Heart.png', "Health"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MyCard('assets/images/Alert.png', "Safety"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MyCard('assets/images/House.png', "House"),
              MyCard('assets/images/General.png', "General"),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromRGBO(255, 183, 3, 1),
        selectedItemColor: const Color.fromRGBO(33, 158, 188, 1),
        unselectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          _navigateToNextScreen(context, index);
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

class MyCard extends StatelessWidget {
  String path = "";
  String text = "";
  MyCard(String path, String text) {
    this.path = path;
    this.text = text;
  }
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (_) => ImageDialog(text, path));
      },
      child: Card(
        shape: CircleBorder(),
        color: Colors.yellow[200],
        child: Container(
            height: 120,
            width: 120,
            child: Column(children: [
              Image(
                image: AssetImage(path),
                height: 85,
                width: 85,
              ),
              Text(text, style: TextStyle(fontSize: 20)),
            ])),
      ),
    );
  }
}

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
                  MyApp2(t, i, e, act)),
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
                MyApp2(t, i, e, act)),
      );
      // Navigator.pop(context);
    }
  }

  Widget build(BuildContext context) {
    MyRow_1 riga_1 = MyRow_1(emergency, path);
    MyRow_2 riga_2 = MyRow_2(emergency);
    int clickato = _MyRow_2.clickato;
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
                  if (!_isActive_pri2) {
                    _isActive_pri2 = true;
                    _isActive_pri1 = false;
                    _isActive_pri3 = false;
                    setState(() => _color_2_pri = Colors.yellow[800]);
                    setState(() => _color_1_pri = Colors.grey[300]);
                    setState(() => _color_3_pri = Colors.grey[300]);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: _color_2_pri,
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
                          color: Colors.yellow,
                        ),
                      ),
                      Text(
                        "Medium",
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

class MyRow_1 extends StatelessWidget {
  String emergenza = "";
  String path = "";
  MyRow_1(String emergenza, String path) {
    this.emergenza = emergenza;
    this.path = path;
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          emergenza,
          style: TextStyle(fontSize: 25),
        ),
        Image(
          image: AssetImage(path),
          height: 70,
          width: 70,
        ),
        InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.close)),
      ],
    );
  }
}

class MyRow_2 extends StatefulWidget {
  String emergency = "";
  int cont = 0;
  MyRow_2(String emergency) {
    this.emergency = emergency;
  }
  @override
  _MyRow_2 createState() => _MyRow_2(emergency);
}

class _MyRow_2 extends State<MyRow_2> {
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
  static int clickato = -1;
  _MyRow_2(String emergency) {
    this.emergency = emergency;
  }

  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: () {
            if (!isActive1) {
              clickato = 0;
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
                            ? AssetImage("assets/images/Puncture.png")
                            : (emergency == "Health")
                                ? AssetImage("assets/images/Panizzi.png")
                                : (emergency == "Safety")
                                    ? AssetImage("assets/images/Panizzi.png")
                                    : (emergency == "House")
                                        ? AssetImage(
                                            "assets/images/Panizzi.png")
                                        : AssetImage(
                                            "assets/images/Panizzi.png"),
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
              clickato = 1;
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
                            ? AssetImage("assets/images/Fuel.png")
                            : (emergency == "Health")
                                ? AssetImage("assets/images/Panizzi.png")
                                : (emergency == "Safety")
                                    ? AssetImage("assets/images/Panizzi.png")
                                    : (emergency == "House")
                                        ? AssetImage(
                                            "assets/images/Panizzi.png")
                                        : AssetImage(
                                            "assets/images/Panizzi.png"),
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
              clickato = 2;
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
                        ? AssetImage("assets/images/Ride.png")
                        : (emergency == "Health")
                            ? AssetImage("assets/images/Panizzi.png")
                            : (emergency == "Safety")
                                ? AssetImage("assets/images/Panizzi.png")
                                : (emergency == "House")
                                    ? AssetImage("assets/images/Panizzi.png")
                                    : AssetImage("assets/images/Panizzi.png"),
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
              clickato = 3;
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
                        ? AssetImage("assets/images/Other.png")
                        : (emergency == "Health")
                            ? AssetImage("assets/images/Panizzi.png")
                            : (emergency == "Safety")
                                ? AssetImage("assets/images/Panizzi.png")
                                : (emergency == "House")
                                    ? AssetImage("assets/images/Panizzi.png")
                                    : AssetImage("assets/images/Panizzi.png"),
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

void _navigateToNextScreen(BuildContext context, int index) {
  switch (index) {
    case 0:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePage()));
      break;
    case 1:
      //Navigator.of(context)
      //    .push(MaterialPageRoute(builder: (context) => ()));
      break;
    case 2:
      //Navigator.of(context)
      //    .push(MaterialPageRoute(builder: (context) => ()));
      break;
  }
}
