import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:job_endear/Models/user.dart';
import 'package:job_endear/Services/database.dart';
import 'package:job_endear/Models/UserData.dart';
import 'package:flutter/material.dart';



class AuthService {
   final auth.FirebaseAuth _auth= auth.FirebaseAuth.instance;
   

   //create user obj based on FirebaseUser
    User? _userFromFirebaseUser(auth.User? user) {
      if (user != null) {
        return User(uid: user.uid);
      }
      return null;
}

  //auth change user stream
  Stream<User?> get user{
    return _auth.authStateChanges()
    .map(_userFromFirebaseUser);
  }
  
  // sign in with email & password
 Future <User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      auth.UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      auth.User? user = result.user;
      return user != null ? _userFromFirebaseUser(user) : null;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }


   // Register with email and password
  Future<UserData?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      auth.UserCredential result = await AuthService().createUserWithEmailAndPassword(
          email: email, password: password);
      auth.User? user = result.user;
      return _userDataFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async{
    try{
      return await _auth.signOut();

    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
}