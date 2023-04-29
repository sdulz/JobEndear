// import 'dart:math';
// import 'package:cloud_firestore/cloud_firestore.dart';

// // Define TextRank algorithm function
// Map<String, double> textRank(String document) {
//   // Split document into sentences
//   List<String> sentences = document.split('. ');
//   // Create dictionary to store the frequency of each word
//   Map<String, int> wordFreq = {};
//   // Create dictionary to store the number of sentences containing each word
//   Map<String, int> wordSentCount = {};
//   // Create dictionary to store the important score of each word
//   Map<String, double> wordScore = {};

//   // Loop through each sentence to count the frequency of each word
//   for (String sentence in sentences) {
//     List<String> words = sentence.split(' ');
//     for (String word in words) {
//       if (wordFreq.containsKey(word)) {
//         wordFreq[word]++;
//       } else {
//         wordFreq[word] = 1;
//       }
//     }
//     // Mark the words that appeared in the current sentence
//     Set<String> distinctWords = words.toSet();
//     for (String word in distinctWords) {
//       if (wordSentCount.containsKey(word)) {
//         wordSentCount[word]++;
//       } else {
//         wordSentCount[word] = 1;
//       }
//     }
//   }

//   // Calculate the important score of each word using the TextRank algorithm
//   double dampingFactor = 0.85;
//   int maxIterations = 100;
//   double minDiff = 0.0001;
//   int numWords = wordFreq.length;
//   for (String word in wordFreq.keys) {
//     wordScore[word] = 1.0 / numWords;
//   }
//   for (int i = 0; i < maxIterations; i++) {
//     Map<String, double> newScores = {};
//     double totalDiff = 0.0;
//     for (String word in wordFreq.keys) {
//       double score = (1 - dampingFactor) / numWords;
//       for (String otherWord in wordFreq.keys) {
//         if (word == otherWord) continue;
//         if (wordSentCount.containsKey(otherWord) && sentences.contains(otherWord)) {
//           score += dampingFactor * wordScore[otherWord] / wordSentCount[otherWord];
//         }
//       }
//       newScores[word] = score;
//       totalDiff += (newScores[word] - wordScore[word]).abs();
//     }
//     wordScore = newScores;
//     if (totalDiff < minDiff) break;
//   }

//   // Return the dictionary of important scores
//   return wordScore;
// }

// // Define Cosine similarity function
// double cosineSimilarity(Map<String, double> vector1, Map<String, double> vector2) {
//   double dotProduct = 0.0;
//   double norm1 = 0.0;
//   double norm2 = 0.0;
//   for (String word in vector1.keys) {
//     if (vector2.containsKey(word)) {
//       dotProduct += vector1[word] * vector2[word];
//     }
//     norm1 += pow(vector1[word], 2);
//   }
//   for (String word in vector2.keys) {
//     norm2 += pow(vector2[word], 2);
//   }
//   double similarity = dotProduct / (sqrt(norm1) * sqrt(norm2));
//   return similarity;
// }

// Future<List<String>> recommendJobPostingsToFreelancer(String freelancerId, int n) async {
//   List<String> recommendedJobPostings = [];

//   // Fetch freelancer's skills and experience from Firebase
//   DocumentSnapshot freelancerSnapshot = await FirebaseFirestore.instance.collection('freelancers').doc(freelancerId).get();
//   List<String> freelancerSkills = List<String>.from(freelancerSnapshot.data()['skills']);
//   List<String> freelancerExperience = List<String>.from(freelancerSnapshot.data()['experience']);

//   // Fetch all job postings from Firebase
//   QuerySnapshot jobPostingsSnapshot = await FirebaseFirestore.instance.collection('jobPostings').get();

//   // Calculate the importance score of each word in the job postings using TextRank algorithm
//   Map<String, double> wordImportanceScores = {};
//   for (QueryDocumentSnapshot jobPostingSnapshot in jobPostingsSnapshot.docs) {
//     String jobPostingTitle = jobPostingSnapshot.data()['title'];
//     String jobPostingDescription = jobPostingSnapshot.data()['description'];
//     String jobPostingText = '$jobPostingTitle $jobPostingDescription';
//     List<String> jobPostingWords = jobPostingText.split(' ');

//     // Calculate the importance score of each word using TextRank algorithm
//     Map<String, double> wordScores = textRank(jobPostingWords);
    
//     // Add the importance scores to the total importance scores for all job postings
//     for (String word in wordScores.keys) {
//       if (!wordImportanceScores.containsKey(word)) {
//         wordImportanceScores[word] = 0.0;
//       }
//       wordImportanceScores[word] += wordScores[word];
//     }
//   }

//   // Sort the word importance scores in descending order
//   List<MapEntry<String, double>> sortedWordImportanceScores = wordImportanceScores.entries.toList()..sort((a, b) => b.value.compareTo(a.value));

//   // Extract the top N important words
//   List<String> importantWords = sortedWordImportanceScores.sublist(0, n).map((entry) => entry.key).toList();

//   // Calculate the similarity between each job posting and the freelancer's skills and experience using cosine similarity metric
//   Map<String, double> jobPostingSimilarities = {};
//   for (QueryDocumentSnapshot jobPostingSnapshot in jobPostingsSnapshot.docs) {
//     String jobPostingId = jobPostingSnapshot.id;
//     String jobPostingTitle = jobPostingSnapshot.data()['title'];
//     String jobPostingDescription = jobPostingSnapshot.data()['description'];
//     List<String> jobPostingSkills = List<String>.from(jobPostingSnapshot.data()['skills']);
//     List<String> jobPostingExperience = List<String>.from(jobPostingSnapshot.data()['experience']);

//     // Combine the job posting's title, description, skills, and experience into a single text
//     String jobPostingText = '$jobPostingTitle $jobPostingDescription ${jobPostingSkills.join(' ')} ${jobPostingExperience.join(' ')}';

//     // Calculate the similarity between the job posting and the freelancer's skills and experience using cosine similarity metric
//     double similarity = cosineSimilarity(jobPostingText, [...freelancerSkills, ...freelancerExperience]);

//     // Add the similarity score to the jobPostingSimilarities map
//     jobPostingSimilarities[jobPostingId] = similarity;
//   }

//   // Sort the jobPostingSimilarities map in descending order
//   List<MapEntry<String, double>> sortedJobPostingSimilarities = jobPostingSimilarities.entries.toList()..sort((a, b) => b.value.compareTo(a.value));

//   // Extract the top N recommended job postings
//  List<String> recommendTopNJobPostings(List<String> jobPostings, List<String> freelancerSkills, int n) {
//   // Create a list to store the score of each job posting
//   List<double> scores = [];
  
//   // Loop through each job posting
//   for (String jobPosting in jobPostings) {
//     // Extract the important words from the job posting
//     List<String> importantWords = getImportantWords(jobPosting);
    
//     // Calculate the similarity score between the important words and the freelancer skills
//     double score = calculateCosineSimilarity(importantWords, freelancerSkills);
    
//     // Add the score to the scores list
//     scores.add(score);
//   }
  
//   // Create a list of tuples containing the job posting and its score
//   List<Tuple2<String, double>> postingsWithScores = [];
//   for (int i = 0; i < jobPostings.length; i++) {
//     postingsWithScores.add(Tuple2(jobPostings[i], scores[i]));
//   }
  
//   // Sort the list of tuples in descending order of scores
//   postingsWithScores.sort((a, b) => b.item2.compareTo(a.item2));
  
//   // Extract the top N job postings
//   List<String> topNJobPostings = [];
//   for (int i = 0; i < n && i < postingsWithScores.length; i++) {
//     topNJobPostings.add(postingsWithScores[i].item1);
//   }
  
//   return topNJobPostings;
// }

