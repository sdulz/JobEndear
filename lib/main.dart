import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:job_endear/Screens/wrapper.dart';
import 'package:job_endear/Services/auth.dart'; 
import 'package:provider/provider.dart';
import 'package:job_endear/Models/user.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
  return StreamProvider<User?>.value(
        initialData: null,
        // we access the stream function
        value: AuthService().user,
        child: MaterialApp(
          home:Wrapper()
        ),
    );  
  }
}
