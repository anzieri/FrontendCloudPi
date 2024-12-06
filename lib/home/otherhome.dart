import "package:flutter/material.dart";
import 'dart:html' as html;
import "package:remotefilesystem/buttons/buttons.dart";
import "package:remotefilesystem/home/customfileselect.dart";
import "package:remotefilesystem/home/dropdown.dart";
import "package:remotefilesystem/home/first_select.dart";
import "package:remotefilesystem/home/grid.dart";
import "package:remotefilesystem/home/logichome.dart";
import "package:remotefilesystem/home/secondselect.dart";
import "package:remotefilesystem/home/third_select.dart";
import "package:remotefilesystem/login/loginlogic.dart";
import "package:remotefilesystem/requests/requests.dart";

class Pagey extends StatefulWidget {
  const Pagey({super.key});

  @override
  State<Pagey> createState() => _PageyState();
}

class _PageyState extends State<Pagey> {
  String? operation;
  TextEditingController filenameController = TextEditingController();
  TextEditingController directoryIdController = TextEditingController();
  String? clientName = getClientName(getToken() ?? 'Unable to fetch token');
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    Divide(),
    GridDirectorySelect(),
    DirectorySelect(),
    
    //FileListScreen(),
    //ThirdSelect(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _selectFile() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = '.txt,.pdf,.doc,.docx,.jpg,.png,.mp4,.mkv,'; // Set file types
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      if (files!.isNotEmpty) {
        final file = files.first;
        final directoryId = int.tryParse(directoryIdController.text) ?? 0;
        postUploadFile(file, directoryId);
        successDialog(context, "File uploaded successfully");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(238, 240, 243, 247),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(
                            minWidth: 200,
                            maxWidth: 260,
                          ),
                //   child: 
                // Expanded(
                //     flex: 1,
                //     child: ConstrainedBox(
                //       //alignment: Alignment.center,
                //           constraints: const BoxConstraints(
                //             minWidth: 200,
                //             maxWidth: 260,
                //           ),
                        //color: const Color.fromARGB(238, 240, 243, 247),
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          
                           height: 200,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/pics/fixedpi.png',
                                height: 70,
                              ),
                              const Text(
                                "Nimbus",
                                style: TextStyle(
                                  fontFamily: "Lexend",
                                  fontSize: 35,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            width: 200,
                            child: DripDown(
                                label: "➕New",
                                items: const ["New Folder", "File Upload"],
                                value: operation,
                                onChanged: (value) {
                                  setState(() {
                                    operation = value;
                                  });
                                },
                                validator: (value) {},
                                icon: Icon(Icons.arrow_drop_down,
                                    color: Colors.amber))),
                        SizedBox(
                          height: 20,
                        ),
                        Buttons(
                          btnName: "Operate",
                          colour: Colors.amber, // Replace with a single color
                          textcolour: Colors.white,
                          bordercolour: Colors.transparent,
                          containWidth: 200,
                          containHeight: 50,
                          radius: 20,
                          onPressed: () {
                            if (operation == "New Folder") {
                              dialog(
                                context,
                                'New Folder',
                                "Enter Folder Name",
                                filenameController,
                                "Please enter a folder name",
                                "Create",
                                () {
                                  postCreateDir(filenameController.text);
                                  Navigator.of(context).pop();
                                  successDialog(context, "Folder Created successfully");
                                  
                                },
                              );
                            } else if (operation == "File Upload") {
                              dialog(
                                context,
                                'File Upload',
                                "Enter Directory ID",
                                directoryIdController,
                                "Please enter a valid ID",
                                "Select File",
                                () {
                                  _selectFile();
                                  Navigator.of(context).pop();
                                },
                              );
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          leading: const Icon(Icons.home),
                          title: const Text('Home',
                              style: TextStyle(
                                  fontFamily: "Lexend",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black)),
                          contentPadding: EdgeInsets.fromLTRB(80, 0, 70, 0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          onTap: () {
                            _onItemTapped(0);
                            // Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.fromLTRB(80, 0, 70, 0),
                          leading: const Icon(Icons.folder),
                          title: const Text('My Files',
                              style: TextStyle(
                                  fontFamily: "Lexend",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          onTap: () {
                            _onItemTapped(1);
                            // Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.fromLTRB(80, 0, 70, 0),
                          leading: const Icon(Icons.bar_chart),
                          title: const Text('Metrics',
                              style: TextStyle(
                                  fontFamily: "Lexend",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          onTap: () {
                            _onItemTapped(2);
                            // Navigator.pop(context);
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.4,
                        ),
                        Buttons(
                            btnName: "Signature",
                            colour: Colors.grey,
                            textcolour: Colors.black,
                            bordercolour: Colors.transparent,
                            containWidth: 400,
                            containHeight: 50,
                            radius: 9,
                            onPressed: () {}),
                        ListTile(
                          contentPadding: EdgeInsets.fromLTRB(80, 0, 70, 0),
                          leading: const Icon(Icons.dangerous),
                          title: const Text('Details',
                              style: TextStyle(
                                  fontFamily: "Lexend",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          onTap: () {
                            // _onItemTapped(1);
                            // Navigator.pop(context);
                          },
                        ),
                      ],
                //))
                )),
                
                Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                height: 80,
                                margin: EdgeInsets.fromLTRB(0, 0, 30, 0),
                                alignment: Alignment.center,
                                // decoration: BoxDecoration(
                                //   color: const Color.fromARGB(238, 240, 243, 247),
                                // ),
                                child: const Text("Help?",
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black)),
                              ),
                              Container(
                                height: 80,
                                margin: EdgeInsets.fromLTRB(0, 0, 50, 0),
                                alignment: Alignment.center,
                                //padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                // decoration: BoxDecoration(
                                //   color: const Color.fromARGB(238, 240, 243, 247),
                                // ),
                                child: Text("$clientName",
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black)),
                              )
                            ]),
//CUT FROM HERE AND PUT IN NEW FILE FOR READABILITY

                        _widgetOptions.elementAt(_selectedIndex),
                      ],
                    
                )),
              ],
            
            ),
          ],
        ));
  }
}

void main() {
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: Pagey()));
}
