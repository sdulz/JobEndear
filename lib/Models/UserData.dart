class UserData {
  final String uid;
  final String name;
  final String email;
  final bool isAdmin;

  UserData({
    required this.uid,
    required this.name,
    required this.email,
    required this.isAdmin,
  });

  factory UserData.fromMap(Map<String, dynamic>? data) {
    if (data == null) {
      return UserData(uid: '', name: '', email: '', isAdmin: false);
    }

    return UserData(
      uid: data['uid'] ?? '',
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      isAdmin: data['isAdmin'] ?? false,
    );
  }
}
