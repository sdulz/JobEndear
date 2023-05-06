// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:job_endear/Screens/Authenticate/user_state.dart';

// import 'package:job_endear/Screens/Home/Widget/bottom_nav_bar.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:url_launcher/url_launcher_string.dart';


// class ProfileScreen extends StatefulWidget {
//   final String uid = '';
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   String? firstName;
//   String email = '';
//   String phoneNumber = '';
//   String joinedAt = '';
//   bool _isLoading = false;
//   bool _isSameUser = false;

//   void getUserData() async {
//     final uid = FirebaseAuth.instance.currentUser?.uid;
//     try {
//       setState(() {
//         _isLoading = true;
//       });
//       final DocumentSnapshot userDoc = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(widget.uid)
//           .get();
//       if (!userDoc.exists) {
//         return;
//       } else {
//         setState(() {
//           firstName = userDoc.get('firstName');

//           email = userDoc.get('email');
//           phoneNumber = userDoc.get('phoneNumber');
//           Timestamp joinedAtTimeStamp = userDoc.get('createdAt');
//           var joinedDate = joinedAtTimeStamp.toDate();
//           joinedAt = '${joinedDate.year}-${joinedDate.month}-${joinedDate.day}';
//         });
//         User? user = _auth.currentUser;
//         final _uid = user?.uid;
//         setState(() {
//           _isSameUser = _uid == widget.uid;
//         });
//       }
//     } catch (error) {
//       // handle error
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     getUserData();
//   }

//   Widget userInfo({required IconData icon, required String content}) {
//     return Row(
//       children: [
//         Icon(
//           icon,
//           color: Colors.white,
//         ),
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 10),
//           child: Text(
//             content,
//             style: TextStyle(color: Colors.white54),
//           ),
//         )
//       ],
//     );
//   }

// //contct for different profile of a person
//   Widget _contactBy(
//       {required Color color, required Function fct, required IconData icon}) {
//     return CircleAvatar(
//       backgroundColor: color,
//       radius: 25,
//       child: CircleAvatar(
//         backgroundColor: Colors.white,
//         radius: 23,
//         child: IconButton(
//           icon: Icon(
//             icon,
//             color: color,
//           ),
//           onPressed: () {
//             fct();
//           },
//         ),
//       ),
//     );
//   }

//   void _mailTo() async {
//     final Uri params = Uri(
//       scheme: 'mailto',
//       path: email,
//       query:
//           'subject=Write subject here, Please&body= Hello, please write details here',
//     );
//     final url = params.toString();
//     launchUrlString(url);
//   }

//   void _callPhoneNumber() async {
//     var url = 'tel://$phoneNumber';
//     launchUrlString(url);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             Color.fromARGB(189, 191, 176, 221),
//             Color.fromARGB(207, 68, 137, 255)
//           ],
//           begin: Alignment.centerLeft,
//           end: Alignment.centerRight,
//           stops: const [0.3, 0.8],
//         ),
//       ),
//       child: Scaffold(
//         bottomNavigationBar: BottomNavigatorforApp(indexNum: 3),
//         backgroundColor: Colors.transparent,
//         body: Center(
//             child: _isLoading
//                 ? const Center(
//                     child: CircularProgressIndicator(
//                       backgroundColor: Colors.red,
//                     ),
//                   )
//                 : SingleChildScrollView(
//                     child: Padding(
//                       padding: EdgeInsets.only(top: 0),
//                       child: Stack(
//                         children: [
//                           ColoredBox(color: Colors.black12),
//                           Card(
//                             color: Color.fromARGB(148, 108, 55, 244),
//                             margin: EdgeInsets.all(30),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Padding(
//                               padding: EdgeInsets.all(8.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   SizedBox(
//                                     height: 10,
//                                   ),
//                                   Align(
//                                     alignment: Alignment.center,
//                                     child: Text(
//                                       firstName == null
//                                           ? 'Name here'
//                                           : firstName!,
//                                       style: TextStyle(
//                                         fontSize: 24.0,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 15.0,
//                                   ),
//                                   Divider(
//                                     thickness: 1,
//                                     color: Colors.white,
//                                   ),
//                                   SizedBox(
//                                     height: 30,
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.all(10),
//                                     child: Text(
//                                       'Account Information:',
//                                       style: TextStyle(
//                                         fontSize: 24.0,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 15,
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.only(left: 10),
//                                     child: userInfo(
//                                         icon: Icons.email, content: email),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.only(left: 10),
//                                     child: userInfo(
//                                         icon: Icons.phone,
//                                         content: phoneNumber),
//                                   ),
//                                   SizedBox(
//                                     height: 15.0,
//                                   ),
//                                   Divider(
//                                     thickness: 1,
//                                     color: Colors.white,
//                                   ),
//                                   SizedBox(
//                                     height: 15.0,
//                                   ),
//                                   _isSameUser
//                                       ? Container()
//                                       : Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceAround,
//                                           children: [
//                                             _contactBy(
//                                                 color: Colors.redAccent,
//                                                 fct: () {
//                                                   _mailTo();
//                                                 },
//                                                 icon: Icons.mail_outline),
//                                             _contactBy(
//                                                 color: Colors.purpleAccent,
//                                                 fct: () {
//                                                   _callPhoneNumber();
//                                                 },
//                                                 icon: Icons.call),
//                                           ],
//                                         ),
//                                   !_isSameUser
//                                       ? Container()
//                                       : Center(
//                                           child: Padding(
//                                             padding:
//                                                 EdgeInsets.only(bottom: 10),
//                                             child: MaterialButton(
//                                               onPressed: () {
//                                                 _auth.signOut();
//                                                 Navigator.push(
//                                                     context,
//                                                     MaterialPageRoute(
//                                                       builder: (context) =>
//                                                           UserState(),
//                                                     ));
//                                               },
//                                               color: Colors.black12,
//                                               elevation: 8,
//                                               shape: RoundedRectangleBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(13),
//                                               ),
//                                               child: Padding(
//                                                 padding: EdgeInsets.symmetric(
//                                                     vertical: 14),
//                                                 child: Row(
//                                                   mainAxisSize:
//                                                       MainAxisSize.min,
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.center,
//                                                   children: [
//                                                     Text(
//                                                       'logout',
//                                                       style: TextStyle(
//                                                         color: Colors.white,
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         fontSize: 28,
//                                                       ),
//                                                     ),
//                                                     SizedBox(
//                                                       width: 8,
//                                                     ),
//                                                     Icon(
//                                                       Icons.logout,
//                                                       color: Colors.white,
//                                                     )
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         )
//                                 ],
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   )),
//       ),
//     );
//   }
// }
