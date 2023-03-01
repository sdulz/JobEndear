import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_ml_nlp/google_ml_nlp.dart';

class TfIdfMatrix {
  final CollectionReference _projectCollection =
      FirebaseFirestore.instance.collection('jobs');

  Future<List<List<double>>> getMatrix() async {
    EntityExtractor entityExtractor = GoogleNLP.instance.entityExtractor();

    // Step 1: Retrieve all documents from the jobs collection
    final snapshot = await _projectCollection.get();

    // Step 2: Tokenize text data from each document
    final tokens = snapshot.docs.map((doc) async {
      final title = doc['title'].toString();
      final description = doc['description'].toString();
      final titleEntities = await entityExtractor.annotate(title);
      final descriptionEntities = await entityExtractor.annotate(description);
      final titleTokens = titleEntities.map((entity) => entity.text).toList();
      final descriptionTokens = descriptionEntities.map((entity) => entity.text).toList();
      return titleTokens + descriptionTokens;
    }).toList();

    final allTokens = await Future.wait(tokens);

    // Step 3: Calculate term frequency
    final termFrequency = allTokens.map((docTokens) {
      final frequencyMap = <String, int>{};
      docTokens.forEach((token) {
        frequencyMap[token] =
            frequencyMap[token] == null ? 1 : frequencyMap[token]! + 1;
      });
      return frequencyMap;
    }).toList();

    // Step 4: Calculate inverse document frequency
    final inverseDocumentFrequency = <String, double>{};
    allTokens.expand((element) => element).toSet().forEach((token) {
      final documentsContainingToken =
          allTokens.where((element) => element.contains(token)).length;
      inverseDocumentFrequency[token] =
          log(snapshot.docs.length / documentsContainingToken);
    });

    // Step 5: Calculate tf-idf value
    final tfIdfValues = termFrequency.map((frequencyMap) {
      final tfIdfMap = <String, double>{};
      frequencyMap.forEach((token, frequency) {
        tfIdfMap[token] = frequency * inverseDocumentFrequency[token]!;
      });
      return tfIdfMap;
    }).toList();

    // Step 6: Store tf-idf values in a matrix
    final matrix = tfIdfValues.map((tfIdfMap) {
      final vector = List<double>.filled(inverseDocumentFrequency.length, 0);
      inverseDocumentFrequency.forEach((token, idf) {
        vector[inverseDocumentFrequency.keys.toList().indexOf(token)] =
            tfIdfMap[token] ?? 0;
      });
      return vector;
    }).toList();

    return matrix;
  }
}
