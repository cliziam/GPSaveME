// ignore_for_file: file_names, prefer_const_constructors, unrelated_type_equality_checks
import 'package:flutter/material.dart';
import 'package:first_prj/main.dart';

class GiveReview extends StatefulWidget {
  final String title = "GPSaveMe";
  // ignore: non_constant_identifier_names
  const GiveReview({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _GiveReview createState() => _GiveReview();
}

class _GiveReview extends State<GiveReview> {
  var review = "";
  List<bool> stars = [false, false, false, false, false];
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
                  'Leave a review!',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 50)),
          Card(
            elevation: 3,
            margin: EdgeInsets.all(8.0),
            child: Column(children: [
              // ignore: prefer_const_literals_to_create_immutables
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(
                    width: 90,
                    height: 90,
                  ),
                  Text("Nome Cognome",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ))
                ],
              ),
              Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                for (var i = 0; i < 5; i++)
                  IconButton(
                    icon: Icon(Icons.star),
                    iconSize: 40,
                    color: stars[i]
                        ? Color.fromARGB(255, 244, 197, 11)
                        : Colors.grey,
                    onPressed: () => {
                      setState(() {
                        stars[i] = !stars[i];
                      })
                    },
                  )
              ]),
              Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 5)),
              TextField(
                  maxLines: 8,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    labelText: 'Write your feedback here...',
                  ),
                  onChanged: (value) {
                    setState(() {
                      review = value;
                    });
                  }),
              Padding(padding: EdgeInsets.fromLTRB(0, 30, 0, 30)),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: review == "" ? Colors.grey : Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onPressed: () => {},
                child: const Text('SEND REVIEW'),
              ),
              Padding(padding: EdgeInsets.fromLTRB(0, 30, 0, 30)),
            ]),
          )
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
