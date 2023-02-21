import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_endear/models/UserData.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  // Collection reference
  final CollectionReference _freelancersCollection =
      FirebaseFirestore.instance.collection('freelancers');
  final CollectionReference _adminsCollection =
      FirebaseFirestore.instance.collection('admins');

  // Update user data
  Future updateUserData(
      String name, String email, String password, bool isAdmin) async {
    if (isAdmin) {
      return await _adminsCollection.doc(uid).set({
        'name': name,
        'email': email,
        'isAdmin': isAdmin,
      });
    } else {
      return await _freelancersCollection.doc(uid).set({
        'name': name,
        'email': email,
        'password': password,
        'isAdmin': isAdmin,
      });
    }
  }

  // User data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return UserData(
      uid: uid,
      name: data['name'],
      email: data['email'],
      isAdmin: data['isAdmin'],
    );
  }

  // Get user document stream
  Stream<UserData> get userData {
    if (_freelancersCollection.doc(uid) != null) {
      return _freelancersCollection
          .doc(uid)
          .snapshots()
          .map(_userDataFromSnapshot);
    } else {
      return _adminsCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
    }
  }
}
