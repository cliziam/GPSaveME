import 'dart:io';
import 'package:flutter/material.dart';
import 'package:first_prj/main.dart';

class Status {
  static bool requestDone = false; 

  static void setRequestDone() {
    requestDone = !requestDone;
  }
}