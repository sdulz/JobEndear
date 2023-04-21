import 'package:job_endear/Models/project.dart';

class UserData {
  final String uid;
  final String email;
  final String firstName;
  final String lastName;
  final String? role;
  final Client? client;
  final Freelancer? freelancer;
  

  UserData({
    required this.uid,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.role,
    this.client,
    this.freelancer,

  });
}



class Client {
  final String uid;
  final String companyName;
  final String companyAddress;
  final List  <Project> projectId;

  Client({
    required this.uid,
    required this.companyName,
    required this.companyAddress,
    required this.projectId,
  });
}

class Freelancer {
  final String uid;
  final String title;
  final String description;
  // final List<String> skillIds;
  final List<Project> projectId;

  Freelancer({
    required this.uid,
    required this.title,
    required this.description,
    // required this.skillIds,
    required this.projectId,
  });
}
