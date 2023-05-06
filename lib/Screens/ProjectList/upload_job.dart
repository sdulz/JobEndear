import 'package:flutter/material.dart';

import 'package:job_endear/Screens/Home/Widget/bottom_nav_bar.dart';

import '../ProjectPost/project_form.dart';
// appBar: AppBar(
//   centerTitle: true,
//   flexibleSpace: Container(
//     decoration: BoxDecoration(
//       gradient: LinearGradient(
//         colors: [Colors.deepOrange.shade300, Colors.blueAccent],
//         begin: Alignment.centerLeft,
//         end: Alignment.centerRight,
//         stops: const [0.3, 0.8],
//       ),
//     ),
//   ),
// ),

class UploadJobNow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigatorforApp(indexNum: 2),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6593FF), Color(0xFF0078FF)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: const [0.3, 0.8],
          ),
        ),
        child: SafeArea(
          child: ProjectFormView(),
        ),
      ),
    );
  }
}
