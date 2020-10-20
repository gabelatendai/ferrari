import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:griev_app/screens/Homepage.dart';
import 'package:griev_app/screens/Page3.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'SecondScreen.dart';

class AddUpdatesPage extends StatefulWidget {
  @override
  _AddUpdatesPageState createState() => _AddUpdatesPageState();
}

class _AddUpdatesPageState extends State<AddUpdatesPage> {
  bool processing = false;
  TextEditingController _description = new TextEditingController();
  TextEditingController _subject = new TextEditingController();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DateTime selectedDate = DateTime.now();
  sendMail() async {
    String username = 'gabrielmusodza@gmail.com';
    String password = '!@#456&*(gabriel';

    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, 'Gabriel Musodza')
      ..recipients.add('gabela.musodza33@gmail.com')
      ..subject = '_category'
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
      ..subject = '_category'
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
      await firestore.collection('events').document(_subject.text).setData({
        // 'date': selectedDate,
        'subject': _subject.text,
        'description': _description.text,
      });
    } catch (e) {
      print(e);
    }
    // final snackBar = SnackBar(
    //   content: Text(
    //     '_category  Submitted',
    //     style: TextStyle(color: Colors.white),
    //   ),
    //   backgroundColor: Colors.red,
    // );

    // Scaffold.of(context).showSnackBar(snackBar);
    setState(() {
      processing = false;
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Event'),
      ),
      body: new SafeArea(
        top: false,
        bottom: false,
        child: new Form(
          key: _formKey,
          child: new ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: <Widget>[
              Image.asset(
                'assets/1.png',
                height: 200,
              ),

              // RaisedButton(
              //   onPressed: () => _selectDate(context), // Refer step 3
              //   child: Text(
              //     'Select date',
              //     style: TextStyle(
              //         color: Colors.black, fontWeight: FontWeight.bold),
              //   ),
              //   color: Colors.red,
              // ),

              new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.subject),
                  hintText: 'Eg: Enter Event Title',
                  labelText: 'Title',
                ),
                validator: (value) {
                  if (value.isEmpty) return 'Please enter Title';
                  return null;
                },
                controller: _subject,
                textCapitalization: TextCapitalization.sentences,
              ),
              new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.description),
                  alignLabelWithHint: true,
                  hintText: 'Enter Event details ',
                  labelText: 'Description',
                ),
                validator: (value) {
                  if (value.isEmpty) return 'Please enter description';
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
                  padding:
                      const EdgeInsets.only(top: 20, left: 110, right: 110),
                  child: new MaterialButton(
                    color: Colors.redAccent,
                    textColor: Colors.white,
                    child: processing == false
                        ? Text(
                            'Submit',
                            style: GoogleFonts.varelaRound(
                                fontSize: 18.0, color: Colors.white),
                          )
                        : CircularProgressIndicator(
                            backgroundColor: Colors.red),
                    // child: Text('Submit', style: TextStyle(
                    //     fontWeight: FontWeight.bold, fontSize: 20)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    splashColor: Colors.redAccent,
                    onPressed: () {
                      sendMail();
                      // sendE();
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
