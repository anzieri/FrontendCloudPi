import "package:flutter/material.dart";
import "package:jwt_decoder/jwt_decoder.dart";
import "package:provider/provider.dart";
import "package:remotefilesystem/login/authprovider.dart";

class Navbar_Login extends StatefulWidget {
  
  const Navbar_Login({super.key});

  @override
  State<Navbar_Login> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar_Login> {


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
            child:  Row(
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

              CircleAvatar(
                radius: 20,
                backgroundImage: const NetworkImage(
                  'https://via.placeholder.com/150', // Replace with actual profile image URL
                ),
              ),
                FutureBuilder<String?>(
                future: getName(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                  return const Text("Error loading email");
                  } else {
                  return Text(snapshot.data ?? "No Email",
                    style: const TextStyle(
                    fontFamily: 'Lexend',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    ));
                  }
                },
                ),
              // GestureButton(
              //   describe: "Login", 
              //   clicked: activeButton == "Login", 
              //   tapped: (){ 
              //     setActiveButton("Login"); 
              //     GoRouter.of(context).go("/login");
              //   }),

              ]
            ),
          ),

      );
  }
  
  Future<String?> getName() async {
    String? tokeni = await Provider.of<AuthProvider>(context, listen: false).getToken();
    if (tokeni != null) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(tokeni);
      return decodedToken['firstName'];
    }
    return null;
  }
  
  
}
