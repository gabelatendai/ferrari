import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:griev_app/widgets/AppBarWidget.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: FirebaseScreen(),
//     );
//   }
// }

class FirebaseScreen extends StatefulWidget {
  @override
  _FirebaseScreenState createState() => _FirebaseScreenState();
}

class _FirebaseScreenState extends State<FirebaseScreen> {
  List<String> _categories = <String>['', "Complaints", "Feedback", "Suggestions"];
  String _category = '';
  bool processing = false;
  TextEditingController _description = new TextEditingController();
  TextEditingController _subject = new TextEditingController();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  void _create() async {
    setState(() {
      processing = true;
    });
    try {
      // print(_category);
      await firestore.collection('grievdb').document(_description.text).setData({
        'category': _category,
        'subject': _subject.text,
        'description': _description.text,
      });
    } catch (e) {
      print(e);
    }
    setState(() {
      processing = false;
    });
  }

  void _read() async {
    DocumentSnapshot documentSnapshot;
    try {
      documentSnapshot = await firestore.collection('users').document('testUser').get();
      print(documentSnapshot.data);
    } catch (e) {
      print(e);
    }
  }

  void _update() async {
    try {
      firestore.collection('users').document('testUser').updateData({
        'firstName': 'testUpdated',
      });
    } catch (e) {
      print(e);
    }
  }

  void _delete() async {
    try {
      firestore.collection('users').document('testUser').delete();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context),
      body: new SafeArea(
        top: false,
        bottom: false,
        child: new Form(
          key: _formKey,
          child: new ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: <Widget>[
              new FormField(
                builder: (FormFieldState state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                      icon: const Icon(Icons.category),
                      labelText: 'Category',
                    ),
                    isEmpty: _category == '',
                    child: new DropdownButtonHideUnderline(
                      child: new DropdownButton(
                        value: _category,
                        isDense: true,
                        onChanged: (String newValue) {
                          setState(() {
                            _category = newValue;
                            print(newValue);
                            state.didChange(newValue);
                          });
                        },
                        items: _categories.map((String value) {
                          return new DropdownMenuItem(
                            value: value,
                            child: new Text(value, style: TextStyle(color: Colors.black),),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
              new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.subject),
                  hintText: 'Eg: Complaint regarding lectures',
                  labelText: 'Subject',
                ),
                validator: (value) {
                  if(value.isEmpty)
                    return 'Please enter subject';
                  return null;
                },
                controller: _subject,
                textCapitalization: TextCapitalization.sentences,
              ),
              new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.description), alignLabelWithHint: true,
                  hintText: 'Enter complete details for the complaint/feedback/suggestions',
                  labelText: 'Description',
                ),
                validator: (value) {
                  if(value.isEmpty)
                    return 'Please enter description';
                  return null;
                },
                controller: _description,
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
                maxLines: null,
                maxLength: 1000,
                maxLengthEnforced: true,
              ),
              new Container(
                  padding: const EdgeInsets.only(top: 20, left: 110, right: 110),
                  child: new MaterialButton(
                    color: Colors.lightBlueAccent,
                    textColor: Colors.white,
                      child: processing == false ? Text('Sign Up',
                        style: GoogleFonts.varelaRound(fontSize: 18.0,
                            color: Colors.purple),) : CircularProgressIndicator(backgroundColor: Colors.red),
                    // child: Text('Submit', style: TextStyle(
                    //     fontWeight: FontWeight.bold, fontSize: 20)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    splashColor: Colors.lightBlue,
                    // onPressed: (){
                    //   print(_description.text);
                    // },
                      onPressed: _create
                  )),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //         RaisedButton(
              //           child: Text("Create"),
              //           onPressed: _create,
              //         ),
              //         RaisedButton(
              //           child: Text("Read"),
              //           onPressed: _read,
              //         ),
              //         RaisedButton(
              //           child: Text("Update"),
              //           onPressed: _update,
              //         ),
              //         RaisedButton(
              //           child: Text("Delete"),
              //           onPressed: _delete,
              //         ),
              //   ],
              // )
            ],
          ),
        ),
     ),
    );
  }
}