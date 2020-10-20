import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DetailedEvents extends StatefulWidget {
  String subject;
  String description;
  DetailedEvents({Key key, @required this.subject, @required this.description})
      : super(key: key);

  @override
  _DetailedEventsState createState() => _DetailedEventsState();
}

class _DetailedEventsState extends State<DetailedEvents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subject),
      ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset('assets/1.png'),
              Text(
                widget.subject,
              ),
              Text(widget.description.toLowerCase()),
            ],
          )
        ],
      ),
    );
  }
}
