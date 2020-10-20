import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:griev_app/Models/Events.dart';
// import 'package:griev_app/Models/griev.dart';
// import 'package:griev_app/Models/updates.dart';
import 'package:griev_app/widgets/AppBarWidget.dart';

import 'firestoreservices.dart';

class PageEvents extends StatefulWidget {
  @override
  _PageEventsState createState() => _PageEventsState();
}

class _PageEventsState extends State<PageEvents> {
  List<Events> items;
  FirestoreEventsService fireServ = new FirestoreEventsService();
  StreamSubscription<QuerySnapshot> todoTasks;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();
    items = new List();

    todoTasks?.cancel();
    todoTasks = fireServ.getTaskList().listen((QuerySnapshot snapshot) {
      final List<Events> tasks = snapshot.docs
          .map((documentSnapshot) => Events.fromMap(documentSnapshot.data()))
          .toList();
      setState(() {
        this.items = tasks;
      });
    });
  }

  void _delete(String des) async {
    try {
      firestore.collection('events').document(des).delete();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: appBarWidget(context),
        // resizeToAvoidBottomInset: false,
        body: Center(
      child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Column(children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        items[index].subject,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 20.0),
                      ),
                    ],
                  ),
                ],
              ),
              // Row(
              //   children: <Widget>[
              //     Text('Category:'),
              //     Text(
              //       items[index].date,
              //       style: TextStyle(
              //           color: Colors.black,
              //           fontWeight: FontWeight.w700,
              //           fontSize: 10.0),
              //     ),
              //   ],
              // ),
              Padding(
                  padding:
                      const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
                  child: Text(
                    items[index].description.toLowerCase(),
                  )),
              Column(
                children: [
                  FlatButton.icon(
                      onPressed: () {
                        _delete(items[index].description);
                      },
                      icon: Icon(Icons.delete),
                      label: Text('Delete')),
                ],
              ),
              Divider(
                height: 30,
                color: Color(0xFFA43984),
              ),
            ]);
          }),
    ));
  }
}
