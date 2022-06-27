import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instakilo/methods/storage_methods.dart';
import 'package:instakilo/models/user.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserdata() async {
    User curUser = _auth.currentUser!;
    DocumentSnapshot userSnap =
        await _firestore.collection('users').doc(curUser.uid).get();

    return model.User.fromSnap(userSnap);
  }

  Future<String> signUpUser({
    required String email,
    required String pass,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "OOPS! Something went wrong";
    try {
      if (email.isNotEmpty ||
          pass.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: pass,
        );

        String imageUrl = await StorageMethdos()
            .uploadImageToDB('profilePictures', file, false);

        model.User user = model.User(
          username: username,
          uid: cred.user!.uid,
          email: email,
          bio: bio,
          followers: [],
          following: [],
          imageUrl: imageUrl,
        );

        await _firestore.collection('users').doc(cred.user!.uid).set(
              user.toJson(),
            );
        res = 'success';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> loginUser(
      {required String email, required String pass}) async {
    String res = "OOPS! Something went wrong";

    try {
      if (email.isNotEmpty || pass.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(email: email, password: pass);
        res = 'success';
      } else {
        res = 'Please enter all the fields';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        res = 'User not found';
      }
      if (e.code == 'wrong-password') {
        res = 'Invalid Password';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
