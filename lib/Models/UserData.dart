class UserData {
  final String uid;
  final String email;
  final String firstName;
  final String lastName;
  final String role;
  final String profileImageUrl;

  UserData({
    required this.uid,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.profileImageUrl,
  });
}

class Client {
  final String uid;
  final String companyName;
  final String companyAddress;
  final List<String> projectIds;

  Client({
    required this.uid,
    required this.companyName,
    required this.companyAddress,
    required this.projectIds,
  });
}

class Freelancer {
  final String uid;
  final String title;
  final String description;
  final List<String> skillIds;
  final List<String> projectIds;

  Freelancer({
    required this.uid,
    required this.title,
    required this.description,
    required this.skillIds,
    required this.projectIds,
  });
}
