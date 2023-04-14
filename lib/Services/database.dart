import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

final FirebaseFirestore _db = FirebaseFirestore.instance;

class DatabaseService {
 



  // collection references
  CollectionReference _usersCollection = _db.collection('users');
  
  final FirebaseAuth auth = FirebaseAuth.instance;


  final String uid = FirebaseAuth.instance.currentUser!.uid;
 
 

  void addClientData({
        required String email,
        required String firstName,
        required String lastName,
        String? role,
        String? companyName,
        String? companyAddress,
        String? projectId,
      })
  {
    try{
      CollectionReference _usersCollection = _db.collection('users');
      debugPrint(_usersCollection.toString());
      _usersCollection.add({
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'companyName': companyName,
        'companyAddress': companyAddress,
        'projectIds': projectId,
      }).then((DocumentReference ref ) => ref.update({'userId':ref.id}) );
    }
    catch(e){
      debugPrint(e.toString());
    }
        
  }

   void addFreelancerData({
        required String email,
        required String firstName,
        required String lastName,
        String? role,
        String? freelancerTitle,
        String? freelancerDescription,
        String? projectId,
      })
  {
    try{
      CollectionReference _usersCollection = _db.collection('users');
      debugPrint(_usersCollection.toString());
      _usersCollection.doc(uid).set({
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'companyName': freelancerTitle,
        'companyAddress': freelancerDescription,
        'projectIds': projectId,
      });
    }
    catch(e){
      debugPrint(e.toString());
    }
        
  }
}
