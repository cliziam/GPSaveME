// ignore_for_file: file_names, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:first_prj/main.dart';

final Map<String, Iterable<dynamic>> dict = {
  "Transportation": ["Puncture", "Fuel", "Other"],
  "Health": ["Meds", "Injury", "Other"],
  "House & Gardening": ["Shopping", "Furniture", "Other"],
  "General": ["Street", "Personal", "Other"]
};

// ignore: must_be_immutable
class HelpCard extends StatelessWidget {
  String imagePath = "";
  String text = "";
  bool isSafety = false;

  HelpCard(this.imagePath, this.text, this.isSafety, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          requestHelp(context);
        },
        child: Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: isSafety ? Colors.red : Colors.white,
          child: SizedBox(
            width: deviceWidth * 0.9,
            height: deviceHeight * 0.1,
            child: Row(children: <Widget>[
              Padding(padding: EdgeInsets.only(left: deviceWidth * 0.05)),
              SizedBox(
                width: deviceWidth * 0.1,
                height: deviceWidth * 0.1,
                child: Image.asset(
                  imagePath,
                ),
              ),
              Padding(padding: EdgeInsets.only(left: deviceWidth * 0.05)),
              Text(
                text,
                style: TextStyle(color: isSafety ? Colors.white : Colors.black),
              )
            ]),
          ),
        ));
  }

  requestHelp(BuildContext context) async {
    bool accepted = await getLocation();

    if (accepted) {
      showDialog(context: context, builder: (_) => RequestCard(text));
    }
  }
}

// ignore: must_be_immutable
class RequestCard extends StatefulWidget {
  String title;
  RequestCard(this.title, {Key? key}) : super(key: key);

  @override
  State<RequestCard> createState() => _RequestCardState();
}

class _RequestCardState extends State<RequestCard> {
  bool shareNumber = false;
  TimeOfDay selectedTime = TimeOfDay.now();
  bool timeIsSelected = false;
  String? informations = "";

  var reqSelected = "";
  var priSelected = "";

  var listVariables = ["Puncture", "Fuel", "Other"];
  var listColors = ["Low", "Medium", "High"];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Text(widget.title),
      content: SingleChildScrollView(
          child: Wrap(
        alignment: WrapAlignment.center,
        runSpacing: deviceWidth * 0.025,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              for (var k in listVariables)
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: InkWell(
                    onTap: () => {
                      setState(() => reqSelected = k),
                    },
                    child: RequestTypeCard(
                        "images/$k.png",
                        k,
                        reqSelected == k
                            ? const Color.fromRGBO(253, 216, 93, 1)
                            : const Color.fromRGBO(255, 252, 242, 1)),
                  ),
                ),
            ],
          ),
          Padding(padding: EdgeInsets.only(bottom: deviceHeight * 0.125)),
          TextField(
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                labelText: 'Write some info here...',
              ),
              onChanged: (value) {
                setState(() {
                  informations = value;
                });
              }),
          SwitchListTile(
            title: const Text('Share number'),
            value: shareNumber,
            onChanged: (bool value) {
              setState(() {
                shareNumber = value;
              });
            },
            secondary: const Icon(Icons.phone),
          ),
          Visibility(
              //visible: timeIsSelected ? false : true,
              child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: const BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
            color: const Color.fromRGBO(0, 160, 227, 1),
            textColor: Colors.white,
            onPressed: () {
              _selectTime(context);
            },
            child: Text(timeIsSelected ? "Change Duration" : "Choose Duration"),
          )),
          Text("Your request will be up until: "
              "${selectedTime.hour}:${selectedTime.minute}"),
          Padding(padding: EdgeInsets.only(bottom: deviceHeight * 0.025)),
          const Text(
            "How urgent your request is?",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              for (var i in listColors)
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: InkWell(
                    onTap: () => {
                      setState(() => priSelected = i),
                    },
                    child: PriorityContainer(
                        listColors.indexOf(i) + 1,
                        priSelected == 'Low'
                            ? Colors.green
                            : priSelected == 'Medium'
                                ? Colors.yellow
                                : priSelected == 'High'
                                    ? Colors.red
                                    : const Color.fromRGBO(255, 252, 180, 1)),
                  ),
                ),
            ],
          ),
        ],
      )),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => priSelected == "" ||
                  reqSelected == "" ||
                  informations == "" ||
                  !timeIsSelected
              ? null
              : Navigator.pop(context, 'OK'),
          child: Text('REQUEST HELP',
              style: TextStyle(
                color: priSelected == "" ||
                        reqSelected == "" ||
                        informations == "" ||
                        !timeIsSelected
                    ? Colors.grey
                    : Colors.blue,
              )),
        ),
      ],
      actionsAlignment: MainAxisAlignment.spaceEvenly,
    );
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
        timeIsSelected = true;
      });
    }
  }
}

// ignore: must_be_immutable
class PriorityContainer extends StatelessWidget {
  int priorityLevel = 0;
  bool state = false;
  Color color;

  PriorityContainer(this.priorityLevel, this.color, {Key? key})
      : super(key: key);

  var priorities = [Colors.green, Colors.yellow, Colors.red];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            width: deviceWidth * 0.20,
            height: deviceHeight * 0.11,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromRGBO(255, 253, 247, 1),
                border: Border.all(
                  color: priorities[priorityLevel - 1] != color ||
                          priorityLevel == 0
                      ? const Color.fromRGBO(255, 252, 242, 1)
                      : color,
                  width: 1,
                )),
            child: Column(children: <Widget>[
              Container(
                width: deviceWidth * 0.09,
                height: deviceHeight * 0.09,
                decoration: BoxDecoration(
                    color: priorities[priorityLevel - 1],
                    shape: BoxShape.circle),
              ),
            ])),
        const Padding(padding: EdgeInsets.only(bottom: 10)),
        Text(priorityLevel == 1
            ? "Low"
            : priorityLevel == 2
                ? "Medium"
                : "High")
      ],
    );
  }
}

// ignore: must_be_immutable
class RequestTypeCard extends StatelessWidget {
  String imagePath;
  String text;
  Color? fillColor;

  RequestTypeCard(this.imagePath, this.text, this.fillColor, {Key? key}) : super(key: key){
    imagePath=imagePath.toLowerCase();
  }


  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
          width: deviceWidth * 0.2,
          height: deviceHeight * 0.1,
          decoration: BoxDecoration(
            color: fillColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: fillColor == const Color.fromRGBO(255, 252, 242, 1)
                    ? Colors.white
                    : Colors.grey,
                blurRadius: 2.0,
                spreadRadius: 0.0,
                offset:
                    const Offset(2.0, 2.0), // shadow direction: bottom right
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                imagePath,
                fit: BoxFit.contain,
                width: deviceWidth * 0.07,
                height: deviceHeight * 0.09,
              ),
            ],
          )),
      Padding(padding: EdgeInsets.only(bottom: deviceHeight * 0.020)),
      Text(text)
    ]);
  }
}
