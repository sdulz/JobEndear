// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:job_endear/models/job.dart';
// import 'package:job_endear/services/job_post.dart';

// class FreelancerHome extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final projects = Provider.of<List<Project>>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Freelancer Home'),
//       ),
//       body: Column(
//         children: <Widget>[
//           SizedBox(height: 20.0),
//           Text(
//             'List of Projects',
//             style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 20.0),
//           Expanded(
//             child: ListView.builder(
//               itemCount: projects.length,
//               itemBuilder: (context, index) {
//                 return Card(
//                   margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
//                   child: Padding(
//                     padding: EdgeInsets.all(12.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Text(
//                           projects[index].title,
//                           style: TextStyle(
//                             fontSize: 18.0,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(height: 6.0),
//                         Text(
//                           'Category: ${projects[index].category}',
//                           style: TextStyle(fontSize: 16.0),
//                         ),
//                         SizedBox(height: 6.0),
//                         Text(
//                           'Budget: \$${projects[index].budget.toStringAsFixed(2)}',
//                           style: TextStyle(fontSize: 16.0),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

