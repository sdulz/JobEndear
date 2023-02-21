import 'package:flutter/material.dart';
import 'package:job_endear/Services/auth.dart';
import 'package:job_endear/Screens/Authenticate/authenticate.dart';

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
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              ElevatedButton(
                  child: Text('Register'),
                      style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Colors.pink[400]),
                          textStyle: MaterialStateProperty.all(
                          TextStyle(color: Colors.white))),
                      onPressed: () async {
                        if(_formKey.currentState!.validate()){
                          dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                         if (result == null) {
                          setState(() => error = 'Please supply a valid email');
                          } 
                        }  
                      },
                )
            ],
          ),
        ),
      )
    );
  }
}
