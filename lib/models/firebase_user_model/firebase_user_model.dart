import 'package:cloud_firestore/cloud_firestore.dart';

class FirsebaseUserModel {
  String uid;
  String email;
  String photoUrl;
  String displayName;

  FirsebaseUserModel({
    this.uid,
    this.email,
    this.photoUrl,
    this.displayName,
  });

  Map toMap(FirsebaseUserModel user) {
    var data = Map<String, dynamic>();
    data['uid'] = user.uid;
    data['email'] = user.email;
    data['photoUrl'] = user.photoUrl;
    data['displayName'] = user.displayName;

    return data;
  }

  FirsebaseUserModel.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData['uid'];
    this.email = mapData['email'];
    this.photoUrl = mapData['photoUrl'];
    this.displayName = mapData['displayName'];
  }

  FirsebaseUserModel.fromDocument(DocumentSnapshot document) {
    this.uid = document['uid'];
    this.email = document['email'];
    this.photoUrl = document['photoUrl'];
    this.displayName = document['displayName'];
  }
}
