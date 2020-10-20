import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
class EventsScreen extends StatefulWidget {
  EventsScreen({Key key, this.title='Firebase'}) : super(key: key);

  final String title;

  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  int _counter = 0;

  String title = "Title";
  String helper = "helper";
  String body = "body";
  String token1;

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firebaseCloudMessaging_Listeners();
    _firebaseMessaging.configure(
      onMessage: (message) async{
        setState(() {
          title = message["notification"]["title"];
          helper = "You have recieved a new notification";
        });

      },
      onResume: (message) async{
        setState(() {
          title = message["data"]["title"];
          body = message["data"]["text"];
          helper = "You have open the application from notification";
        });

      },

    );
  }



  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(helper),
            Text(
              '$title',
              style: Theme.of(context).textTheme.display1,
            ),
            Text(body),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:(){ getQue();},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }



  void firebaseCloudMessaging_Listeners() {
_firebaseMessaging.getToken().then((token)
{
  print("token is " + token);
  token1= token;
  setState(() {

  });
});

  }
  Future getQue() async {
    print("final token is " + token1);
    if(token1!=null){

var response =await http.post("http://snagasportswear.com/app/notification.php"
,body:{"token":token1});
return json.decode(response.body);
    }
    else{
      print("Token is null");
    }
  }
}
