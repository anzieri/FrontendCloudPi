import "package:flutter/material.dart";
import "package:remotefilesystem/buttons/buttons.dart";
import "package:remotefilesystem/textfields/textfields.dart";

class RegisterMobileUI extends StatefulWidget {

  const RegisterMobileUI({super.key});

  @override
  State<RegisterMobileUI> createState() => _RegisterMobileUIState();
}

class _RegisterMobileUIState extends State<RegisterMobileUI> {
  bool? checkedValue =false;

  final _Registration2FormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    
    TextEditingController email2Controller = TextEditingController();
    TextEditingController firstName2Controller = TextEditingController();
    TextEditingController lastName2Controller = TextEditingController();
    TextEditingController password2Controller = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _Registration2FormKey,
      child:Padding(
        padding: const EdgeInsets.all(18),
      child: 
      ListView(children: [
        Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        
        children: [
          const Text("Sign up to Toribu",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 30,
            fontWeight: FontWeight.bold,
          )),
          const SizedBox(
            height: 20,
          ),
          const Text("Your Google account can be connected to your \nnew Toribu account.\nNeed some help?",
          style: TextStyle( 
            fontFamily: 'Lexend',
            fontSize: 15,
            fontWeight: FontWeight.w300,
          )),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            width: 400,
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
            child: Textfields(
              fieldDescription: "First Name", 
              placeholder: "", 
              containWidth: 200,
              controller: firstName2Controller,
              validator: (value){
                return null;
              },
              )
          ),
          const Expanded(
            flex: 1,
            child: SizedBox(height: 30,)),

          // SizedBox(height: 20,
          // child: Container(),),
          
          Expanded(
            flex: 4,
            child: Textfields(
              fieldDescription: "Laast Name", 
              placeholder: "", 
              containWidth: 200,
              controller: lastName2Controller,
              validator: (value){
                return null;
              })
          )
            ],
          ),

          ),
          const SizedBox(
            height: 10,
          ),

          Container(
            child: Textfields(
              placeholder: "example@gmail.com", 
              containWidth: 400, 
              fieldDescription: "Email",
              controller: email2Controller,
              validator: (value){
                String email = email2Controller.text;

                if(email.isEmpty){
                  return "Email cannot be empty";
                }else if(!email.contains("@")){
                  return "Email must contain @";
                }
                return null;
              },),
          ),
          const SizedBox(
            height: 30,
          ),

          Container(
            child: Textfields(
              placeholder: "6+ characters", 
              containWidth: 400, 
              fieldDescription: "Password",
              controller: password2Controller,
              validator: (value){
                String password = password2Controller.text;

                if(password.isEmpty){
                  return "Password cannot be empty";
                }else if(password.length < 6){
                  return "Password must be at least 6 characters";
                }
                return null;
              },),
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            width: 400,
            child: CheckboxListTile(
              title: const Text.rich(
                TextSpan(
                  text: "I agree with Toribu's ",
                  style: TextStyle(fontFamily: 'Lexend',
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Terms of Service',
                        style: TextStyle(
                          fontFamily: 'Lexend',
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                        )),
                        TextSpan(text: ', '),
                        TextSpan(
                  text: "Privacy Policy, and default Notification Settings.",
                  style: TextStyle(fontFamily: 'Lexend',
                            fontSize: 13,
                            fontWeight: FontWeight.w500),)

                    // can add more TextSpans here...
                  ],
                ),
              ),
            // title: const Text("I agree with Toribu's Terms of Service, Privacy Policy, and default Notification Settings.",
            // style: TextStyle(
            //   fontFamily: 'Lexend',
            //   fontSize: 13,
            // fontWeight: FontWeight.w500),),
            activeColor: Colors.green,
            value: checkedValue,
            onChanged: (newValue) {
              setState(() {
                checkedValue = newValue;
              });
            },
            controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
          ),
          ),
          const SizedBox(
            height: 30,
          ),

          Buttons(btnName: "Create Account", 
          colour: Colors.black, 
            textcolour: Colors.white,
            bordercolour: Colors.black,containWidth: 400, containHeight: 50,radius: 30, onPressed: (){},),

        ]
      )
      ],)
      
    ),)
    );
  }

}