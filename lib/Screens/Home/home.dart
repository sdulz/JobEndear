import'package:flutter/material.dart';
import 'package:job_endear/Services/auth.dart';

class Home extends StatelessWidget {

final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('home'),
    );
  }
}