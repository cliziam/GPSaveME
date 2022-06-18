// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';

class User {
  String name, surname, phoneNumber;
  bool profileCheck;
  Image imageProfile;
  String reviewMean = " ";
  double latitude;
  double longitude;
  

  User(this.name, this.surname, this.phoneNumber, this.imageProfile,
      this.profileCheck, this.latitude, this.longitude) {
    getReviewRating();
  }

  getReviewRating() async {
    num accumulator = 0;
    final String response =
        await rootBundle.loadString('storage/userdata.json');
    final data = await json.decode(response);
    var reviews = data["review_list"];
    for (int i = 0; i < reviews.length; i++) {
      accumulator += reviews[i][0];
    }
    reviewMean = (accumulator / reviews.length).toString();
  }

  double getlatitude(){
    return latitude;
  }
  
  double getlongitude(){
    return longitude;
  }

 
}

class Review {
  int voto;
  String description;

  Review(this.voto, this.description);
}

class Document {
  bool frontcheck;
  bool retrocheck;
  bool check;
  Document(this.check, this.frontcheck, this.retrocheck);
}
