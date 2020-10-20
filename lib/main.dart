import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:griev_app/screens/Homepage.dart';
import 'package:griev_app/screens/IntroScreen.dart';
import 'package:griev_app/screens/SplashSreen.dart';

var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => HomeScreen(),
  "/intro": (BuildContext context) => IntroScreen(),
};

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
      runApp(new MaterialApp(
          theme:
          ThemeData(primaryColor: Colors.red, accentColor: Colors.yellowAccent),
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
          routes: routes));
}

