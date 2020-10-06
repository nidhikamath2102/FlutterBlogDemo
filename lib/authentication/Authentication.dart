import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class ImplementAuth{
  Future<String> logIn(String email, String password);
  Future<String> signUp(String email, String password);
  Future<String> currentUser();
  Future<void> logout();
}

class Auth extends ImplementAuth{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> logIn(String email, String password) async{
    FirebaseUser firebaseUser = (await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).user;
    return firebaseUser.uid;
  }

  Future<String> signUp(String email, String password) async{
    FirebaseUser firebaseUser = (await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).user;
    return firebaseUser.uid;
  }

  Future<String> currentUser() async{
    FirebaseUser firebaseUser = await _firebaseAuth.currentUser();
    return firebaseUser.uid;
  }

  Future<void> logout() async{
    _firebaseAuth.signOut();
  }
}