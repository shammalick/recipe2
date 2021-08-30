import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String name;
  String email;
  String imagUrl;
  UserModel({this.id, this.name, this.email, this.imagUrl});

  UserModel.fromDocumentSnapshot({DocumentSnapshot doc}) {
    id = doc.id;
    name = doc["name"];
    email = doc['email'];
    imagUrl = doc['imagUrl'];
  }

}
