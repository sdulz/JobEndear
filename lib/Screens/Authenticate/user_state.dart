// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:job_endear/Screens/ProjectList/projectlist.dart';
// import 'package:job_endear/Screens/wrapper.dart';

// class UserState extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (ctx, userSnapShot) {
//           if (userSnapShot.data == null) {
//             print('user is not logged in yet');
//             return Wrapper();
//           } else if (userSnapShot.hasData) {
//             print('user is already logged in');
//             return Jobscreen();
//           } else if (userSnapShot.hasError) {
//             return Scaffold(
//               body: Center(
//                 child:
//                     Text('an error has ocurreed has ocurred! try again later'),
//               ),
//             );+
//           } else if (userSnapShot.connectionState == ConnectionState.waiting) {
//             return Scaffold(
//               body: Center(
//                 child: const CircularProgressIndicator(),
//               ),
//             );
//           }
//           return Scaffold(
//             body: Center(child: Text('something went wrong')),
//           );
//         });
//   }
// }
