import 'package:flutter/material.dart';

import 'package:job_endear/Screens/ProjectPost/project_form.dart';

import 'package:job_endear/Screens/authenticate/authenticate.dart';
import 'package:job_endear/Services/auth.dart';
import 'package:job_endear/Services/project_post.dart';


class Home extends StatelessWidget {
  final Projectpost _projectController = Projectpost();
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Endear'),
        actions: <Widget>[
          ElevatedButton.icon(
            onPressed: () async {
              await _auth.signOut();
              Navigator.of(context).push(
                  MaterialPageRoute(builder: ((context) => Authenticate())));
            },
            icon: Icon(Icons.person),
            label: Text('Logout'),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Post Project', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Post Now'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProjectFormView(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
