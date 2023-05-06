import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:job_endear/Models/project.dart';
import 'package:job_endear/Screens/Home/Widget/bottom_nav_bar.dart';

import 'package:job_endear/Screens/ProjectList/projectlist.dart';
import 'package:job_endear/Screens/Project_detail/project_detail.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchQueryController = TextEditingController();
  String searchQuery = '';
  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      autocorrect: true,
      decoration: InputDecoration(
        hintText: 'Search for job...',
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: Colors.white,
        ),
      ),
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      onChanged: (query) => updateSearchQuery(query),
    );
  }

  List<Widget> _buildActions() {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          _clearSearchQuery();
        },
      )
    ];
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery('');
    });
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
      print(searchQuery);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color.fromARGB(255, 113, 46, 248), Colors.blueAccent],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: const [0.3, 0.8],
        ),
      ),
      child: Scaffold(
        bottomNavigationBar: BottomNavigatorforApp(indexNum: 1),
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromARGB(255, 113, 46, 248), Colors.blueAccent],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: const [0.3, 0.8],
              ),
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Jobscreen()));
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: _buildSearchField(),
          actions: _buildActions(),
        ),
        body: searchQuery.isEmpty
            ? Container()
            : StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('jobs')
                    .where('title', isGreaterThanOrEqualTo: searchQuery)
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.active) {
                    if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                      final jobList = snapshot.data!.docs
                          .map((doc) => Project.fromFirestore(doc))
                          .toList();
                      return Container(
                          child: ListView.builder(
                        itemCount: jobList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final project = jobList[index];
                          final title = project.title.toLowerCase();
                          final description = project.description.toLowerCase();
                          final keyword = searchQuery.toLowerCase();
                          if (!title.contains(keyword) &&
                              !description.contains(keyword)) {
                            return Container();
                          }
                          return ListTile(
                            title: Text(
                              project.title,
                              style: TextStyle(
                                fontSize: 20,
                                color: title.contains(keyword)
                                    ? Color.fromARGB(255, 255, 255, 255)
                                    : Color.fromARGB(255, 0, 230, 255),
                              ),
                            ),
                            subtitle: Text(
                              project.description,
                              style: TextStyle(
                                fontSize: 20,
                                color: description.contains(keyword)
                                    ? Color.fromARGB(255, 255, 255, 255)
                                    : Color.fromARGB(255, 127, 255, 122),
                              ),
                            ),
                            onTap: () {
                              // navigate to project detail screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        ProjectDetailsPage(project: project)),
                              ).then((value) {
                                // return back to search screen
                                if (value != null && value) {
                                  Navigator.pop(context);
                                }
                              });
                            },
                          );
                        },
                      ));
                    }
                  }
                  return const Center(child: Text('No jobs found.'));
                },
              ),
      ),
    );
  }
}
