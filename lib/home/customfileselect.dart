import "package:flutter/material.dart";
import "package:remotefilesystem/buttons/buttons.dart";
import "package:remotefilesystem/requests/requests.dart";

class DirectorySelect extends StatefulWidget {
  const DirectorySelect({super.key});

  @override
  State<DirectorySelect> createState() => _DirectorySelectState();
}

class _DirectorySelectState extends State<DirectorySelect> {
  String? selectedFilePath;

  String getFileExtension(String filename) {
    return filename.contains('.') ? filename.split('.').last.toLowerCase() : '';
  }

  IconData getFileIcon(String filename) {
    final extension = getFileExtension(filename);
    switch (extension) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'doc':
      case 'docx':
        return Icons.description;
      case 'jpg':
      case 'jpeg':
      case 'png':
        return Icons.image;
      case 'mp4':
      case 'mkv':
        return Icons.video_file;
      default:
        return Icons.insert_drive_file;
    }
  }

  Color getFileColor(String filename) {
    final extension = getFileExtension(filename);
    switch (extension) {
      case 'pdf':
        return Colors.red;
      case 'doc':
      case 'docx':
        return Colors.blue;
      case 'jpg':
      case 'jpeg':
      case 'png':
        return Colors.green;
      case 'mp4':
      case 'mkv':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 700,
      child: FutureBuilder<List<dynamic>>(
        future: getFileList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error loading files: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No files available'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final file = snapshot.data![index];
              final fileName = file['filename'] as String;
              final filePath = file['filepath'] as String;
              
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: ListTile(
                  leading: Icon(
                    getFileIcon(fileName),
                    color: getFileColor(fileName),
                    size: 32,
                  ),
                  title: Text(
                    fileName,
                    style: const TextStyle(
                      fontFamily: "Lexend",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text(
                    filePath,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                  trailing: PopupMenuButton(
                    icon: const Icon(Icons.more_vert),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: const Text('Download'),
                        onTap: () => postDownloadFile(fileName, filePath),
                      ),
                      PopupMenuItem(
                        child: const Text('Delete'),
                        onTap: () => postDeleteFile(fileName, filePath),
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      selectedFilePath = filePath;
                    });
                  },
                  selected: filePath == selectedFilePath,
                ),
              );
            },
          );
        },
      ),
    );
  }
}