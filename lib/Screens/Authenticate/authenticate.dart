import 'package:flutter/material.dart';
import 'package:job_endear/Screens/Authenticate/register.dart';
import 'package:job_endear/Screens/Authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {

  @override
  State<Authenticate> createState() => _authenticateState();
}

class _authenticateState extends State<Authenticate> {
  
    bool showSignIn = true;
     void toggleView(){
      setState(() {
        showSignIn=!showSignIn;
      });
    }
  @override 
  Widget build(BuildContext context) {
    if(showSignIn){
      return SignIn(toggleView: toggleView);
    }  
    else{
      return Register(toggleView: toggleView);

    }

    }

  }
