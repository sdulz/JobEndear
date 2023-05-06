import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:job_endear/Models/UserData.dart';

class RoleController extends GetxController{
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List <Role> roledata = [];
  bool isLoading = true;
    Future <void> getRole() async{
      
      
    try{
      String ? clientId = auth.currentUser?.uid;
      String uid = clientId.toString();
      await _firestore
                  .collection('users')
                  .where('userId' ,isEqualTo: uid)
                  .get()
                  .then(((value) {
                    
                      roledata = value.docs.map((e) => Role.fromJson(e.data())).toList();  
                      debugPrint(roledata.toString());
                      isLoading = false;
                      update();
                  
                 
                  }));
                 
    }

    catch(e){
      print(e.toString());
    }
    
}
}