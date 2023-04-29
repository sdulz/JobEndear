import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_endear/Models/UserData.dart';
import 'package:job_endear/Services/fprofile_form.dart';


class FreelancerProfilePostView extends StatefulWidget {
  @override
  _FreelancerProfilePostViewState createState() => _FreelancerProfilePostViewState();
}

class _FreelancerProfilePostViewState extends State<FreelancerProfilePostView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _skillsController = TextEditingController();
  final _experienceController = TextEditingController();
  final _categoryController = TextEditingController();
  final _uid = FirebaseAuth.instance.currentUser?.uid;

  final FreelancerController _controller = FreelancerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Freelancer Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _skillsController,
                decoration: InputDecoration(
                  labelText: 'Skills (comma separated)',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your skills';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _experienceController,
                decoration: InputDecoration(
                  labelText: 'Years of Experience',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your years of experience';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _categoryController,
                decoration: InputDecoration(
                  labelText: 'Please Enter the field of expertise',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter the field of expertise';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    final freelancerProfile = Freelancer(
                      freelancerId: _uid!,
                      category: _categoryController.text,
                      skills: _skillsController.text,
                      experience: _experienceController.text.toString(),
                      createdAt: DateTime.now(),
                    );

                    await _controller.saveFreelancer(freelancerProfile);

                    Navigator.pop(context);
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
