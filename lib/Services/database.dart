import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_endear/Models/UserData.dart';


class DatabaseService {
  final String uid;
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference _clientsCollection =
      FirebaseFirestore.instance.collection('clients');
  final CollectionReference _freelancersCollection =
      FirebaseFirestore.instance.collection('freelancers');

  DatabaseService({required this.uid});

  Future<void> updateUserData(UserData userData) async {
    return await _usersCollection.doc(uid).set({
      'uid': uid,
      'email': userData.email,
      'firstName': userData.firstName,
      'lastName': userData.lastName,
      'role': userData.role,
      'profileImageUrl': userData.profileImageUrl,
    });
  }

  Future<void> updateClientData(Client client) async {
    return await _clientsCollection.doc(uid).set({
      'uid': uid,
      'companyName': client.companyName,
      'companyAddress': client.companyAddress,
      'projectIds': client.projectIds,
    });
  }

  Future<void> updateFreelancerData(Freelancer freelancer) async {
    return await _freelancersCollection.doc(uid).set({
      'uid': uid,
      'title': freelancer.title,
      'description': freelancer.description,
      'skillIds': freelancer.skillIds,
      'projectIds': freelancer.projectIds,
    });
  }

  Stream<UserData> get userData {
    return _usersCollection.doc(uid).snapshots().map((snap) {
      return UserData(
        uid: snap.get('uid'),
        email: snap.get('email'),
        firstName: snap.get('firstName'),
        lastName: snap.get('lastName'),
        role: snap.get('role'),
        profileImageUrl: snap.get('profileImageUrl'),
      );
    });
  }

  Stream<Client> get client {
    return _clientsCollection.doc(uid).snapshots().map((snap) {
      return Client(
        uid: snap.get('uid'),
        companyName: snap.get('companyName'),
        companyAddress: snap.get('companyAddress'),
        projectIds: List<String>.from(snap.get('projectIds')),
      );
    });
  }

  Stream<Freelancer> get freelancer {
    return _freelancersCollection.doc(uid).snapshots().map((snap) {
      return Freelancer(
        uid: snap.get('uid'),
        title: snap.get('title'),
        description: snap.get('description'),
        skillIds: List<String>.from(snap.get('skillIds')),
        projectIds: List<String>.from(snap.get('projectIds')),
      );
    });
  }
}