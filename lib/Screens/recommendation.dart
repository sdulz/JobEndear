import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_endear/Models/project.dart';
import 'package:job_endear/Models/sentence.dart';
import 'package:job_endear/Screens/Project_detail/project_detail.dart';
import 'package:job_endear/Services/algorithm_input.dart';
import 'package:job_endear/shared/loading.dart';
import 'package:job_endear/Services/Algorithm/textrank.dart';
import 'package:quiver/iterables.dart';

class RecommendationView extends StatefulWidget {
  const RecommendationView({super.key});

  @override
  State<RecommendationView> createState() => _RecommendationViewState();
}

class _RecommendationViewState extends State<RecommendationView> {
  final algorithmInputController = Get.put(AlgorithmInputController());
  Algorithm algorithm = Algorithm();
   String  freelancerInput= " ";
  
   List<Project> recommendedProject = [];
  List<int> recommendations = [];
  @override
  Widget build(BuildContext context) {
    algorithmInputController.getProjectData();
    algorithmInputController.getFreelancerData();
    return GetBuilder<AlgorithmInputController>(
      builder: (value) {
      if (!value.isloading) {
        var projectData = value.projectData;
        var freelancerData = value.freelancerData;
        

      freelancerInput = " ${freelancerData[0].category} ${freelancerData[0].skills} ";
        
       recommendations= getRecommendation(projectData,freelancerInput);      
        
          // Clear the recommendedProjects list before adding new projects
          recommendedProject.clear(); 
          
        for (int i = 0 ; i<5;i++){
          recommendedProject.add(projectData[recommendations[i]]);
        }
        return Scaffold(
            appBar: AppBar(
              title: Text('Recommended Projects'),
            ),
            body: ListView.builder(
              itemCount: recommendedProject.length,
              itemBuilder: (context, index) {
                Project project = recommendedProject[index];
                return ListTile(
                  title: Text(project.title),
                  subtitle: Text(project.description),
                  trailing: ElevatedButton(
                   onPressed: () {
                              // Navigate to the project detail page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ProjectDetailsPage(project: project),
                                ),
                              );
                            },
                    child: Text('View Details'),
                  ),
                );
              },
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
         
     
  
  
  List<int> getRecommendation(projectData , String freelancerInput) {
     List<double> similarity = [] ;
     List<int> topFive = [];
     freelancerInput = freelancerInput.replaceAll(",", " ");
      freelancerInput = freelancerInput.replaceAll(".", " ");
      List<String> freelancer = algorithm.extractSentences(freelancerInput);
      List<List<String>> tokFreelancer= algorithm.tokenizeSentences(freelancer);
     for (int i =0;i<projectData.length;i++)
     {
        String  projectDescription = projectData[i].description; 
        projectDescription = projectDescription.replaceAll(".", " ");
        projectDescription = projectDescription.replaceAll(",", " ");
        String projectSkill = projectData[i].skills;
        projectSkill = projectSkill.replaceAll(".", " ");
        projectSkill = projectSkill.replaceAll(",", " ");
        String totalProject = "$projectDescription $projectSkill";
        List<String> totalProjectSen = algorithm.extractSentences(totalProject);
        List <List<String>> tokTotalProject = algorithm.tokenizeSentences(totalProjectSen);
        Sentence s1 = Sentence(i, tokFreelancer[0]);
        Sentence s2 = Sentence(i+1, tokTotalProject[0]);
        double s = algorithm.sentenceSimilarity(s1, s2);
        similarity.add(s);

        
     }

     
      List<int> findMaxIndices(similarity){
        int count = 0;
        if (5<similarity.length){
        count = similarity.length;
        }
        List<int> sortedIndices = List<int>.generate(similarity.length, (index) => index);
        sortedIndices.sort(((a, b) => similarity[b].compareTo(similarity[a])));
        return sortedIndices.sublist(0,count);
      } 

      topFive = findMaxIndices(similarity);
      
      return topFive;
}
}

