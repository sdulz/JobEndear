import'package:flutter/material.dart';
import'package:job_endear/models/user.dart';
import 'package:job_endear/Screens/Home/home.dart';
import 'package:provider/provider.dart';
import 'package:job_endear/Screens/Authenticate/authenticate.dart';


class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    //return either home or authenticate widget
   if (user == null){
      return authenticate();
    } else {
      return Home();
    }
    
  }
}
