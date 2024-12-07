import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:remotefilesystem/buttons/buttons.dart";
import "package:remotefilesystem/requests/requests.dart";
import "package:remotefilesystem/textfields/textfields.dart";
// import "package:flutter_svg/flutter_svg.dart";

class RegisterUI extends StatefulWidget {
  final String role;
  const RegisterUI({super.key, required this.role});

  @override
  State<RegisterUI> createState() => _RegisterUIState();
}

class _RegisterUIState extends State<RegisterUI> {
  bool? checkedValue = false;

  //final Widget svg = SvgPicture.asset("assets/images/blob.svg",);

  final GlobalKey<FormState> registrationFormKey = GlobalKey<FormState>();
  late String role;
  late Map<String, dynamic> registerData = {
    "firstName": "",
    "lastName": "",
    "email": "",
    "password": "",
    "phoneNo": "",
    "location": "",
    "gender": "",
    "age": "",
    "userRole": ""
    //"CLIENT"
  };

  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  String? _dropDownValue;

  void clearTextfields() {
    emailController.clear();
    firstNameController.clear();
    lastNameController.clear();
    passwordController.clear();
    locationController.clear();
    phoneNoController.clear();
    ageController.clear();
    setState(() {
      _dropDownValue = null;
      checkedValue = false;
    });
  }

  @override
  void initState() {
    super.initState();
    role = widget.role.toString();
  }

  @override
  Widget build(BuildContext context) {
    print(role);
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Form(
                key: registrationFormKey,
                child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        const Text("Sign up to Nimbus",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                            "Your Google account can be connected to your new Nimbus account.\nNeed some help?",
                            style: TextStyle(
                              fontFamily: 'Lexend',
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            )),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: 500,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  flex: 4,
                                  child: Textfields(
                                    fieldDescription: "First Name",
                                    placeholder: "",
                                    containWidth: 250,
                                    controller: firstNameController,
                                    validator: (value) {
                                      String firstName =
                                          firstNameController.text;

                                      if (firstName.isEmpty) {
                                        return "First Name cannot be empty";
                                      } else if (firstName
                                          .contains(RegExp(r'[0-9]'))) {
                                        return "First Name cannot contain numbers";
                                      } else if (firstName.contains(RegExp(
                                          r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9]'))) {
                                        return "First Name cannot contain special characters";
                                      }
                                      return null;
                                    },
                                  )),
                              const Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                    height: 30,
                                  )),

                              // SizedBox(height: 20,
                              // child: Container(),),

                              Expanded(
                                  flex: 4,
                                  child: Textfields(
                                    fieldDescription: "Last Name",
                                    placeholder: "",
                                    containWidth: 250,
                                    controller: lastNameController,
                                    validator: (value) {
                                      String lastName = lastNameController.text;

                                      if (lastName.isEmpty) {
                                        return "Last Name cannot be empty";
                                      } else if (lastName
                                          .contains(RegExp(r'[0-9]'))) {
                                        return "Last Name cannot contain numbers";
                                      } else if (lastName.contains(RegExp(
                                          r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9]'))) {
                                        return "Last Name cannot contain special characters";
                                      }
                                      return null;
                                    },
                                  ))
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),

                        Container(
                          child: Textfields(
                            placeholder: "example@gmail.com",
                            containWidth: 500,
                            fieldDescription: "Email",
                            controller: emailController,
                            validator: (value) {
                              String email = emailController.text;

                              if (email.isEmpty) {
                                return "Email cannot be empty";
                              } else if (!email.contains("@")) {
                                return "Email must contain @";
                              } else if (email.contains(
                                  RegExp(r'[!#<>?":_`~;[\]\\|=+)(*&^%]'))) {
                                return "Email cannot contain special characters";
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),

                        Container(
                          child: Textfields(
                            placeholder: "6+ characters",
                            containWidth: 500,
                            fieldDescription: "Password",
                            controller: passwordController,
                            validator: (value) {
                              String password = passwordController.text;

                              if (password.isEmpty) {
                                return "Password cannot be empty";
                              } else if (password.length < 6) {
                                return "Password must be at least 6 characters";
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),

                        // const SizedBox(
                        //   height: 30,
                        // ),

                        SizedBox(
                          width: 500,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  flex: 4,
                                  child: Textfields(
                                    fieldDescription: "Phone Number",
                                    placeholder: "Start with 0",
                                    containWidth: 250,
                                    controller: phoneNoController,
                                    validator: (value) {
                                      String phoneNo = phoneNoController.text;

                                      if (phoneNo.isEmpty) {
                                        return "Phone number cannot be empty";
                                      } else if (phoneNo
                                          .contains(RegExp(r'[a-zA-Z]'))) {
                                        return "Phone number cannot contain letters";
                                      } else if (phoneNo.length < 10) {
                                        return "Phone number must be at least 10 characters";
                                      } else if (phoneNo.contains(RegExp(
                                          r'[!@#<>?":_`~;[\]\\|=+)(*&^%]'))) {
                                        return "Phone number cannot contain special characters";
                                      }
                                      return null;
                                    },
                                  )),
                              const Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                    height: 30,
                                  )),

                              // SizedBox(height: 20,
                              // child: Container(),),

                              Expanded(
                                  flex: 4,
                                  child: Textfields(
                                    fieldDescription: "Location",
                                    placeholder: "",
                                    containWidth: 250,
                                    controller: locationController,
                                    validator: (value) {
                                      String location = locationController.text;

                                      if (location.isEmpty) {
                                        return "Location cannot be empty";
                                      } else if (location
                                          .contains(RegExp(r'[0-9]'))) {
                                        return "Location cannot contain numbers";
                                      } else if (location.contains(RegExp(
                                          r'[!@#<>?":_`~;[\]\\|=+)(*&^%]'))) {
                                        return "Location cannot contain special characters";
                                      }
                                      return null;
                                    },
                                  ))
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),

                        SizedBox(
                          width: 500,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  flex: 4,
                                  child: Textfields(
                                    fieldDescription: "Age",
                                    placeholder: "",
                                    containWidth: 250,
                                    controller: ageController,
                                    validator: (value) {
                                      String age = ageController.text;

                                      if (age.isEmpty) {
                                        return "Age cannot be empty";
                                      } else if (age
                                          .contains(RegExp(r'[a-zA-Z]'))) {
                                        return "Age cannot contain letters";
                                      } else if (age.length < 2) {
                                        return "Your age can't be prehistoric!";
                                      } else if (age.contains(RegExp(
                                          r'[!@#<>?":_`~;[\]\\|=+)(*&^%]'))) {
                                        return "Your age cannot contain special characters";
                                      }
                                      return null;
                                    },
                                  )),
                              const Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                    height: 30,
                                  )),
                              Expanded(
                                flex: 4,
                                child: DropdownButton(
                                  hint: const Text("Gender"),
                                  borderRadius: BorderRadius.circular(10),
                                  alignment: Alignment.center,
                                  underline: const SizedBox.shrink(),
                                  items: const [
                                    DropdownMenuItem(
                                        value: "Male",
                                        child: Text(
                                          "Male",
                                          style: TextStyle(
                                              fontFamily: "Lexend",
                                              fontSize: 15,
                                              fontWeight: FontWeight.w200),
                                        )),
                                    DropdownMenuItem(
                                        value: "Female",
                                        child: Text(
                                          "Female",
                                          style: TextStyle(
                                              fontFamily: "Lexend",
                                              fontSize: 15,
                                              fontWeight: FontWeight.w200),
                                        )),
                                    DropdownMenuItem(
                                        value: "Other",
                                        child: Text(
                                          "Other",
                                          style: TextStyle(
                                              fontFamily: "Lexend",
                                              fontSize: 15,
                                              fontWeight: FontWeight.w200),
                                        )),
                                  ],
                                  value: _dropDownValue,
                                  onChanged: (String? value) {
                                    setState(() {
                                      _dropDownValue = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),

                        SizedBox(
                          width: 500,
                          child: CheckboxListTile(
                            title: const Text.rich(
                              TextSpan(
                                text: "I agree with Nimbus' ",
                                style: TextStyle(
                                    fontFamily: 'Lexend',
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
                                    text:
                                        "Privacy Policy, and default Notification Settings.",
                                    style: TextStyle(
                                        fontFamily: 'Lexend',
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  )

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
                            onChanged: (bool? newValue) {
                              setState(() {
                                checkedValue = newValue!;
                              });
                            },
                            controlAffinity: ListTileControlAffinity
                                .leading, //  <-- leading Checkbox
                          ),
                        ),

                        Buttons(
                          btnName: "Create Account",
                          colour: Colors.black,
                          textcolour: Colors.white,
                          bordercolour: Colors.black,
                          containWidth: 500,
                          containHeight: 50,
                          radius: 30,
                          onPressed: () {
                            if (registrationFormKey.currentState!.validate()) {
                              registerData["firstName"] =
                                  firstNameController.text;
                              registerData["lastName"] =
                                  lastNameController.text;
                              registerData["email"] = emailController.text;
                              registerData["password"] =
                                  passwordController.text;
                              registerData["phoneNo"] = phoneNoController.text;
                              registerData["location"] =
                                  locationController.text;
                              registerData["gender"] = _dropDownValue;
                              registerData["age"] = ageController.text;
                              registerData["userRole"] = role;

                              // print(jsonEncode(registerData));
                              postRegisterRequest(
                                      registerData)
                                  .then((value) {
                                print(value);
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.white,
                                      title:
                                          const Text("Registration Successful"),
                                      content: Text(
                                        "Welcome To Cloud Nimbus!",
                                        style: TextStyle(
                                            fontFamily: 'Lexend',
                                            fontSize: 15,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            GoRouter.of(context).go('/login');
                                          },
                                          child: const Text("Close"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }).catchError((error) {
                                print("Error: $error");
                              });
                            }
                            clearTextfields();
                          },
                        ),

                        const SizedBox(
                          height: 100,
                        ),
                      ]),
                )),
          ],
        ));
  }
}
