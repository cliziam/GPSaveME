import 'dart:io';

class User {
  String name, surname, phoneNumber;
  bool profile_check;
  File imageProfile;
  List<Review> reviewList = [];

  User(this.name, this.surname, this.phoneNumber, this.imageProfile, this.profile_check);


  String getReview() {
    if (reviewList.isEmpty) return 0.toString();
    double sum = 0;
    for (int i = 0; i < reviewList.length; i++) {
      sum += reviewList.elementAt(i).voto;
    }
    return (sum / reviewList.length).toString();
  }
  

}

class Review {
  int voto;
  String description;

  Review(this.voto, this.description);
}

class Document{
  File? Front;
  File? Retro;
  bool frontcheck;
  bool retrocheck;
  bool check;
  Document(this.check, this.frontcheck, this.retrocheck, [this.Front, this.Retro]);

 

}