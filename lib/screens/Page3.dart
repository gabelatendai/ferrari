import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:griev_app/Models/Events.dart';
// import 'package:griev_app/Models/updates.dart';
import 'package:griev_app/screens/DetailedEvents.dart';
import 'package:griev_app/screens/Page4.dart';
import 'firestoreservices.dart';

class Page3 extends StatefulWidget {
  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> {
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
      print(des);
      firestore.collection('events').document(des).delete();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) => AddUpdatesPage());
            //Navigator.push(context,MaterialPageRoute(builder: (context) => ()));
          },
        ),

        // appBar: appBarWidget(context),
        // resizeToAvoidBottomInset: false,
        body: Center(
          child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 10.0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.white,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(
                      5.0,
                    ),
                  ),
                  margin: EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 6.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(
                        5.0,
                      ),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10.0,
                      ),
                      leading: Container(
                        padding: EdgeInsets.only(
                          right: 12.0,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(
                              width: 1.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        child: SizedBox(
                          height: 50.0,
                          width: 50.0,
                          child: Center(
                            child: InkWell(
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                              onTap: () => {_delete(items[index].subject)},
                            ),
                            // Image.asset(
                            //   "assets/images/quote.png",
                            //   height: 30.0,
                            //   width: 30.0,
                            //   color: Colors.white,
                            // ),
                          ),
                        ),
                      ),
                      title: Text(
                        items[index].subject.toUpperCase(),
                        style: GoogleFonts.lato(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Row(
                        children: <Widget>[
                          Icon(
                            Icons.comment,
                            color: Colors.white,
                            size: 18.0,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            items[index].description.toUpperCase(),
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // Text(
                          //   items[index].date,
                          //   style: GoogleFonts.lato(
                          //     color: Colors.white,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                        ],
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (context) => DetailedEvents(
                                description:
                                    items[index].description.toUpperCase(),
                                subject: items[index].subject.toUpperCase(),
                              ),
                            ),
                          );
                        },
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 20.0,
                        ),
                      ),
                    ),
                  ),
                );

                //  Column(
                //    children: <Widget>[
                //   Row(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     children: <Widget>[
                //       Column(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         children: <Widget>[
                //           Text(
                //             items[index].subject,
                //             style: TextStyle(
                //                 color: Colors.black,
                //                 fontWeight: FontWeight.w700,
                //                 fontSize: 20.0),
                //           ),
                //           Text(
                //             items[index].description.toLowerCase(),
                //             style: TextStyle(
                //                 color: Colors.black,
                //                 fontWeight: FontWeight.w700,
                //                 fontSize: 20.0),
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                //   Row(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     children: [
                //       Text(
                //         items[index].description.toLowerCase(),
                //       )
                //     ],
                //   ),
                //   Column(
                //     children: [
                //       FlatButton.icon(
                //           onPressed: () {
                //             _delete(items[index].description);
                //           },
                //           icon: Icon(Icons.delete),
                //           label: Text('Delete')),
                //     ],
                //   ),
                //   Divider(
                //     height: 30,
                //     color: Color(0xFFA43984),
                //   ),
                // ]);
              }),
        ));
  }
}
