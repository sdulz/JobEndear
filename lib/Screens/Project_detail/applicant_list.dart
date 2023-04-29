// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:job_endear/Models/project.dart';


// class ProjectApplicationsPage extends StatefulWidget {
//   final List <Project> project;

//   ProjectApplicationsPage(this.project);

//   @override
//   _ProjectApplicationsPageState createState() => _ProjectApplicationsPageState();
// }

// class _ProjectApplicationsPageState extends State<ProjectApplicationsPage> {
//   final User? user = FirebaseAuth.instance.currentUser;
//   late Stream<QuerySnapshot> _projectApplicationsStream;

//   @override
//   void initState() {
//     super.initState();
//     if (user != null) {
//       _projectApplicationsStream = FirebaseFirestore.instance
//           .collection('jobs')
//           .doc(widget.project.projectId)
//           .collection('applications')
//           .snapshots();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Project Applications'),
//       ),
//       body: user == null
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : StreamBuilder<QuerySnapshot>(
//               stream: _projectApplicationsStream,
//               builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//                 if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                   return Center(
//                     child: Text('No applications found.'),
//                   );
//                 }
//                 return ListView.builder(
//                   itemCount: snapshot.data!.docs.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     final application = snapshot.data!.docs[index];
//                     if (application['userId'] == user!.uid) {
//                       // Only show the user's own application
//                       return ListTile(
//                         title: Text('Your application'),
//                         subtitle: Text('Applied at ${application['appliedAt'].toString()}'),
//                       );
//                     } else if (widget.project.clientId == user!.uid) {
//                       // Only show other applicants to the project creator
//                       return ListTile(
//                         title: Text(application['applicantName']),
//                         subtitle: Text('Applied at ${application['appliedAt'].toString()}'),
//                         trailing: ElevatedButton(
//                           onPressed: () async {
//                               // Hire the applicant and update the Firestore database
//                               final applicationRef = FirebaseFirestore.instance
//                                   .collection('jobs')
//                                   .doc(widget.project.projectId)
//                                   .collection('applications')
//                                   .doc(application.id);
//                               await applicationRef.update({'status': 'hired'});
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(content: Text('You have hired ${application['applicantName']}')));
//                             },
//                             child: Text('Hire'),
//                           ),
//                       );
//                     } else {
//                       // Do not show any other applications
//                       return Container();
//                     }
//                   },
//                 );
//               },
//             ),
//     );
//   }
// }
