import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_endear/Models/project.dart';
import 'package:job_endear/Screens/Project_detail/project_detail.dart';

class ProjectList extends StatelessWidget {
  const ProjectList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Project>>(
        stream: FirebaseFirestore.instance.collection('jobs').snapshots().map((snapshot) {
          return snapshot.docs.map((doc) => Project.fromFirestore(doc)).toList();
        }),
      builder: (BuildContext context, AsyncSnapshot<List<Project>> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Text('Loading...');
          default:
            final List<Project> projects = snapshot.data ?? <Project>[];

            return ListView.builder(
              itemCount: projects.length,
              itemBuilder: (BuildContext context, int index) {
                final Project project = projects[index];

                return ListTile(
                  title: Text(project.title),
                  subtitle: Text(project.description),
                  trailing: Text('\$${project.budget.toStringAsFixed(2)}'),
                  onTap: () {
                    // navigate to project details page
                     Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProjectDetailsPage(project: project,)),
                    );
                  },
                );
              },
            );
        }
      },
    ));
  }
}