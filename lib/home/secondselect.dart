import 'package:flutter/material.dart';


class FileListScreen extends StatefulWidget {
  @override
  State<FileListScreen> createState() => _FileListScreenState();
}

class _FileListScreenState extends State<FileListScreen> {
  final List<FileItem> files = [
    FileItem(name: 'Document.pdf', size: '2 MB', dateModified: '2023-10-01'),
    FileItem(name: 'Image.png', size: '1.5 MB', dateModified: '2023-09-25'),
    FileItem(name: 'Video.mp4', size: '15 MB', dateModified: '2023-09-20'),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(files.length, (index) {
          final file = files[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              leading: Icon(Icons.insert_drive_file),
              title: Text(file.name),
              subtitle: Text('Size: ${file.size}\nModified: ${file.dateModified}'),
            ),
          );
        }),
      ),
    );
  }
}

class FileItem {
  final String name;
  final String size;
  final String dateModified;

  FileItem({required this.name, required this.size, required this.dateModified});
}