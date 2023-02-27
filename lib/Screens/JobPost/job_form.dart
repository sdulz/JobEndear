import 'package:flutter/material.dart';
import 'package:job_endear/Services/job_post.dart';



class ProjectFormView extends StatefulWidget {
  const ProjectFormView({Key? key}) : super(key: key);

  @override
  _ProjectFormViewState createState() => _ProjectFormViewState();
}

class _ProjectFormViewState extends State<ProjectFormView> {
  final _formKey = GlobalKey<FormState>();

  final _projectpost = Projectpost();

  late String _title;
  late String _description;
  late String _jobField;
  late String _category;
  late String _location;
  late double _budget;
  late DateTime _deadline;
  late String _requirements;
  late String _skills;
  late String _experience;
  
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Project'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              //Title
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                initialValue: _title,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some experience';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    _title = value!;
                  });
                },
              ),
              //Description
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                initialValue: _description,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some experience';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    _description = value!;
                  });
                },
              ),
              //JobField
              TextFormField(
                decoration: InputDecoration(labelText: 'Job Field'),
                initialValue: _jobField,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some experience';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    _jobField = value!;
                  });
                },
              ),
             //Category
              TextFormField(
                decoration: InputDecoration(labelText: 'Category'),
                initialValue: _category,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some experience';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    _category = value!;
                  });
                },
              ),
              //Location
            TextFormField(
                decoration: InputDecoration(labelText: 'Location'),
                initialValue: _location,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some experience';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    _location = value!;
                  });
                },
              ),
              
              //Budget
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Budget',
                ),
              
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a budget';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) {
                  
                  setState(() {
                    _budget = double.parse(value!);
                  });
                },
              ),

              //Requirement
               TextFormField(
                decoration: InputDecoration(labelText: 'Requirements'),
                initialValue: _requirements,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some requirements';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    _requirements = value!;
                  });
                },
              ),
              //Skills
              TextFormField(
                decoration: InputDecoration(labelText: 'Skills'),
                initialValue: _skills,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some skills';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    _skills = value!;
                  });
                },
              ),
              //Experience
              TextFormField(
                decoration: InputDecoration(labelText: 'Experience'),
                initialValue: _experience,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some experience';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    _experience = value!;
                  });
                },
              ),
             
             
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // TODO: Add logic to save the form data to Firebase
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