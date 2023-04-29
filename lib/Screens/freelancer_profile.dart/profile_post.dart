import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_endear/Services/f_profile.dart';
import 'package:job_endear/Services/fprofile_form.dart';

import '../../Models/UserData.dart';

class FreelancerProfileView extends StatefulWidget {
  @override
  _FreelancerProfileViewState createState() => _FreelancerProfileViewState();
}

class _FreelancerProfileViewState extends State<FreelancerProfileView> {
  Freelancer? _freelancerProfile;
  final _controller = FreelancerProfileController();

  @override
  void initState() {
    super.initState();
    _loadFreelancerProfile();
  }

  Future<void> _loadFreelancerProfile() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    final freelancerProfile = await _controller.getFreelancerProfile(uid);
    setState(() {
      _freelancerProfile = freelancerProfile;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_freelancerProfile == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Freelancer Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Category: ${_freelancerProfile!.category}'),
            Text('Skills: ${_freelancerProfile!.skills}'),
            Text('Experience: ${_freelancerProfile!.experience} years'),
          ],
        ),
      ),
    );
  }
}
