import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:griev_app/Models/griev.dart';
import 'package:griev_app/widgets/AppBarWidget.dart';

import 'firestoreservices.dart';


class GrievPage extends StatefulWidget {
  @override
  _GrievPageState createState() => _GrievPageState();
}

class _GrievPageState extends State<GrievPage> {
  List<Griev> items;
  FirestoreService fireServ = new FirestoreService();
  StreamSubscription<QuerySnapshot> todoTasks;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();
    items=new List();

    todoTasks?.cancel();
    todoTasks=fireServ.getTaskList().listen((QuerySnapshot snapshot){
      final List<Griev> tasks=snapshot.docs
          .map((documentSnapshot) => Griev.fromMap(documentSnapshot.data()))
          .toList();
      setState(() {
        this.items = tasks;
      });

    });

  }
  void _delete(String des) async {
    try {
      firestore.collection('grievdb').document(des).delete();
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context),
      // resizeToAvoidBottomInset: false,
        body: Center(

          child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Column(

                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Column(
                            children: <Widget>[

                              Text(items[index].subject,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20.0),),
                            ],
                          ),

                        ],
                      ),
                      Row(
                        children: <Widget>[

                          Text('Category:'),
                          Text(items[index].category.toUpperCase(),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 10.0),),
                        ],
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
                          child: Text(
                            items[index].description.toLowerCase(),
                          )),
                      Column(
                        children: [
                          FlatButton.icon(
                              onPressed:(){ _delete(items[index].description);},
                              icon:Icon(Icons.delete),
                              label: Text('Delete')),
                        ],
                      ),
                      Divider(height: 30,color:  Color(0xFFA43984),),
                    ]
                );
              }
          ),
        )

    );
  }



}
