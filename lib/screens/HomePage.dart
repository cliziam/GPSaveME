// ignore_for_file: file_names
import 'package:first_prj/screens/AroundYou.dart';
import 'package:flutter/material.dart';
import 'package:first_prj/main.dart';
import 'package:first_prj/models/HelpCard.dart';
import '../models/Status.dart';
import '../models/AlertDialogPending.dart';
import 'package:first_prj/screens/SignUpNumber.dart';

import '../models/User.dart';

class HomePage extends StatefulWidget {
  final String title = "GPSaveMe";

  const HomePage({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var refreshColor = const Color.fromRGBO(255, 183, 3, 1);
  List<User> users = [];

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
                  'Ask for help ',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                Tooltip(
                  message: "Select a card below to ask for help!",
                  triggerMode: TooltipTriggerMode.tap,
                  child: Icon(Icons.add_alert_sharp,
                      color: Colors.white60, size: 24.0),
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.only(top: Status.waitingHelp ? 5 : 20)),
          if (Status.waitingHelp) 
          InkWell(
              child: Container(
                width: deviceWidth * 0.6,
                height: deviceHeight * 0.07,
                // ignore: sort_child_properties_last
                child: Row(
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
                    color: refreshColor),
              ),
              onTap: () async {
                users = await u!.checkForHelp();
              }),
          const Padding(padding: EdgeInsets.only(top: 5)),
          if (Status.areAllFalse()) ...[
            HelpCard("images/car.png", "Transportation", false),
            HelpCard("images/health.png", "Health", false),
            HelpCard("images/house.png", "House & Gardening", false),
            HelpCard("images/hands.png", "General", false),
          ] else ...[
            if(Status.waitingHelp)...[
            FutureBuilder(
              builder: (context, AsyncSnapshot<String> text) {
                return const AlertDialogPending();
              },
              future: alertDialogPendingWrapper(),
            )
            ]
            else...[
                  Card(
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
                              const Icon( Icons.warning_amber_rounded,
                                  color: Colors.red, size: 100.0),
                              // ignore: prefer_const_constructors
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                   "You can't ask for help if you sent help to someone",
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )

            ]
            
          ]
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
            if (index == 1) {
              await buildRequests();
            } else if (index == 2) {
              await u!.getReviewRating();
            }
            // ignore: use_build_context_synchronously
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
      floatingActionButton: !Status.areAllFalse()
          ? null
          : FloatingActionButton.extended(
              label: Row(
                children: const <Widget>[
                  Padding(padding: EdgeInsets.only(right: 5)),
                  Text("Send a danger request"),
                ],
              ),
              backgroundColor: Colors.red,
              onPressed: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('DANGER REQUEST'),
                    content: const Text(
                        'Are you sure you want to send a danger request?'),
                    actions: <Widget>[
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
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromRGBO(255, 183, 3, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            child: const Text('YES'),
                            onPressed: () => {
                              AlertDialogPending.attributes = [
                                "Danger",
                                "Danger request",
                                "",
                                "Send help as fast as possible",
                                true,
                              ],
                              u!.uploadHelpRequest(
                                  "Danger request",
                                  "",
                                  "Send help as fast as possible",
                                  "Danger",
                                  true),
                              Status.waitingHelp = true,
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()),
                              ).then((value) => setState(() {}))
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.warning_rounded),
            ),
    );
  }
}

class DropDownListWithPic extends StatefulWidget {
  const DropDownListWithPic({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DropDownListWithPicState createState() => _DropDownListWithPicState();
}

class _DropDownListWithPicState extends State<DropDownListWithPic> {
  final _img = Image.network(
      "https://upload.wikimedia.org/wikipedia/commons/thumb/8/89/TUCPamplona10.svg/500px-TUCPamplona10.svg.png");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Test Drop"),
      ),
      // ignore: unnecessary_new
      body: new Center(
        // ignore: sized_box_for_whitespace
        child: Container(
          height: 50.0,
          child: DropdownButton(
              items: List.generate(10, (int index) {
                return DropdownMenuItem(
                    child: Container(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  height: 100.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[_img, const Text("Under 10")],
                  ),
                ));
              }),
              onChanged: null),
        ),
      ),
    );
  }
}

Future<String>? alertDialogPendingWrapper() async {
  var reqAttributes = await u!.getHelpRequest();
  AlertDialogPending.attributes = reqAttributes;
  return "done";
}
