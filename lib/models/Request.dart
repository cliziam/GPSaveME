import 'package:first_prj/models/User.dart';
import 'package:flutter/material.dart';

enum REQUEST_TYPE { transportation, health, safety, house, general }

class Request {
  int id, priority;
  String description;
  User helped;
  REQUEST_TYPE type;
  String imagePath; // to instantiate when user clicks on "request help"

  Request(this.id, this.priority, this.type, this.description, this.helped,
      this.imagePath);

  String getName() {
    return helped.name + " " + helped.surname[0] + ".";
  }

  int getPriority() {
    return priority;
  }

  String getPriorityAsString() {
    switch (priority) {
      case 1:
        return "Low";
      case 2:
        return "Medium";
      case 3:
        return "High";
      default:
        return "";
    }
  }

  REQUEST_TYPE getType() {
    return type;
  }

  String getImagePath() {
    return imagePath;
  }

  User getUser() {
    return helped;
  }

  String getDistance(User helped) {
    // implement coordinates distance formula
    // distance(myself, helped) dove myself è
    // un oggetto User globale che si setta appena loggati
    return "100m";
  }

  String getDescription() {
    return description;
  }
}
