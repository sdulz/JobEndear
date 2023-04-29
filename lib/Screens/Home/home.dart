import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import'package:flutter/material.dart';
import 'package:job_endear/Models/UserData.dart';
import 'package:job_endear/Screens/ProjectPost/project_form.dart';
import 'package:job_endear/Screens/authenticate/authenticate.dart';
import 'package:job_endear/Services/auth.dart';
import 'package:job_endear/Services/project_post.dart';

class Home extends StatelessWidget {

final Projectpost _projectController = Projectpost();
  final AuthService _auth = AuthService();
   final useruid = FirebaseAuth.instance.currentUser?.uid;
   List <Role> role = [];
Future <void> getrole() async{
    await FirebaseFirestore.instance.collection('users').where("uid",isEqualTo: useruid).get().then((value){
        role = value.docs.map((e) => Role.fromJson(e.data())).toList();
      });
}
  @override
  Widget build(BuildContext context) {
    
   return Scaffold(
      appBar: AppBar(
        title: Text('Job Endear'),
        actions: <Widget>[
          ElevatedButton.icon(
            onPressed: () async {
              await _auth.signOut();
              getrole();
               Navigator.of(context).push(MaterialPageRoute(builder:((context) => Authenticate()) ));
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
            Text(role.toString()),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Create Project'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProjectFormView()),
                  
                );
              },
            ),
          ],
        ),
      ),
    );

  }
}
