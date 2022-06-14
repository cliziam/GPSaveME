// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:first_prj/main.dart';
import 'package:first_prj/models/HelpCard.dart';

class HomePage extends StatefulWidget {
  final String title = "GPSaveMe";

  const HomePage({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                  message: "Select a card to ask for help!",
                  triggerMode: TooltipTriggerMode.tap,
                  child: Icon(Icons.add_alert_sharp,
                      color: Colors.white60, size: 24.0),
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: deviceHeight * 0.05)),
          HelpCard("images/car.png", "Transportation", false),
          HelpCard("images/health.png", "Health", false),
          HelpCard("images/house.png", "House & Gardening", false),
          HelpCard("images/hands.png", "General", false),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromRGBO(255, 183, 3, 1),
        selectedItemColor: const Color.fromRGBO(33, 158, 188, 1),
        unselectedItemColor: Colors.white,
        currentIndex: MyApp.selectedIndex,
        onTap: (index) {
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
      floatingActionButton: FloatingActionButton.extended(
        label: Row(
          children: const <Widget>[
            Padding(padding: EdgeInsets.only(right: 5)),
            Text("Send a danger request"),
          ],
        ),
        backgroundColor: Colors.red,
        onPressed: () {},
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
