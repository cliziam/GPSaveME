// ignore_for_file: file_names

import 'dart:io';

class User {
  String name, surname, phoneNumber;
  bool profileCheck;
  File imageProfile;
  //inserire coordinate utente
  //List<double> position;
  List<Review> reviewList = [];
  User(this.name, this.surname, this.phoneNumber, this.imageProfile,
      this.profileCheck);

  String getReviewRating() {
    if (reviewList.isEmpty) return 0.toString();
    double sum = 0;
    for (int i = 0; i < reviewList.length; i++) {
      sum += reviewList.elementAt(i).voto;
    }
    return (sum / reviewList.length).toString();
  }

  void addReview(Review review) {
    reviewList.add(review);
  }

  List<Review> getReviews() {
    return reviewList;
  }


}

class Review {
  int voto;
  String description;
  User user;
  Review(this.voto, this.description, this.user);

  User getUser() {
    return user;
  }
}

class Document {
  File? front;
  File? retro;
  bool frontcheck;
  bool retrocheck;
  bool check;
  Document(this.check, this.frontcheck, this.retrocheck,
      [this.front, this.retro]);
}

