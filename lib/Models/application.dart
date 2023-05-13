class ProjectApplication {
  late String uid;
  // late DateTime appliedAt;
  late String? status;
  // late DateTime? hiredAt;
  late String? hiredBy;
  late String? projectId;

  ProjectApplication({
    required this.uid,
    // required this.appliedAt,
    this.status,
    // this.hiredAt,
    this.hiredBy,
    this.projectId,
  });

  ProjectApplication.fromJson(Map<String, dynamic> map) {
    uid = map['uid'].toString();
    // appliedAt = map['appliedAt'].toDate();
    status = map['status'].toString();
    // hiredAt = map['hiredAt'].toDate();
    hiredBy = map['hiredBy'].toString();
    projectId = map['projectId'].toString();
  }
  }

