// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:first_prj/main.dart';
import 'package:first_prj/models/Request.dart';
import '../models/AlertAroundYouPending.dart';
import '../models/Status.dart';
import 'package:first_prj/screens/SignUpNumber.dart';

// ignore: must_be_immutable
class AroundYou extends StatefulWidget {
  final String title = "GPSaveMe";

  static List<Request> requestList = [];

  const AroundYou({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _AroundYouState createState() => _AroundYouState();
}

class _AroundYouState extends State<AroundYou> {
  final GlobalKey<AnimatedListState> _key = GlobalKey();
  bool accepted = false;
  var refreshColor = const Color.fromRGBO(255, 183, 3, 1);

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
          if (Status.waitingHelp || Status.helpAccepted)
            ...[]
          else
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
                      Padding(
                          padding: EdgeInsets.only(left: deviceWidth * 0.13)),
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
                  await buildRequests();
                  setState(() {});
                }),
          if (Status.areAllFalse()) ...[
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
          ] else ...[
          const Padding(padding: EdgeInsets.only(top: 5)),
            const AlertAroundYouPending()
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
            MyApp.navigateToNextScreen(context, index);
          }
          if (index == 2) {
            await u!.getReviewRating();
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
            _offerHelp(context, item, index);
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
                  color: AroundYou.requestList[index].getPriority() == "Low"
                      ? Colors.green
                      : AroundYou.requestList[index].getPriority() == "Medium"
                          ? Colors.yellow
                          : AroundYou.requestList[index].getPriority() == "High"
                              ? Colors.red
                              : AroundYou.requestList[index].getPriority() ==
                                      "Danger"
                                  ? Colors.red
                                  : Colors.black,
                  shape: BoxShape.circle),
              child: SizedBox(
                  width: 40,
                  height: 40,
                  child: Image.asset(
                    getPath(
                        AroundYou.requestList[index].getType().split(" ")[0]),
                  ))),
          leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset("images/distance.png", width: 40, height: 40),
                FutureBuilder(
                  builder: (context, AsyncSnapshot<String> text) {
                    return Text(
                      item.getDistance(
                          u!.latitude,
                          u!.longitude,
                          AroundYou.requestList[index].getUser().latitude,
                          AroundYou.requestList[index].getUser().longitude),
                    );
                  },
                  future: buildRequests(),
                )
              ]),
        ),
      ),
    );
  }

  String getPath(String requestType) {
    var type = requestType.toLowerCase();
    String path = type == "house"
        ? "images/house.png"
        : type == "transportation"
            ? "images/car.png"
            : type == "health"
                ? "images/health.png"
                : type == "general"
                    ? "images/hands.png"
                    : type == "safety"
                        ? "images/safety.png"
                        : type == "danger"
                            ? "images/alert.png"
                            : "images/distance.png";
    return path;
  }

  void _offerHelp(BuildContext context, Request item, int index) async {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              title: Row(
                children: <Widget>[
                  SizedBox(
                      width: 40, height: 40, child: item.helped.imageProfile),
                  Padding(padding: EdgeInsets.only(left: deviceWidth * 0.025)),
                  Text(item.getName())
                ],
              ),
              content:
                  Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      item.getDistance(
                          u!.latitude,
                          u!.longitude,
                          AroundYou.requestList[index].getUser().latitude,
                          AroundYou.requestList[index].getUser().longitude),
                    ),
                    // ignore: deprecated_member_use_from_same_package
                    Text(" | Request: ${item.getPriorityAsString()}")
                  ],
                ),
                Padding(padding: EdgeInsets.only(bottom: deviceHeight * 0.02)),
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    Padding(padding: EdgeInsets.only(left: deviceWidth * 0.01)),
                    Text(item.getUser().reviewMean)
                  ],
                ),
                Padding(padding: EdgeInsets.only(bottom: deviceHeight * 0.025)),
                Row(children: const <Widget>[
                  Text(
                    "Description:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ]),
                Padding(padding: EdgeInsets.only(bottom: deviceHeight * 0.005)),
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
                  child: const Text("SEND HELP"),
                  onPressed: () async {
                    Status.waitingAcceptOrRefuse=true;

                    await u!.uploadHelpProposal(item.helped.phoneNumber);
                    if (!mounted) return; // consiglio di stack
                    Navigator.push(context,MaterialPageRoute(builder: (context) => const AroundYou())).then((value) => setState(() {})); 
                  },
                 
                ),
              ],
              actionsAlignment: MainAxisAlignment.spaceEvenly,
            ));
  }
}

Future<String> buildRequests() async {
  // await u!.updateLocation();
  List<Request> requests =
      await u!.readHelpRequests(); // to update when we build the page
  AroundYou.requestList = requests;
  return "done";
}
