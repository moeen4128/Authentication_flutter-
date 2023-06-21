import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';
class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
TextEditingController forgetPasswordController = TextEditingController();
void ResetPassword() async {
  String email = forgetPasswordController.text.trim();
  if (email.isEmpty ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Please fill in the field.'),
      ),
    );
    return;
  }
}
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    forgetPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Forgot your password?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Please enter your email address below to receive password reset instructions.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 40),
            TextField(
              controller: forgetPasswordController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                ResetPassword();
                String email = forgetPasswordController.text;
                var forgetEmail=forgetPasswordController.text.trim();
                    try{
                     await FirebaseAuth.instance.sendPasswordResetEmail(email: forgetEmail)
                          .then((value) => {
                        print("Email Sent!"),
                     Navigator.pushReplacement(
                     context,
                     MaterialPageRoute(
                     builder: (context) => Login()),
                     ),
                      });
                    }on FirebaseAuthException catch(e){
                      print("Error $e");
                    }

                // Add your forgot password logic here using the entered email
                print('Reset password for $email');
              },
              child: Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }
}
