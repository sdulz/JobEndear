import 'package:flutter/material.dart';
import 'package:job_endear/Screens/Authenticate/register.dart';
import 'package:job_endear/Screens/Authenticate/sign_in.dart';

class authenticate extends StatefulWidget {

  @override
  State<authenticate> createState() => _authenticateState();
}

class _authenticateState extends State<authenticate> {
  
    bool showSignIn = true;
    toggleView(){
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


