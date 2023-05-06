import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';

import 'package:path/path.dart';

class UploadCvPage extends StatefulWidget {
  const UploadCvPage({Key? key}) : super(key: key);

  @override
  _UploadCvPageState createState() => _UploadCvPageState();
}

class _UploadCvPageState extends State<UploadCvPage> {
  int index = 6;
  File? _selectedFile;
  bool _isUploading = false;
  String? _uploadUrl;

  Future<void> _selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result == null || result.files.single.path == null) return;

    setState(() {
      _selectedFile = File(result.files.single.path!);
    });
  }

  Future<void> _uploadFile() async {
    if (_selectedFile == null) return;

    setState(() {
      _isUploading = true;
    });

    final filename = basename(_selectedFile!.path);
    final storageRef = FirebaseStorage.instance.ref().child('cvs/$filename');

    final uploadTask = storageRef.putFile(_selectedFile!);
    final snapshot = await uploadTask.whenComplete(() {});
    final downloadUrl = await snapshot.ref.getDownloadURL();

    setState(() {
      _isUploading = false;
      _uploadUrl = downloadUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload CV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton.icon(
              onPressed: _selectFile,
              icon: Icon(Icons.attach_file),
              label: Text('Select File'),
            ),
            SizedBox(height: 16),
            if (_selectedFile != null) ...[
              Text('Selected file: ${_selectedFile!.path}'),
              //Text('Size: ${(await _selectedFile!.length()) ~/ 1024} KB'),
            ],
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _uploadFile,
              child: Text('Upload File'),
            ),
            SizedBox(height: 16),
            if (_isUploading) CircularProgressIndicator(),
            if (_uploadUrl != null)
              Text('File uploaded successfully: $_uploadUrl'),
          ],
        ),
      ),
    );
  }
}
