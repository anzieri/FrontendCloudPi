
import 'package:flutter/material.dart';
import 'package:remotefilesystem/buttons/buttons.dart';
import 'package:remotefilesystem/textfields/textfields.dart';

Future<void> dialog(
  BuildContext context, 
  String title, 
  String placeholder,
  TextEditingController controller, 
  String validationMsg,
  String buttonName,
  Function() onPressed) async{

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Textfields(
              placeholder: placeholder,
              containWidth: 200,
              fieldDescription: "",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return validationMsg;
                }
                return null;
              },
              controller: controller,
            ),
            SizedBox(height: 20),
            Buttons(
              btnName: buttonName,
              colour: Colors.amber,
              textcolour: Colors.white,
              bordercolour: Colors.transparent,
              containWidth: 200,
              containHeight: 50,
              radius: 20,
              onPressed: onPressed,
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}


Future<void> successDialog(
    BuildContext context,
    String message) async{
      
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Column(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 50),
              SizedBox(height: 10),
              Text('Success!', style: TextStyle(fontFamily: "Lexend")),
            ],
          ),
          content: Text(message, style: TextStyle(fontFamily: "Poppins")),
          actions: [
            TextButton(
              child: Text('OK', style: TextStyle(color: Colors.amber)),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

Future<void> errorDialog(
    BuildContext context,
    String message) async{
      
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Column(
            children: [
              Icon(Icons.error, color: Colors.red, size: 50),
              SizedBox(height: 10),
              Text('Error!', style: TextStyle(fontFamily: "Lexend")),
            ],
          ),
          content: Text(message, style: TextStyle(fontFamily: "Poppins")),
          actions: [
            TextButton(
              child: Text('OK', style: TextStyle(color: Colors.amber)),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  
Future<void> dialog2(
  BuildContext context, 
  String title, 
  String validationMsg,
  String buttonName,
  Function() onPressed) async{

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Buttons(
              btnName: buttonName,
              colour: Colors.amber,
              textcolour: Colors.white,
              bordercolour: Colors.transparent,
              containWidth: 200,
              containHeight: 50,
              radius: 20,
              onPressed: onPressed,
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
