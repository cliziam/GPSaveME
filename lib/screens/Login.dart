import 'package:flutter/material.dart';

import 'package:phone_form_field/phone_form_field.dart';
import 'Signup.dart';
import 'OtpSent.dart';
//import 'package:flutter_otp/flutter_otp.dart';

class Login extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<Login> {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 150,
              ),
              Text(
                "Login",
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                      "Enter your mobile phone to continue, \nwe will send you OTP to verify",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey.shade700))),
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: PhoneFormField(
                    defaultCountry: IsoCode.IT,
                    countrySelectorNavigator:
                        CountrySelectorNavigator.modalBottomSheet(
                      favorites: [IsoCode.IT, IsoCode.US],
                    ),
                    //onSaved: (number) {print('saved $p');},
                    onChanged: (number) {
                      print('changed ${number}');
                    }),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 2),
                  child: TextButton(
                    child: Text("Sign in".toUpperCase(),
                        style: TextStyle(fontSize: 14, color: Colors.white)),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(15)),
                        //foregroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(33, 158, 188, 1)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromRGBO(33, 158, 188, 1)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(
                                        color:
                                            Color.fromRGBO(33, 158, 188, 1))))),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => otpSent()));
                    },
                  )),
              Row(children: [
                Padding(
                    padding: EdgeInsets.only(left: 100),
                    child: Text("Not registered yet?",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey.shade700))),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    child: const Text('Sign up',
                        style: TextStyle(
                            fontSize: 15,
                            color: Color.fromRGBO(33, 158, 188, 1)))),
              ])
            ],
          ),
        ));
  }
}
