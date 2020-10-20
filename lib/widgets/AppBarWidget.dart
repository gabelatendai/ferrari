
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:griev_app/screens/Events.dart';
import 'package:griev_app/screens/SecondScreen.dart';
import 'package:griev_app/screens/firestore.dart';

Widget appBarWidget(context) {
  return AppBar(
    // backgroundColor: pr,
    elevation: 0.0,
      centerTitle: true,
      title:Text('Operations'),
    actions: <Widget>[
      IconButton(
        onPressed: () {
         Navigator.push(
           context,
           MaterialPageRoute(builder: (context) =>
               SecondScreen()
           ),
         );
        },
        icon: Icon(FontAwesomeIcons.plus),
        color: Color(0xFFFFFFFF),
      ),
      // IconButton(
      //   onPressed: () {
      //    Navigator.push(
      //      context,
      //      MaterialPageRoute(builder: (context) =>
      //          EventsScreen()
      //      ),
      //    );
      //   },
      //   icon: Icon(FontAwesomeIcons.bell),
      //   color: Color(0xFFFFFFFF),
      // ),
    ],
  );
}
