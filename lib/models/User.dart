// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_prj/models/Request.dart';
import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:math';

class User {
  String name, surname, phoneNumber;
  bool profileCheck;
  Image imageProfile;
  String reviewMean = " ";
  double latitude;
  double longitude;
  String pendingAsk = "";
  String pendingGive = "";
  bool frontCheck = false;
  bool retroCheck = false;

  User(this.name, this.surname, this.phoneNumber, this.imageProfile,
      this.profileCheck, this.latitude, this.longitude);

  getReviewRating() async {
    var jsonFile = await getCurrentData();
    num accumulator = 0;
    List reviews = jsonFile["review_list"];
    if (reviews.isNotEmpty) {
      for (int i = 0; i < reviews.length; i++) {
        accumulator += reviews[i][0];
      }
      reviewMean = (accumulator / reviews.length).toString();

      return reviewMean;
    }
    reviewMean = "0";
    return reviewMean;
  }

  double getlatitude() {
    return latitude;
  }

  double getlongitude() {
    return longitude;
  }

  static getBlankImage() async {
    final userlistPath = FirebaseStorage.instance.ref().child("blank.png");
    var url = await userlistPath.getDownloadURL();
    return Image.network(url);
  }

  updateLocation() async {
    Location location = Location();
    var position = await location.getLocation();
    latitude = position.latitude!;
    longitude = position.longitude!;
  }

  getCurrentData() async {
    final userlistPath = FirebaseStorage.instance
        .ref()
        .child("users/$phoneNumber/userdata.json");
    const oneMegabyte = 1024 * 1024;
    final Uint8List? data = await userlistPath.getData(oneMegabyte);
    var list = data!.toList();
    var jsonAsString = String.fromCharCodes(list);
    final jsonFile = await json.decode(jsonAsString);
    return jsonFile;
  }

  checkForHelp() async {
    List<User> users = [];
    final helpsPath =
        FirebaseStorage.instance.ref().child("users/$phoneNumber/");
    var helps = await helpsPath.listAll();
    for (var path in helps.items) {
      if (path.fullPath.contains("_")) {
        var proposalRef = FirebaseStorage.instance.ref().child(path.fullPath);
        const oneMegabyte = 1024 * 1024;
        final Uint8List? data = await proposalRef.getData(oneMegabyte);
        var list = data!.toList();
        var jsonAsString = String.fromCharCodes(list);
        final jsonFile = await json.decode(jsonAsString);
        var phone = jsonFile["phone_number"];
        var userDataRef =
            FirebaseStorage.instance.ref().child("users/$phone/userdata.json");
        final Uint8List? userdata = await userDataRef.getData(oneMegabyte);
        var userlist = userdata!.toList();
        var userjsonAsString = String.fromCharCodes(userlist);
        final userjsonFile = await json.decode(userjsonAsString);
        var user = await getUser(phone, userjsonFile);
        users.add(user);
      }
    }
    return users;
  }

  Future<bool> uploadHelpRequest(String type, String subType,
      String? description, String priority, bool shareNumber) async {
    await updateLocation();
    var jsonFile = await getCurrentData();
    jsonFile["waitingHelp"] = true;
    jsonFile["request_priority"] = priority;
    jsonFile["request_type"] = type;
    jsonFile["request_subtype"] = subType;
    jsonFile["request_text"] = description;
    jsonFile["share_number"] = shareNumber;
    jsonFile["latitude"] = latitude;
    jsonFile["longitude"] = longitude;

    var jsonString = jsonEncode(jsonFile);
    var bytes = utf8.encode(jsonString);
    var byteData = base64.encode(bytes);

    var arr = base64.decode(byteData);

    String tempPath = (await getTemporaryDirectory()).path;
    // crea il file nella cache
    File toupload = await File('$tempPath/userdata.json').create();
    await toupload.writeAsBytes(arr);
    final ref = FirebaseStorage.instance
        .ref()
        .child("users/$phoneNumber/userdata.json");
    // carica il file
    ref.putFile(toupload);
    return true;
  }

  uploadHelpProposal(String phone) async {
    await updateLocation();
    var helpedRef = FirebaseStorage.instance.ref().child(
        "users/$phone/writetouser_$phoneNumber.json"); //phone number used to uniquely identify the file
    var jsonFile = {
      "latitude": latitude,
      "longitude": longitude,
      "phone_number": phoneNumber
    };
    var jsonString = jsonEncode(jsonFile);
    var bytes = utf8.encode(jsonString);
    var byteData = base64.encode(bytes);

    var arr = base64.decode(byteData);

    String tempPath = (await getTemporaryDirectory()).path;
    // crea il file nella cache
    File toupload = await File('$tempPath/writetotuser.json').create();
    await toupload.writeAsBytes(arr);
    // carica il file
    helpedRef.putFile(toupload);
    return true;
  }

  getHelpRequest() async {
    var jsonFile = await getCurrentData();
    var reqType = jsonFile["request_type"];
    var reqSubType = jsonFile["request_subtype"];
    var reqText = jsonFile["request_text"];
    var shareNumber = jsonFile["share_number"];
    var priority = jsonFile["request_priority"];

    return [priority, reqType, reqSubType, reqText, shareNumber];
  }

  readHelpRequests() async {
    List<Request> requests = [];
    var usersRef = FirebaseStorage.instance.ref().child("users/");
    var usersDirs = await usersRef.listAll();
    for (var path in usersDirs.prefixes) {
      var cellPhone = path.fullPath.split("/")[1];
      if (cellPhone != phoneNumber) {
        var udataRef = FirebaseStorage.instance
            .ref()
            .child("users/$cellPhone/userdata.json");
        const oneMegabyte = 1024 * 1024;
        final Uint8List? data = await udataRef.getData(oneMegabyte);
        var list = data!.toList();
        var jsonAsString = String.fromCharCodes(list);
        final jsonFile = await json.decode(jsonAsString);
        var user = await getUser(cellPhone, jsonFile);
        if (jsonFile["waitingHelp"]) {
          var request = Request(
              jsonFile["request_priority"], // needs string but is int in JSON
              jsonFile["request_type"],
              jsonFile["request_subtype"],
              jsonFile["request_text"],
              user,
              "images/${jsonFile["request_type"]}");
          requests.add(request);
        }
      }
    }
    return requests;
  }

  deleteRequest() async {
    var jsonFile = await getCurrentData();
    jsonFile["waitingHelp"] = false;
    jsonFile["request_priority"] = "";
    jsonFile["request_type"] = "";
    jsonFile["request_subtype"] = "";
    jsonFile["request_text"] = "";
    jsonFile["share_number"] = false;

    var jsonString = jsonEncode(jsonFile);
    var bytes = utf8.encode(jsonString);
    var byteData = base64.encode(bytes);

    var arr = base64.decode(byteData);

    String tempPath = (await getTemporaryDirectory()).path;
    // crea il file nella cache
    File toupload = await File('$tempPath/userdata.json').create();
    await toupload.writeAsBytes(arr);
    final ref = FirebaseStorage.instance
        .ref()
        .child("users/$phoneNumber/userdata.json");
    // carica il file
    ref.putFile(toupload);
    return true;
  }

  acceptRequest(String phone) async {
    await updateLocation();
    var helpedRef = FirebaseStorage.instance.ref().child(
        "users/$phone/writetouser_$phoneNumber.json"); //phone number used to uniquely identify the file
    var jsonFile = {
      "latitude": latitude,
      "longitude": longitude,
      "phone_number": phoneNumber,
      "accepted": true,
      "rejected": false
    };
    var jsonString = jsonEncode(jsonFile);
    var bytes = utf8.encode(jsonString);
    var byteData = base64.encode(bytes);

    var arr = base64.decode(byteData);

    String tempPath = (await getTemporaryDirectory()).path;
    // crea il file nella cache
    File toupload = await File('$tempPath/writetotuser.json').create();
    await toupload.writeAsBytes(arr);
    // carica il file
    helpedRef.putFile(toupload);
  }

  rejectRequest(String phone) async {
    await updateLocation();
    var helpedRef = FirebaseStorage.instance.ref().child(
        "users/$phone/writetouser_$phoneNumber.json"); //phone number used to uniquely identify the file
    var jsonFile = {
      "latitude": latitude,
      "longitude": longitude,
      "phone_number": phoneNumber,
      "accepted": false,
      "rejected": true
    };
    var jsonString = jsonEncode(jsonFile);
    var bytes = utf8.encode(jsonString);
    var byteData = base64.encode(bytes);

    var arr = base64.decode(byteData);

    String tempPath = (await getTemporaryDirectory()).path;
    // crea il file nella cache
    File toupload = await File('$tempPath/writetotuser.json').create();
    await toupload.writeAsBytes(arr);
    // carica il file
    helpedRef.putFile(toupload);
  }

  getUser(String phone, Map jsonFile) async {
    final userimagePath =
        FirebaseStorage.instance.ref().child("users/$phone/images/profile.jpg");
    var url = await userimagePath.getDownloadURL();
    Image profilePic = Image.network(url);
    User user = User(
        jsonFile["name"], jsonFile["surname"], phone, profilePic, true, 0, 0);
    await user.getReviewRating();
    return user;
  }

  static getDistance(User u1, User u2) {
    var R = 6371; // Radius of the earth in km
    var dLat = deg2rad(u2.latitude - u1.latitude); // deg2rad below
    var dLon = deg2rad(u2.longitude - u1.longitude);
    var a = sin(dLat / 2) * sin(dLat / 2) +
        cos(deg2rad(u1.latitude)) *
            cos(deg2rad(u2.latitude)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    var c = 2 * atan2(sqrt(a), sqrt(1 - a));
    var d = R * c; // Distance in km
    return "${(d * 1000).round()} mt";
  }

  static double deg2rad(deg) {
    return deg * (pi / 180);
  }

  checkProposalStatus() {}
}

class Review {
  int voto;
  String description;

  Review(this.voto, this.description);
}
