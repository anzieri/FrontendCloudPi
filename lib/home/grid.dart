// grid.dart
import "package:flutter/material.dart";
import 'dart:html' as html;
import "package:remotefilesystem/buttons/buttons.dart";
import "package:remotefilesystem/buttons/navbuttons.dart";
import "package:remotefilesystem/home/logichome.dart";
import "package:remotefilesystem/home/threedots.dart";
import "package:remotefilesystem/requests/requests.dart";

class GridDirectorySelect extends StatefulWidget {
  const GridDirectorySelect({super.key});

  @override
  State<GridDirectorySelect> createState() => _GridDirectorySelectState();
}

class _GridDirectorySelectState extends State<GridDirectorySelect> {
  final String rootPath = 'C:\\Users\\AMARA NYANZI\\Downloads\\uploads';
  late String currentPath;
  String? currentDirName;
  String? currentDirPath;
  String? Edit;
  String? Create;
  String? Delete;
  String? Download;
  int? dirId;
  late List<String> pathSegments;
  final TextEditingController dirNameController = TextEditingController();
  final TextEditingController subDirNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    currentPath = rootPath;
    pathSegments = [getDirectoryNameFromPath(rootPath)];
  }

  String getDirectoryNameFromPath(String fullPath) {
    return fullPath.split('\\').last;
  }

  String getParentPath(String fullPath) {
    if (fullPath == rootPath || !fullPath.startsWith(rootPath)) {
      return rootPath;
    }
    final segments = fullPath.split('\\');
    return segments.sublist(0, segments.length - 1).join('\\');
  }

  void navigateToDirectory(String fullPath) {
    if (!fullPath.startsWith(rootPath)) return;

    setState(() {
      currentPath = fullPath;
      pathSegments = fullPath
          .substring(rootPath.length)
          .split('\\')
          .where((s) => s.isNotEmpty)
          .toList();
      pathSegments.insert(0, 'uploads');
    });
  }

  Widget _buildGridItem({
    required String title,
    required IconData icon,
    required Color color,
    required int dirID,
    required String dirPath,
    required VoidCallback onTap,
    String? subtitle,
  }) {
    return Card(
      elevation: 0,
      color: Colors.grey[100],
      child: InkWell(
        onTap: onTap,
        child: LayoutBuilder(
          builder: (context, constraints) {
            double iconSize =
                constraints.maxWidth * 0.6; // Icon takes 50% of card width
            iconSize = iconSize.clamp(50.0, 200.0); // Min/max icon size

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: ThreeDotsMenu(
                    iconColor: Colors.amber,
                    menuItems: [
                      PopupMenuItem(
                        child: Text(
                          'Edit',
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontFamily: 'Lexend',
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        value: Edit,
                        onTap: () {
                          dialog(
                          context,
                          'Edit Directory Name',
                          'Enter new directory name',
                          dirNameController,
                          "Please enter a valid name",
                          "Edit",
                          () async {
                            try {
                            int dirId = dirID;
                            print(dirId);
                            String newName = dirNameController.text;
                            
                            final success = await postEditDirName(dirId, newName);
                            
                            if (success) {
                              Navigator.of(context).pop();
                              successDialog(context, "Directory name edited successfully");
                            } else {
                              errorDialog(context, "Failed to edit directory name");
                            }
                            } catch (e) {
                            Navigator.of(context).pop();
                            errorDialog(context, "Error editing directory name: ${e.toString()}");
                            }
                          },
                          );
                        },
                        ),
                      PopupMenuItem(
                        child: Text(
                          'Create',
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontFamily: 'Lexend',
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        value: Create,
                        onTap: () {
                          dialog(
                          context,
                          'Create Sub Directory',
                          'Enter new sub directory name',
                          subDirNameController,
                          "Please enter a valid name",
                          "Create",
                          () async {
                            try {
                            String parentDirPath = dirPath;
                            print(parentDirPath);
                            String newName = subDirNameController.text;
                            
                            final success = await postCreateDirInDir(newName, parentDirPath);
                            
                            if (success) {
                              Navigator.of(context).pop();
                              successDialog(context, "Sub Directory Created Successfully");
                            } else {
                              errorDialog(context, "Failed to create sub directory");
                            }
                            } catch (e) {
                            Navigator.of(context).pop();
                            errorDialog(context, "Error creating directory: ${e.toString()}");
                            }
                          },
                          );
                        },
                        ),
                          PopupMenuItem(
                          child: Text(
                            'Upload File',
                            style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontFamily: 'Lexend',
                            fontWeight: FontWeight.w300,
                            ),
                          ),
                          value: 'Upload',
                          onTap: () {
                            // Implement file upload logic here
                            dialog2(
                            context,
                            'Upload File',
                            'Select a file to upload',
                            "Upload",
                            () async {
                              try {
                              dirId = dirID;
                              Navigator.of(context).pop();
                              _selectFile(dirId); // Implement file picker
                              
                              
                              } catch (e) {
                              Navigator.of(context).pop();
                              errorDialog(context, "Error uploading file: ${e.toString()}");
                              }
                            },
                            );
                          },
                          ),
                      PopupMenuItem(
                        child: Text(
                          'Delete',
                          style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.w300),
                        ),
                        value: Delete,
                        onTap: () {
                          int dirId = dirID;
                          print(dirId);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              title: const Text("Delete Directory"),
                              content: Text(
                              "Are you sure you want to delete this directory?",
                              style: TextStyle(
                                fontFamily: 'Lexend',
                                fontSize: 15,
                                fontWeight: FontWeight.w300),
                              ),
                              actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                Navigator.of(context).pop();
                                },
                                child: const Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () async {
                                try {
                                  final result = await postDeleteDir(dirId);
                                  if (result) {
                                  Navigator.of(context).pop();
                                  successDialog(context,
                                    "Directory deleted successfully");
                                  } else {
                                  errorDialog(context, 
                                    "Failed to delete directory");
                                  }
                                } catch (e) {
                                  Navigator.of(context).pop();
                                  errorDialog(context,
                                    "Error deleting directory: ${e.toString()}");
                                }
                                },
                                child: const Text("Delete"),
                              ),
                              ],
                            );
                            });
                        },
                        ),
                    ],
                  ),
                ),
                Icon(
                  icon,
                  size: iconSize,
                  color: color,
                ),
                const SizedBox(height: 8),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Lexend",
                        fontWeight: FontWeight.w300,
                        fontSize:
                            constraints.maxWidth * 0.08, // Responsive font size
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                if (subtitle != null)
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: constraints.maxWidth * 0.05,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Breadcrumb navigation (same as before)
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  NavButtons(
                      btnName: "Pie Drive",
                      colour: Colors.transparent,
                      textcolour:
                          currentPath == rootPath ? Colors.blue : Colors.black,
                      bordercolour: Colors.transparent,
                      containWidth: 300,
                      containHeight: 100,
                      radius: 20,
                      onPressed: () => navigateToDirectory(rootPath)),
                  // TextButton.icon(
                  //   icon: const Icon(Icons.folder_open, size: 25),
                  //   label: const Text('Pie Drive'),
                  //   onPressed: () => navigateToDirectory(rootPath),
                  //   style: TextButton.styleFrom(
                  //     foregroundColor:
                  //         currentPath == rootPath ? Colors.black : Colors.blue,
                  //     textStyle: TextStyle(
                  //       fontFamily: "Lexend",
                  //       fontSize: 25,
                  //       fontWeight: currentPath == rootPath
                  //           ? FontWeight.w600
                  //           : FontWeight.w400,
                  //     ),
                  //   ),
                  // ),
                  for (int i = 1; i < pathSegments.length; i++) ...[
                    const Text(">",
                        style: TextStyle(color: Colors.black, fontSize: 25)),

                    NavButtons(
                      btnName: pathSegments[i],
                      colour: Colors.transparent,
                      textcolour: i == pathSegments.length - 1
                          ? Colors.blue
                          : Colors.black,
                      bordercolour: Colors.transparent,
                      containWidth: 300,
                      containHeight: 100,
                      radius: 20,
                      onPressed: () {
                        final newPath = rootPath +
                            '\\' +
                            pathSegments.sublist(1, i + 1).join('\\');
                        navigateToDirectory(newPath);
                      },
                    )

                    // InkWell(
                    //   onTap: () {
                    //     final newPath = rootPath +
                    //         '\\' +
                    //         pathSegments.sublist(1, i + 1).join('\\');
                    //     navigateToDirectory(newPath);
                    //   },
                    //   child: Text(
                    //     pathSegments[i],
                    //     style: TextStyle(
                    //       fontSize: 25,
                    //       color: i == pathSegments.length - 1
                    //           ? Colors.black
                    //           : Colors.blue,
                    //       fontFamily: "Lexend",
                    //       fontWeight: i == pathSegments.length - 1
                    //           ? FontWeight.w600
                    //           : FontWeight.w400,
                    //     ),
                    //   ),
                    // ),
                  ],
                ],
              ),
            ),
          ),
          // Grid View
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: getDirList(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print('Current Path: $currentPath'); // Debug current path

                  // Filter directories for current level
                  final currentDirs = snapshot.data!.where((dir) {
                    final dirPath = dir['path'] as String;
                    final parentPath = getParentPath(dirPath);
                    print(
                        'Comparing dir: $dirPath with parent: $parentPath'); // Debug directory paths
                    return parentPath.toLowerCase() ==
                        currentPath.toLowerCase();
                  }).toList();

                  List<Widget> gridItems = [];

                  // Add directories first
                  gridItems.addAll(currentDirs.map((dir) => _buildGridItem(
                        title: getDirectoryNameFromPath(dir['path']),
                        icon: Icons.folder,
                        color: Colors.amber,
                        dirID: dir['dirId'],
                        dirPath: dir['path'],
                        onTap: () => navigateToDirectory(dir['path']),
                      )));

                  // Find files for current directory only
                  final currentDirFiles = snapshot.data!
                      .where((dir) =>
                          dir['path'].toLowerCase() ==
                          currentPath.toLowerCase())
                      .expand((dir) {
                        print(
                            'Checking files in directory: ${dir['path']}'); // Debug files
                        return (dir['files'] as List? ?? []);
                      })
                      .map((file) => _buildGridFile(
                            title: file['filename'] as String,
                            icon: _getFileIcon(file['filename'] as String),
                            color: _getFileColor(file['filename'] as String),
                            fileID: file['id'] as int,
                            fileName: file['filename'] as String,
                            dirPath: file['filepath'] as String,
                            onTap: () {
                              // Handle file tap
                            },
                            subtitle: getDirectoryNameFromPath(
                                file['filepath'] as String),
                          ))
                      .toList();

                  // Add files to grid items
                  gridItems.addAll(currentDirFiles);

                  if (gridItems.isEmpty) {
                    return Center(
                      //height: 500,
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/pics/Cloud.png',
                            height: 200,
                          ),
                          const Text(
                            'Nothing to see here. No Files or Directories',
                            style: TextStyle(
                                fontFamily: "Lexend",
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                        ],
                      ),
                    );
                  }

                  return LayoutBuilder(builder: (context, constraints) {
                    // Calculate number of columns based on screen width
                    int crossAxisCount = (constraints.maxWidth / 250)
                        .floor(); // 250 is minimum width per card
                    crossAxisCount = crossAxisCount < 2
                        ? 2
                        : crossAxisCount; // Minimum 2 columns

                    return GridView.count(
                      crossAxisCount: crossAxisCount,
                      padding: const EdgeInsets.all(16.0),
                      mainAxisSpacing: 16.0,
                      crossAxisSpacing: 16.0,
                      childAspectRatio: 0.8, // Adjust card height/width ratio
                      children: gridItems
                          .map((item) => ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: 300, // Maximum card width
                                  minWidth: 200, // Minimum card width
                                ),
                                child: item,
                              ))
                          .toList(),
                    );
                  });
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }

  IconData _getFileIcon(String filename) {
    final extension = filename.split('.').last.toLowerCase();
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
      default:
        return Icons.insert_drive_file;
    }
  }

  Color _getFileColor(String filename) {
    final extension = filename.split('.').last.toLowerCase();
    switch (extension) {
      case 'pdf':
        return Colors.red;
      case 'doc':
      case 'docx':
        return Colors.blue;
      case 'jpg':
      case 'jpeg':
      case 'png':
        return Colors.purple;
      default:
        return Colors.black;
    }
  }

  Widget _buildGridFile({
    required String title,
    required IconData icon,
    required Color color,
    required String dirPath,
    required int fileID,
    required String fileName,
    required VoidCallback onTap,
    String? subtitle,
  }) {
    return Card(
      elevation: 0,
      color: Colors.grey[100],
      child: InkWell(
        onTap: onTap,
        child: LayoutBuilder(
          builder: (context, constraints) {
            double iconSize =
                constraints.maxWidth * 0.5; // Icon takes 50% of card width
            iconSize = iconSize.clamp(50.0, 200.0); // Min/max icon size

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: ThreeDotsMenu(
                    iconColor: Colors.amber,
                    menuItems: [
                      PopupMenuItem(
                        child: Text(
                          'Download',
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontFamily: 'Lexend',
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        value: Download,
                        onTap: () {
                          dialog2(
                          context,
                          'Download File',
                          'You\'re about to download a file',
                          "Download",
                          () async {
                            try {
                            String parentDirPath = dirPath;
                            String filename = fileName;
                            print(parentDirPath);
                            print(filename);

                            final success = await postDownloadFile(filename, parentDirPath);
                            
                            if (success) {
                              Navigator.of(context).pop();
                              successDialog(context, "File Downloaded Successfully");
                            } else {
                              errorDialog(context, "Failed to download file");
                            }
                            } catch (e) {
                            Navigator.of(context).pop();
                            errorDialog(context, "Error downloading file: ${e.toString()}");
                            }
                          },
                          );
                        },
                      ),
                      PopupMenuItem(
                        child: Text(
                          'Delete',
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontFamily: 'Lexend',
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        value: Delete,
                        onTap: () {
                          dialog2(
                            context,
                            'Delete File',
                            'You are about to delete a file',
                            "Delete",
                            () async {
                              try {
                                final result =
                                    await postDeleteFile(fileName, dirPath);
                                
                                if (result) {
                                  Navigator.of(context).pop();
                                  successDialog(context, "File deleted successfully");
                                } else {
                                  errorDialog(context, "Failed to delete file");
                                }
                              } catch (e) {
                                Navigator.of(context).pop();
                                errorDialog(context,
                                    "Error deleting file: ${e.toString()}");
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Icon(
                  icon,
                  size: iconSize,
                  color: color,
                ),
                const SizedBox(height: 4),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Lexend",
                        fontWeight: FontWeight.w300,
                        fontSize:
                            constraints.maxWidth * 0.08, // Responsive font size
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                if (subtitle != null)
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: constraints.maxWidth * 0.05,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }


  void _selectFile(int? directoryID) async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = '.txt,.pdf,.doc,.docx,.jpg,.png,.mp4,.mkv,'; // Set file types
    uploadInput.click();

    uploadInput.onChange.listen((e) async {
      final files = uploadInput.files;
      if (files!.isNotEmpty) {
        final file = files.first;
        final directoryId = int.tryParse(directoryID.toString()) ?? 0;
        try {
          await postUploadFile(file, directoryId);
          successDialog(context, "File uploaded successfully");
        } catch (error) {
          errorDialog(context, "Error uploading file: ${error.toString()}");
        }
      }
    });
  }
}
