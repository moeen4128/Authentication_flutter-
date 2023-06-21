import 'package:flutter/material.dart';
import 'appbars.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget eachvideo(String asset, String title) {
    return Column(
      children: [
        Stack(
          children: [
            Image.asset(asset),
            Positioned.fill(
              bottom: 10.0,
              right: 10.0,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  color: Colors.black,
                  padding: EdgeInsets.all(4.0),
                  child: Text('20:10',style: TextStyle(color: Colors.white),),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5.0,
        ),
        Container(
          color: Colors.black,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assests/logo.png'),
            ),
            title: Text(
              "$title",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.white, // Set the text color to white
              ),
            ),
            subtitle: Text(
              "Desi Programmer - 200 Views - 1 Hour",
              style: TextStyle(
                color: Colors.white, // Set the text color to white
              ),
            ),
            trailing: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
          child: Container(
            color: Colors.black,
          ),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topbar,
      bottomNavigationBar: bottomAppBar,
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            eachvideo("assests/thumb0.png", "Working with Database in Flutter"),
            eachvideo("assests/thumb1.png", "Working with Database in Flutter"),
            eachvideo("assests/thumb2.png", "Working with Database in Flutter"),
            eachvideo("assests/thumb3.png", "Working with Database in Flutter"),
            eachvideo("assests/thumb4.png", "Working with Database in Flutter"),
          ],
        ),
      ),
    );
  }
}
