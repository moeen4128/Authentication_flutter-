import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'login.dart';
class AccountMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.account_circle),
      onPressed: () {
        showSignOutConfirmationDialog(context);
      },
    );
  }
}

void showSignOutConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Sign Out'),
        content: Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              // Sign out using Google Sign-In
              await GoogleSignIn().signOut();
              // Sign out using Facebook
              await FacebookAuth.instance.logOut();
              // Sign out using Firebase
              await FirebaseAuth.instance.signOut();

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
            child: Text('Sign Out'),
          ),
        ],
      );
    },
  );
}
AppBar topbar = AppBar(
backgroundColor: Colors.black,
  title: Image.asset('assests/yt_logo_rgb_dark.png',
  fit:BoxFit.cover,
    width: 100.0,
  ),
  actions: [
    Padding(padding: EdgeInsets.only(right: 20),
    child: Icon(Icons.videocam),
    ),
    Padding(padding: EdgeInsets.only(right: 20),
      child: Icon(Icons.search),
    ),
    Padding(padding: EdgeInsets.only(right: 20),
        child: AccountMenu(),
    ),
  ],
);

Color normalcolor= Colors.white24;
Color selectedcolor=Colors.white;
BottomAppBar bottomAppBar = BottomAppBar(
color: Colors.black,
  child: Container(
    color: Colors.black,
    height: 55.0,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.home,
            color: selectedcolor,),
            Text('Home',style: TextStyle(
              color: selectedcolor
            ),),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.explore,
            color: normalcolor,),
            Text('Explore',style: TextStyle(
                color: selectedcolor
            ),),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.add_circle_outline,
            color: normalcolor,),
            Text('Add',style: TextStyle(
                color: selectedcolor
            ),),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.subscriptions,
            color: normalcolor,),
            Text('Subscriptions',style: TextStyle(
                color: selectedcolor
            ),),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.folder,color: normalcolor,),
            Text('Library',style: TextStyle(
                color: selectedcolor
            ),),
          ],
        ),
      ],
    ),
  ),
);