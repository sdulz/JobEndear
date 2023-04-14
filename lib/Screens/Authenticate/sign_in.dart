import 'package:flutter/material.dart';
import 'package:job_endear/Screens/Home/home.dart';
import 'package:job_endear/Services/auth.dart';
import 'package:job_endear/shared/loading.dart';


class SignIn extends StatefulWidget {
  
  final Function toggleView;
  SignIn({required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
 final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

//text field state
String email='';
String password='';

  @override
  Widget build(BuildContext context) {
    return loading? Loading():Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in to JobEndear'),
        actions: <Widget>[
          TextButton.icon(
            icon:Icon(Icons.person),
            label:Text('Register'),
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
              ElevatedButton(
                      child: Text('Sign in'),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.pink[400]),
                          textStyle: MaterialStateProperty.all(
                              TextStyle(color: Colors.white))),
                     onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() => loading = true);
                          dynamic result =
                          await _auth.signInWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              loading = false;
                              error = 'Could not sign in with those credentials';
                            });
                          } else {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: ((context) => Home())));
                              }
                            }
                          },
                    ),
              SizedBox(height: 12.0),
                Text(
                  error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
                ),
            ],
          ),
        ),
      )
    );
  }
}