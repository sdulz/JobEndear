  import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
  import'package:flutter/material.dart';
import 'package:job_endear/Models/project.dart';
import 'package:job_endear/Models/user.dart';
  import 'package:job_endear/Screens/Authenticate/authenticate.dart';
import 'package:job_endear/Screens/Project_detail/applicant_list.dart';
import 'package:job_endear/Screens/freelancer_profile.dart/f_profile_form.dart';
import 'package:job_endear/Screens/freelancer_profile.dart/profile_post.dart';
import 'package:job_endear/Services/Algorithm/textrank.dart';
  import 'package:job_endear/Services/auth.dart';
  import 'package:job_endear/Screens/Home/home.dart';
  import 'package:provider/provider.dart';



  class Wrapper extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
    @override
    Widget build(BuildContext context){
      
      final AuthService authservice = Provider.of<AuthService>(context,listen: false);
      //return either home or authenticate widget 
    if(authservice.loading){
      return CircularProgressIndicator();
    }
    if (auth.currentUser == null){
      
        return Authenticate();

      } else {
        
        String clientId =auth.currentUser!.uid;
        FirebaseFirestore.instance.collection("jobs").doc(clientId).get().then((DocumentSnapshot snapshot){
          if (snapshot.exists){
            print(snapshot.data());
          }
          else{
            print("does not exist");
          }

       });
        return Home();
      }
    }
  }
