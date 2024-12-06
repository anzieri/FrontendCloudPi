import "package:flutter/material.dart";

class RightStuff extends StatelessWidget {
  const RightStuff({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          //padding: EdgeInsets.all(20),
          
          
          decoration: const BoxDecoration(
            //color: Colors.amber,
            //border: Border.all(width: 2),
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
          //padding: EdgeInsets.all(20),
          
          
          child:  const Image(
              image: AssetImage("assets/pics/filledpi.png"),
              //fit: BoxFit.cover,
              width: 500,),
             ) ,
        
      ]  ,
    );
  }
}