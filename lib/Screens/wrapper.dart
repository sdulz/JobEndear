import 'package:firebase_auth/firebase_auth.dart';
import'package:flutter/material.dart';
import 'package:job_endear/Services/auth.dart';
import'package:job_endear/models/user.dart';
import 'package:job_endear/Screens/Home/home.dart';
import 'package:provider/provider.dart';
import 'package:job_endear/Screens/Authenticate/authenticate.dart';


class Wrapper extends StatelessWidget {
final FirebaseAuth auth = FirebaseAuth.instance;
  @override
   Widget build(BuildContext context){
    
    // final AuthService authservice = Provider.of<AuthService>(context,listen: false);
    //return either home or authenticate widget 
  //  if(authservice.loading){
  //   return CircularProgressIndicator();
  //  }
   if (auth.currentUser == null){
      return authenticate();
    } else {
      return Home();
    }

    
  }
}
