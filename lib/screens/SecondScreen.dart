import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:griev_app/widgets/AppBarWidget.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'GrievanceScreen.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {


  List<String> _categories = <String>['', "Your Voice Matters", "Recommendations", "Feedback", "Suggestions", "Colleague of the Month"];
  String _category = '';
  bool processing = false;
  TextEditingController _description = new TextEditingController();
  TextEditingController _subject = new TextEditingController();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  sendMail() async {
    String username = 'gabrielmusodza@gmail.com';
    String password = '!@#456&*(gabriel';
    // String domainSmtp = 'mail.domain.com';
// gcarelse@ferrariworld-ad.com
    //also use for gmail smtp
    final smtpServer = gmail(username, password);

    //user for your own domain
    // final smtpServer = SmtpServer(domainSmtp,username: username,password: password,port: 587);

    final message = Message()
      ..from = Address(username, 'Gabriel Musodza')
      ..recipients.add('gabela.musodza33@gmail.com')
    //..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
    //..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = '${_category}'
    // ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = "<h1>${_subject.text}</h1>\n<p>${_description.text}</p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.' + e.toString());
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }

  }
  sendE() async {
    String username = 'gabrielmusodza@gmail.com';
    String password = '!@#456&*(gabriel';
    // String domainSmtp = 'mail.domain.com';
// gcarelse@ferrariworld-ad.com
    //also use for gmail smtp
    final smtpServer = gmail(username, password);

    //user for your own domain
    // final smtpServer = SmtpServer(domainSmtp,username: username,password: password,port: 587);

    final message = Message()
      ..from = Address(username, 'Ferrari Operations 2020')
      ..recipients.add('gcarelse@ferrariworld-ad.com')
    //..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
    //..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = '${_category}'
    // ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = "<h1>${_subject.text}</h1>\n<p>${_description.text}</p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.' + e.toString());
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }

  }
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
    final snackBar = SnackBar(
      content: Text(
        '${_category}  Submitted',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    );

    Scaffold.of(context).showSnackBar(snackBar);
    setState(() {
      processing = false;
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SecondScreen()) ,
    );
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
              Image.asset('assets/logo.png',height: 200,),
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
                    color: Colors.redAccent,
                    textColor: Colors.white,
                    child: processing == false ? Text('Submit',
                      style: GoogleFonts.varelaRound(fontSize: 18.0,
                          color: Colors.white),) : CircularProgressIndicator(backgroundColor: Colors.red),
                    // child: Text('Submit', style: TextStyle(
                    //     fontWeight: FontWeight.bold, fontSize: 20)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    splashColor: Colors.redAccent,
                    onPressed: (){
                      sendMail();
                      sendE();
                      _create();
                      print(_description.text);
                    },
                    // onPressed: _create
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