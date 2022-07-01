// ignore_for_file: file_names
//import 'dart:io';
//import 'package:flutter/material.dart';
//import 'package:first_prj/main.dart';

class Status {
  static bool qrScanned = false;
  static bool waitingHelp = false;
  static bool helpAccepted = false;
  static bool waitingAcceptOrRefuse = false;
  static bool proposalAccepted = false;

  static void setAllFalse() {
    qrScanned = false;
    waitingHelp = false;
    helpAccepted = false;
    waitingAcceptOrRefuse = false;
    proposalAccepted = false;
  }

  static bool areAllFalse() {
    return !waitingHelp &&
        !helpAccepted &&
        !waitingAcceptOrRefuse &&
        !proposalAccepted;
  }
}
