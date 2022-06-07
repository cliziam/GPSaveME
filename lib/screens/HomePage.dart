// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:first_prj/main.dart';

class HomePage extends StatefulWidget {
  final String title = "GPSaveMe";

  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), actions: <Widget>[
        Row(
          children: <Widget>[
            ElevatedButton.icon(
                icon: const Icon(Icons.diamond),
                label: Text(MyApp.coins.toString()),
                onPressed: () => {})
          ],
        )
      ]),
      body: Container(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromRGBO(255, 183, 3, 1),
        selectedItemColor: const Color.fromRGBO(33, 158, 188, 1),
        unselectedItemColor: Colors.white,
        currentIndex: MyApp.selectedIndex,
        onTap: (_index) {
          if (MyApp.selectedIndex != _index) {
            setState(() {
              MyApp.selectedIndex = _index;
            });
            MyApp.navigateToNextScreen(context, _index);
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
