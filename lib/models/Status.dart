// ignore_for_file: file_names
//import 'dart:io';
//import 'package:flutter/material.dart';
//import 'package:first_prj/main.dart';

class Status {
  static bool waitingHelp = false;
  static bool helpAccepted = false;
  static bool waitingAcceptOrRefuse = false;
  static bool proposalAccepted = false;

  static bool areAllFalse() {
    return !waitingHelp &&
        !helpAccepted &&
        !waitingAcceptOrRefuse &&
        !proposalAccepted;
  }
}
