import 'package:flutter/material.dart';
import 'package:youtube/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'home_page.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  final TextEditingController namecontroller =TextEditingController();
  final TextEditingController emailcontroller =TextEditingController();
  final TextEditingController passwordcontroller =TextEditingController();
  bool showPassword = false;
  void _registerUser() async {
    String email = emailcontroller.text.trim();
    String password = passwordcontroller.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all the fields.'),
        ),
      );
      return;
    }

    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Store the email and password in Firebase or perform any other actions
      // You can use userCredential.user to access the registered user

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registration successful.'),
        ),
      );

      // Navigate to the home page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home_Page()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('User already exists. Please login instead.'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registration failed. Please try again.'),
          ),
        );
        print('Error: $e');
      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Column(
            children: [
               Container(
                  child: Text('REGISTER',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: Colors.blue),),
               ),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: Column(
                  children: [
                    TextFormField(
                      controller: namecontroller,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: 'Name',
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: emailcontroller,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: 'Email',
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordcontroller,
                      obscureText: !showPassword,
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: showPassword
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: ElevatedButton(
                        onPressed: _registerUser,
                        style: ButtonStyle(
                          minimumSize:
                          MaterialStateProperty.all<Size>(Size(200, 60)),
                          padding:
                          MaterialStateProperty.all<EdgeInsetsGeometry>(
                              EdgeInsets.all(16)),
                          backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.orange),
                        ),
                        child: Text(
                          'Register',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    final double screenWidth = constraints.maxWidth;
                    final double screenHeight = constraints.maxHeight;

                    // Calculate responsive padding
                    final double leftPadding = screenWidth * 0.05;

                    // Calculate responsive font sizes
                    final double textFontSize = screenWidth * 0.04;
                    final double loginFontSize = screenWidth * 0.04;

                    return Padding(
                      padding: EdgeInsets.only(left: leftPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: TextStyle(color: Colors.grey, fontSize: textFontSize),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => Login()),
                              );
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: loginFontSize,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
