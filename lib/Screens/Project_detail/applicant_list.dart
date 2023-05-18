
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_endear/Models/UserData.dart';
import 'package:job_endear/Models/application.dart';
import 'package:job_endear/Models/project.dart';
import 'package:job_endear/Screens/Home/Widget/bottom_nav_bar.dart';
import 'package:job_endear/Services/hire.dart';
import 'package:job_endear/Services/project_controller.dart';


class ProjectApplicationsPage extends StatefulWidget {
  @override
  _ProjectApplicationsPageState createState() =>
      _ProjectApplicationsPageState();
}

class _ProjectApplicationsPageState extends State<ProjectApplicationsPage> {
  final User? user = FirebaseAuth.instance.currentUser;
  final projectController = Get.put(ProjectController());
  final applicationsController =
      Get.put(ProjectApplicationsController('your_project_id_here'));


 

  @override
  Widget build(BuildContext context) {
    projectController.getRole();
    return Scaffold(
      bottomNavigationBar: BottomNavigatorforApp(indexNum: 3),
      appBar: AppBar(
        title: Text('Project Applications'),
      ),
      body: GetBuilder<ProjectController>(builder: (controller) {
        if (controller.isLoading) {
          return Center(child: CircularProgressIndicator());
        } else {
          // Access the application data and freelancer data from the controller
          List<ProjectApplication> applicationData = controller.applicationData;
          List<Freelancer> freelancerData = controller.freelancerData;
          List<UserData> userData = controller.userData;
          List<Project> projectData = controller.projectData;
          return ListView.builder(
            itemCount: userData.length,
            itemBuilder: (context, index) {
            
            
             
              // Display the freelancer details and project details
              return ListTile(
                title: Text('Freelancer: ${userData[index].firstName}'),
                subtitle: Text('Expirence: ${userData[index].email}'),
                trailing: Text('Expirence: ${projectData[index].title}'),
              
                  
                 
              );
            },
          );
        }
      }),
    );
  }
}
