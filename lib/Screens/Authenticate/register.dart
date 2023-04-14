import 'package:flutter/material.dart';
import 'package:job_endear/Screens/Authenticate/sign_in.dart';
import 'package:job_endear/Services/auth.dart';
import 'package:job_endear/shared/loading.dart';

class Register extends StatefulWidget {
  
  final Function toggleView;
  Register({required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String firstName = '';
  String lastName = '';
  String? role;
  String? companyName;
  String? companyAddress;
  String? freelancerTitle;
  String? freelancerDescription;
  
  
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign Up to JobEndear'),
        actions: <Widget>[
          TextButton.icon(
            icon:Icon(Icons.person),
            label:Text('Sign In'),
            onPressed:(){
              widget.toggleView();
            }
          )
        ],
      ),
      body:Container(
        padding: EdgeInsets.symmetric(vertical:20.0,horizontal: 50.0),
        child:Form(
          key: _formKey,
          child:Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.email,
                  ),
                  hintText: "Enter Email",
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none, 
                ),
                
                validator:(val) => val!.isEmpty? 'Enter an Email': null,

                onChanged: (val) {
                  setState(() {
                    email=val;
                  });

                }
              
              ),
              
              SizedBox(height: 20.0),
              TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.password,
                    ),
                    hintText: "Enter Password",
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none, 
                    ),
                  
                  validator: (val) => val!.length<6? 'Password too short': null ,
                
                  onChanged: (val){
                    setState(() {
                    password=val;
                  });
                  }
                ),

                SizedBox(height: 20.0),
                TextFormField(
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.person,
                    ),
                    hintText: "Enter First Name",
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none, 
                    ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    firstName = value.trim();
                  });
                },
              ),
              
            SizedBox(height: 20.0),
             TextFormField(
              decoration: InputDecoration(
                  icon: Icon(
                   Icons.person,
                  ),
                   hintText: "Enter Last Name",
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none, 
                    ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    lastName = value.trim();
                  });
                },
              ),

              SizedBox(height: 20.0),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Select Role',
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a role';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    role = value;
                  });
                },
                items: ['Client', 'Freelancer']
                    .map((role) => DropdownMenuItem(
                          value: role,
                          child: Text(role),
                        ))
                    .toList(),
              ),
              if (role == 'Client')
                Column(
                  children: [
                    SizedBox(height: 16.0),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Company Name',
                          ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your company name';
                            }
                            return null;
                          },
                        onChanged: (value) {
                          setState(() {
                          companyName = value.trim();
                            });
                          },
                        ),
                      SizedBox(height: 16.0),
                        TextFormField(
                          decoration: InputDecoration(
                          labelText: 'Company Address',
                          ),
                      validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your company address';
                            }
                            return null;
                          },
                      onChanged: (value) {
                        setState(() {
                          companyAddress = value.trim();
                            });
                          },
                        ),
                        SizedBox(height: 20.0),
                ElevatedButton(
                  child: Text('Register'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.pink[400]),
                    textStyle: MaterialStateProperty.all(TextStyle(color: Colors.white)),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() => loading = true);
                      dynamic result = await _auth.registerClient(
                        email,
                        password,
                        firstName,
                        lastName,
                        role,
                        companyName,
                        companyAddress,
                      );
                      if (result == null) {
                        setState(() {
                          loading = false;
                          error = 'Please supply a valid email';
                        });
                      } else {
                        Navigator.pop(context);
                      }
                    }
                  },
                  )
                      ],
                    ),
                   
                //    //Freelancer
                    if (role == 'Freelancer')
                      Column(
                        children: [
                          SizedBox(height: 16.0),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Title',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your title';
                              }
                                return null;
                            },
                          onChanged: (value) {
                            setState(() {
                              freelancerTitle = value.trim();
                              });
                          },
                      ),
                      SizedBox(height: 16.0),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Description',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your description';
                            }
                             return null;
                          },
                         onChanged: (value) {
                            setState(() {
                              freelancerDescription = value.trim();
                            });
                          },
                        ),
                        SizedBox(height: 20.0),
                ElevatedButton(
                  child: Text('Register'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.pink[400]),
                    textStyle: MaterialStateProperty.all(TextStyle(color: Colors.white)),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() => loading = true);
                      dynamic result = await _auth.registerFreelancer(
                        email,
                        password,
                        firstName,
                        lastName,
                        role,
                        freelancerTitle,
                        freelancerDescription,

                      );
                      if (result == null) {
                        setState(() {
                          loading = false;
                          error = 'Please supply a valid email';
                        });
                      } else {
                        Navigator.pop(context);
                         Navigator.pushNamed(context, 'signIn');
                      }
                    }
                  },
                )
                      ],
                    ),
                
            
              

            ],
          ),
        ),
      )
    );
  }
}
