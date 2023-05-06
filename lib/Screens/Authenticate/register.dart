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
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Color.fromARGB(255, 179, 214, 184),
            appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 235, 135, 99),
              centerTitle: true,
              title: Text('Register to JobEndear'),
              actions: <Widget>[
                TextButton.icon(
                    icon: Icon(
                      Icons.person,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    label: Text(
                      'Sign In',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      widget.toggleView();
                    })
              ],
            ),
            body: SingleChildScrollView(
                child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10.0),
                    TextFormField(
                        style: TextStyle(color: Colors.white, fontSize: 20.00),
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                          hintText: "Enter Email",
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 255, 255),
                                width: 5.00),
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.lightBlueAccent,
                            width: 2.0,
                          )),
                        ),
                        validator: (val) =>
                            val!.isEmpty ? 'Enter an Email' : null,
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        }),

                    SizedBox(height: 10.0),
                    TextFormField(
                        style: TextStyle(color: Colors.white, fontSize: 20.00),
                        obscureText: _obscure,
                        decoration: InputDecoration(
                            icon: Icon(
                              Icons.password,
                              color: Colors.white,
                            ),
                            hintText: "Enter Password",
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  width: 5.00),
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.lightBlueAccent,
                              width: 2.0,
                            )),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obscure = !_obscure;
                                  });
                                },
                                icon: Icon(
                                  _obscure
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.brown,
                                ))),
                        validator: (val) =>
                            val!.length < 6 ? 'Password too short' : null,
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        }),

                    SizedBox(height: 10.0),
                    TextFormField(
                      style: TextStyle(color: Colors.white, fontSize: 20.00),
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        hintText: "Enter First Name",
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 255, 255, 255),
                              width: 5.00),
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.lightBlueAccent,
                          width: 2.0,
                        )),
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

                    SizedBox(height: 10.0),
                    TextFormField(
                      style: TextStyle(color: Colors.white, fontSize: 20.00),
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        hintText: "Enter Last Name",
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 255, 255, 255),
                              width: 5.00),
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.lightBlueAccent,
                          width: 2.0,
                        )),
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

                    SizedBox(height: 10.0),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        hintText: 'Select Role',
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 255, 255, 255),
                              width: 5.00),
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.lightBlueAccent,
                          width: 2.0,
                        )),
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
                          SizedBox(height: 10.0),
                          TextFormField(
                            style: TextStyle(
                              color: Colors.white,
                            ),
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
                          SizedBox(height: 10.0),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                labelText: 'Company Address',
                                iconColor: Color.fromARGB(255, 212, 91, 91)),
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
                          SizedBox(height: 10.0),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            child: MaterialButton(
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
                              color: Colors.cyan,
                              elevation: 15,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 14),
                                child: Text(
                                  'Register',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 24),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),

                    //    //Freelancer
                    if (role == 'Freelancer')
                      Column(
                        children: [
                          SizedBox(height: 10.0),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                labelText: 'Title', iconColor: Colors.black12),
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
                          SizedBox(height: 10.0),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'Description',
                              iconColor: Color.fromARGB(31, 64, 5, 5),
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
                          SizedBox(height: 10.0),
                          MaterialButton(
                            color: Colors.cyan,
                            elevation: 15,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 14),
                              child: Text(
                                'Register ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 24),
                              ),
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
            )));
  }
}
