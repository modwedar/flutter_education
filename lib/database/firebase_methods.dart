import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_education/models/user_class.dart';


class FirebaseMethods {

  User _currentUser = FirebaseAuth.instance.currentUser;

  Future<String> getUserUid() async {
    return _currentUser.uid;
  }

  Future<void> sendToUsersDatabase(UserClass userClass) {
    FirebaseFirestore.instance.runTransaction((Transaction transaction) async {
      DocumentReference reference = FirebaseFirestore.instance.collection('users').doc(_currentUser.uid);
      await reference.set(userClass.toMap());
    });
  }

  Future<UserClass> getUserData() async {
    DocumentSnapshot ds = await FirebaseFirestore.instance.collection('users').doc(_currentUser.uid).get();
    UserClass userClass = UserClass.getMap(ds);
    return userClass;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

}