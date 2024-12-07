import "package:flutter/material.dart";
import "package:remotefilesystem/home/threedots.dart";
import "package:remotefilesystem/login/loginlogic.dart";
import "package:remotefilesystem/requests/requests.dart";
import "package:remotefilesystem/home/logichome.dart";

class Divide extends StatefulWidget {
  const Divide({super.key});

  @override
  State<Divide> createState() => _DivideState();
}

class _DivideState extends State<Divide> {
  @override
  Widget build(BuildContext context) {
    String? clientName = getClientName(getToken() ?? 'Unable to fetch token');
    String? Edit;
    String? Delete;
    String? Create;
    TextEditingController dirNameController = TextEditingController();
    TextEditingController subDirNameController = TextEditingController();

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(height: 20),
      Text("Dashboard Overview",
          style: const TextStyle(
              fontSize: 25, fontWeight: FontWeight.w500, fontFamily: "Lexend")),
      Row(children: [
        _buildStatCard(
          'Storage Used',
          '75.5 GB',
          'of 100 GB',
          Icons.storage,
          Colors.blue,
        ),
        const SizedBox(width: 16),
        _buildStatCard(
          'Files',
          '1,234',
          'Total files',
          Icons.file_present,
          Colors.green,
        ),
        const SizedBox(width: 16),
        _buildStatCard(
          'Shared Files',
          '0',
          'With others',
          Icons.share,
          Colors.orange,
        ),
      ]),
      SizedBox(height: 20),
      Container(
          padding: EdgeInsets.fromLTRB(30, 0, 50, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(237, 252, 252, 252),
          ),
          child: Row(
            children: [
              //SingleChildScrollView(
              //scrollDirection: Axis.horizontal,
              //child:
              Expanded(
                child: FutureBuilder<List<dynamic>>(
                  future: getDirList(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Container(
                        height: 300,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/pics/Cloud.png',
                              height: 200,
                            ),
                            const Text(
                              'No Files or Directories',
                              style: TextStyle(
                                  fontFamily: "Lexend",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      );
                      //Text('No data available');
                    } else {
                      return DataTable(
                        columns: const <DataColumn>[
                          DataColumn(
                            label: Text(
                              'Directory ID',
                              style: TextStyle(
                                  fontFamily: "Lexend",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Name',
                              style: TextStyle(
                                  fontFamily: "Lexend",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Owner',
                              style: TextStyle(
                                  fontFamily: "Lexend",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                            ),
                          ),
                          DataColumn(
                            mouseCursor: WidgetStateMouseCursor.clickable,
                            label: Text(
                              'Path',
                              style: TextStyle(
                                  fontFamily: "Lexend",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                            ),
                          ),
                          DataColumn(
                            mouseCursor: WidgetStateMouseCursor.clickable,
                            label: Text(
                              'Options',
                              style: TextStyle(
                                  fontFamily: "Lexend",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                            ),
                          ),
                        ],
                        rows: snapshot.data!.map((row) {
                          return DataRow(
                            cells: [
                              DataCell(Text(
                                row['dirId'].toString(),
                                style: const TextStyle(
                                    fontFamily: "Lexend",
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14),
                              )), // Convert int to string
                              DataCell(Text(
                                row['name'] ?? '',
                                style: const TextStyle(
                                    fontFamily: "Lexend",
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14),
                              )),

                              DataCell(Text(
                                "$clientName",
                                style: const TextStyle(
                                    fontFamily: "Lexend",
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14),
                              )),
                              DataCell(Text(
                                row['path'] ?? '',
                                style: const TextStyle(
                                    fontFamily: "Lexend",
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14),
                              )),
                              DataCell(ThreeDotsMenu(
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
                                          int dirId = row['dirId'];
                                          print(dirId);
                                          String newName =
                                              dirNameController.text;
                                          await postEditDirName(dirId, newName);

                                          Navigator.of(context).pop();
                                          successDialog(context,
                                              "Directory name edited successfully");
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
                                          String parentDirPath = row['path'];
                                          print(parentDirPath);
                                          String newName =
                                              subDirNameController.text;
                                          await postCreateDirInDir(
                                              newName, parentDirPath);

                                          Navigator.of(context).pop();
                                          successDialog(context,
                                              "Sub Directory Created Successfully");
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
                                      int dirId = row['dirId'];
                                      print(dirId);
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              backgroundColor: Colors.white,
                                              title: const Text(
                                                  "Delete Directory"),
                                              content: Text(
                                                "Are you sure you want to delete this directory?",
                                                style: TextStyle(
                                                    fontFamily: 'Lexend',
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w300),
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
                                                      final result =
                                                          await postDeleteDir(
                                                              dirId);
                                                      Navigator.of(context).pop(); 
                                                      if (result) {
                                                        successDialog(context,
                                                            "Directory deleted successfully");
                                                        setState(
                                                            () {}); // Refresh the list
                                                      } else {
                                                        successDialog(context,"Failed to delete directory");
                                                      }
                                                    } catch (e) {
                                                      Navigator.of(context).pop(); // Close confirmation dialog
                                                      successDialog(context,"Error deleting directory: ${e.toString()}");
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
                              ))
                            ],
                          );
                        }).toList(),
                      );
                    }
                  },
                ),
              ),
            ],
          ))
    ]);
  }
}

Widget _buildStatCard(
    String title, String value, String subtitle, IconData icon, Color color) {
  return Expanded(
    child: Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 30),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              subtitle,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    ),
  );
}
