import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:first_prj/screens/HomePage.dart';

class SignUp extends StatefulWidget {
  final String title = "GPSaveMe";
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();

  DateTime _date = DateTime.now();
  String gender = "";
  String _birthdate = "";
  int age = 0;
  String phone_number = "";
  List<bool> validators = [false, false, false];

  void setAge(DateTime date) {
    /**function to set the age of the user*/
    DateTime today = DateTime.now();
    int age_calculated = today.year - date.year;
    int month1 = today.month;
    int month2 = date.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = today.day;
      int day2 = date.day;
      if (day2 > day1) {
        age--;
      }
    }

    setState(() => age = age_calculated);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/sfondo.png"), fit: BoxFit.cover),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 60,
          ),
          Row(children: [
            SizedBox(width: 20),
            Text("Sign up",
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold))
          ]),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Row(children: [
              IconButton(
                iconSize: 30,
                icon: const Icon(Icons.add_a_photo_outlined),
                color: Colors.black,
                onPressed: () {},
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Take a selfie!",
                style: TextStyle(fontSize: 16),
              )
            ]),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                errorText:
                    validators[0] == false ? null : 'Please write your name.',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: TextField(
              controller: surnameController,
              decoration: InputDecoration(
                labelText: 'Surname',
                errorText: validators[1] == false
                    ? null
                    : 'Please write your surname.',
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: PhoneFormField(
              defaultCountry: IsoCode.IT,
              countrySelectorNavigator:
                  const CountrySelectorNavigator.modalBottomSheet(
                favorites: [IsoCode.IT, IsoCode.US],
              ),
              decoration: InputDecoration(
                labelText: 'Phone number',
                errorText: validators[2] == false
                    ? null
                    : 'Please write your phone number!',
              ),
              validator: PhoneValidator.compose([
                PhoneValidator.required(errorText: "You must enter a value"),
                PhoneValidator.validMobile(),
              ]),
              onChanged: (p) => setState(() => phone_number = p.toString()),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 5, 20, 0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Date of birth",
                    style: TextStyle(fontSize: 15, color: Colors.grey.shade700),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  ButtonTheme(
                    minWidth: 400.0,
                    height: 100.0,
                    child: OutlinedButton(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                child: Icon(Icons.calendar_month_outlined,
                                    size: 14, color: Colors.grey.shade700),
                              ),
                              WidgetSpan(
                                child: SizedBox(
                                  width: 10,
                                ),
                              ),
                              TextSpan(
                                  text: "$_birthdate" != ""
                                      ? "$_birthdate"
                                      : "Select your birth date",
                                  style:
                                      TextStyle(color: Colors.grey.shade500)),
                            ],
                          ),
                        ),
                        onPressed: () async {
                          final newDate = await showDatePicker(
                            context: context,
                            initialDate: _date,
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100),
                          );
                          if (newDate == null) return;
                          setState(() => _date = newDate);
                          setState(() => _birthdate = _date.year.toString() +
                              "-" +
                              _date.month.toString() +
                              "-" +
                              _date.day.toString());
                          setAge(_date);
                        }),
                  ),
                ]),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Text(
              "Gender",
              style: TextStyle(fontSize: 15, color: Colors.grey.shade700),
            ),
            for (var i in ["M", "F", "Other"])
              OutlinedButton(
                  onPressed: () {
                    setState(() {
                      gender = i;
                    });
                  },
                  child: Text(
                    i,
                    style: TextStyle(
                      color: (gender == i)
                          ? Color.fromRGBO(255, 183, 3, 1)
                          : Color.fromRGBO(33, 158, 188, 1),
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      side: BorderSide(
                          width: 2,
                          color: (gender == i)
                              ? Color.fromRGBO(255, 183, 3, 1)
                              : Color.fromRGBO(33, 158, 188, 1))))
          ]),
          Container(
            margin: const EdgeInsets.fromLTRB(220, 20, 20, 0),
            child: TextButton(
                child: Text("Sign up!".toUpperCase(),
                    style: TextStyle(fontSize: 14, color: Colors.white)),
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.all(15)),
                    //foregroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(33, 158, 188, 1)),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromRGBO(33, 158, 188, 1)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(
                                color: Color.fromRGBO(33, 158, 188, 1))))),
                onPressed: () async {
                  setState(() {
                    nameController.text.isEmpty
                        ? validators[0] = true
                        : validators[0] = false;
                  });
                  setState(() {
                    surnameController.text.isEmpty
                        ? validators[1] = true
                        : validators[1] = false;
                  });
                  setState(() {
                    phone_number == ""
                        ? validators[2] = true
                        : validators[2] = false;
                  });
                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
                }),
          ),
        ]),
      ),
    );
  }
}
