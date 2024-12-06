import 'package:flutter/material.dart';
import 'package:remotefilesystem/left_stuff.dart';
import 'package:remotefilesystem/rightstuff.dart';

class Homie extends StatelessWidget {
 const Homie({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,

      body: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            
            Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.start,
              children: [

           LeftStuff(), 
              ]
                  ),
            ),
           

            Expanded(
              flex: 1,
              child: RightStuff(),
            ),
          ],
        ),
    
    
    );
  }
}