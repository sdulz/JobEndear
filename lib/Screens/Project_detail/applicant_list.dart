
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:job_endear/Models/UserData.dart';
// import 'package:job_endear/Models/application.dart';
// import 'package:job_endear/Services/hire.dart';
// import 'package:job_endear/Services/project_controller.dart';


// class ProjectApplicationsPage extends StatefulWidget {
//   @override
//   _ProjectApplicationsPageState createState() =>
//       _ProjectApplicationsPageState();
// }

// class _ProjectApplicationsPageState extends State<ProjectApplicationsPage> {
//   final User? user = FirebaseAuth.instance.currentUser;
//   final projectController = Get.put(ProjectController());
//   final applicationsController =
//       Get.put(ProjectApplicationsController('your_project_id_here'));

//   @override
//   void initState() {
//     super.initState();
//     if (user != null) {
//       // Replace this line with your logic to get the project applications stream
//       // _projectApplicationsStream = FirebaseFirestore.instance
//       //     .collection('jobs')
//       //     .doc(widget.project.projectId)
//       //     .collection('applications')
//       //     .snapshots();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Project Applications'),
//       ),
//       body: GetBuilder<ProjectController>(builder: (controller) {
//         if (controller.isLoading) {
//           return Center(child: CircularProgressIndicator());
//         } else {
//           // Access the application data and freelancer data from the controller
//           List<ProjectApplication> applicationData = controller.applicationData;
//           List<Freelancer> freelancerData = controller.freelancerData;

//           return ListView.builder(
//             itemCount: applicationData.length,
//             itemBuilder: (context, index) {
//               ProjectApplication application = applicationData[index];
//               // Find the corresponding freelancer for this application
//               Freelancer freelancer = freelancerData.firstWhere(
//                 (freelancer) => freelancer.freelancerId == application.uid,
//               );
//               // Display the freelancer details and project details
//               return ListTile(
//                 title: Text('Freelancer: ${freelancer.freelancerId}'),
//                 subtitle: Text('Project: ${application.projectId}'),
//                 trailing: ElevatedButton(
//                   onPressed: () {
//                     applicationsController.hireApplicant(application);
//                   },
//                   child: Text('Hire'),
//                 ),
//               );
//             },
//           );
//         }
//       }),
//     );
//   }
// }
