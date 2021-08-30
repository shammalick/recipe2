import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipe2/models/user.dart';



class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> createNewUser(UserModel user) async {
    try{
      await _firestore.collection('users').doc(user.id).set({
        'name': user.name,
        'email': user.email,
        'imageUrl': null,
        'id':user.id,
      
      });
      return true;
    } catch(e) {
      print(e);
      return false;
    }
  }


  Future<UserModel> getUser(String uid) async {
  try {
    DocumentSnapshot _doc = 
    await _firestore.collection('users').doc(uid).get();


    return UserModel.fromDocumentSnapshot(doc: _doc);
  } catch (e) {
    print(e);
    rethrow;
  }
}
Future<void> updateProfilePic(picURL) async {
    User user = FirebaseAuth.instance.currentUser;
    await _firestore
        .collection("users")
        .doc(user.uid)
        .update({"imageUrl": picURL});
    print("Image Url: $picURL");
  }
}
