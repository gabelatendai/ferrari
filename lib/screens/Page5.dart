import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/smtp_server/gmail.dart';

class Page5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Send Mail'),),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('This is test mail form'),
                  ),
                  RaisedButton(onPressed: (){
                    sendMail();
                  },child: Text('Send'),)
                ],
              ),elevation: 3,),
            ),
          ],
        ),
      ),
    );
  }
}


sendMail() async {
  String username = 'gabrielmusodza@gmail.com';
  String password = '!@#456&*(gabriel';
  // String domainSmtp = 'mail.domain.com';

  //also use for gmail smtp
  final smtpServer = gmail(username, password);

  //user for your own domain
  // final smtpServer = SmtpServer(domainSmtp,username: username,password: password,port: 587);

  final message = Message()
    ..from = Address(username, 'Gabriel Musodza')
    ..recipients.add('gabela.musodza33@gmail.com')
  //..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
  //..bccRecipients.add(Address('bccAddress@example.com'))
    ..subject = 'Dart Mailer library  ${DateTime.now()}'
    // ..text = 'This is the plain text.\nThis is line 2 of the text part.'
    ..html = "<h1>Gabriel Musodza</h1>\n<p>Hey! Here's some HTML content</p>";

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