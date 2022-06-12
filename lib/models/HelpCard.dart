import 'package:flutter/material.dart';
import 'package:first_prj/main.dart';
import 'package:first_prj/models/ImageDialog.dart';
import 'package:first_prj/screens/HomePage.dart';

class HelpCard extends StatelessWidget {
  String imagePath = "";
  String text = "";
  bool isSafety = false;

  HelpCard(this.imagePath, this.text, this.isSafety);

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

class RequestCard extends StatefulWidget {
  String title;

  RequestCard(this.title);

  @override
  State<RequestCard> createState() => _RequestCardState();
}

class _RequestCardState extends State<RequestCard> {
  bool shareNumber = false;
  TimeOfDay selectedTime = TimeOfDay.now();
  bool timeIsSelected = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Text(widget.title),
      content: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text("Scelta di 4 aiuti di default"),
          const TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Write some info here...',
            ),
          ),
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
              visible: timeIsSelected ? false : true,
              child: ElevatedButton(
                onPressed: () {
                  _selectTime(context);
                },
                child: const Text("Choose Duration"),
              )),
          Text("Your request will be up until: "
              "${selectedTime.hour}:${selectedTime.minute}"),
          const Text("How urgent your request is?"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                onTap: (){
                  if(!PriorityContainer(1).getState()){
                  PriorityContainer(1).setState();   
                  }
                },
                child: PriorityContainer(1)
                ),
              const Padding(
                padding: EdgeInsets.all(5),
              ),
              InkWell(
                onTap: (){
                  if(!PriorityContainer(2).getState()){
                  PriorityContainer(2).setState();  
                  }
                },
                child: PriorityContainer(2)),
              const Padding(
                padding: EdgeInsets.all(5),
              ),
              InkWell(
                onTap: (){
                  if(!PriorityContainer(3).getState()){
                  PriorityContainer(3).setState();     
                  }
                },
                child: PriorityContainer(3))
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
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('Request help'),
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

class PriorityContainer extends StatelessWidget {
  int priorityLevel = 0;
  bool state = false;

  void setState() {
    state = true;
  }

  bool getState() {
    return state;
  }

  PriorityContainer(this.priorityLevel);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: deviceWidth * 0.2,
        height: deviceHeight * 0.1,
        decoration: BoxDecoration(
            color: const Color.fromRGBO(0, 0, 0, 0.1),
            borderRadius: BorderRadius.circular(10)),
        child: Column(children: <Widget>[
          Container(
            width: deviceWidth * 0.1,
            height: deviceHeight * 0.1,
            decoration: BoxDecoration(
                color: priorityLevel == 1
                    ? Colors.green
                    : priorityLevel == 2
                        ? Colors.yellow
                        : Colors.red,
                shape: BoxShape.circle),
          ),
        ]));
  }
}
