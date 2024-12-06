import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:remotefilesystem/navbar/gesture.dart";

class Navbar extends StatefulWidget {
  
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
    String activeButton = ""; // Identifier for the active button

    void setActiveButton(String buttonName) {
      setState(() {
        activeButton = buttonName;
      });
    }

    @override
  void initState() {
    super.initState();
    //print("Initialized");
  }

  @override
  void dispose() {

    super.dispose();
    //print("disposed");
  }

  @override
  Widget build(BuildContext context) {
    return 
        Padding(
        padding: const EdgeInsets.fromLTRB(150, 50, 150, 0),
        child: 
        // ListView(
        //   children: [
            Container(
            height: 50,
               decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: Color.fromARGB(100, 231, 231, 231),
            ),
            //width: 800,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              
              const Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Text("Nimbus",
                style: TextStyle(
                fontFamily: 'Lexend',
                fontSize: 20,
                fontWeight: FontWeight.w500,
                ))
              ),

              const Expanded(child: SizedBox()),

              GestureButton(
                describe: "Home", 
                clicked: activeButton == "Home" || activeButton == "", 
                tapped: (){  
                  setActiveButton("Home"); 
                  GoRouter.of(context).go("/");
                  },),

              GestureButton(
                describe: "Careers", 
                clicked: activeButton == "Careers", 
                tapped: (){ 
                  setActiveButton("Careers"); 
                  GoRouter.of(context).go("/careers");
                },),

              GestureButton(
                describe: "Login", 
                clicked: activeButton == "Login", 
                tapped: (){ 
                  setActiveButton("Login"); 
                  GoRouter.of(context).go("/login");
                }),

              ]
            ),
          ),

      );
  }
  
  
}
