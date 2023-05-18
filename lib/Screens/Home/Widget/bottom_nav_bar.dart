import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:job_endear/Screens/Authenticate/sign_in.dart';
import 'package:job_endear/Screens/CV/cv_freelancer.dart';
import 'package:job_endear/Screens/Home/ClientHome.dart';

import 'package:job_endear/Screens/ProjectList/projectlist.dart';

import 'package:job_endear/Screens/ProjectPost/project_form.dart';
import 'package:job_endear/Screens/Project_detail/applicant_list.dart';
import 'package:job_endear/Screens/Search/profile_company.dart';
import 'package:job_endear/Screens/Search/search_comapnies.dart';
import 'package:job_endear/Screens/freelancer_profile.dart/f_profile_form.dart';
import 'package:job_endear/Screens/freelancer_profile.dart/profile_post.dart';

class BottomNavigatorforApp extends StatelessWidget {
  int indexNum = 0;
  BottomNavigatorforApp({required this.indexNum});

  void _logout(context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              backgroundColor: Colors.black54,
              title: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.logout,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'signout',
                      style: TextStyle(fontSize: 28, color: Colors.white),
                    ),
                  )
                ],
              ),
              content: Text(
                "do you want to logout",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.canPop(context) ? Navigator.pop(context) : null;
                    },
                    child: Text('no',
                        style: TextStyle(color: Colors.green, fontSize: 18))),
                TextButton(
                    onPressed: () {
                      Navigator.canPop(context) ? Navigator.pop(context) : null;
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => SignIn(toggleView: () {})));
                    },
                    child: Text('yes',
                        style: TextStyle(color: Colors.green, fontSize: 18))),
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Color.fromARGB(255, 103, 175, 226),
      color: Color.fromARGB(255, 12, 98, 246),
      buttonBackgroundColor: Color.fromARGB(255, 21, 201, 159),
      height: 60,
      index: indexNum,
      items: [
        Icon(
          Icons.list,
          size: 24,
          color: Colors.black,
        ),
        Icon(
          Icons.search,
          size: 24,
          color: Colors.black,
        ),
        Icon(
          Icons.add,
          size: 24,
          color: Colors.black,
        ),
        Icon(
          Icons.person_pin,
          size: 24,
          color: Colors.black,
        ),
        Icon(
          Icons.exit_to_app,
          size: 24,
          color: Colors.black,
        ),
      ],
      animationDuration: Duration(milliseconds: 300),
      onTap: (index) {
        if (index == 0) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => Jobscreen()));
        } else if (index == 1) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => SearchScreen()));
        } else if (index == 2) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => ProjectFormView()));
        } else if (index == 3) {
          final FirebaseAuth _auth = FirebaseAuth.instance;
          final User? user = _auth.currentUser;
          final String uid = user!.uid;
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => ProjectApplicationsPage()));
        } else if (index == 4) {
          _logout(context);
        }
      },
    );
  }
}
