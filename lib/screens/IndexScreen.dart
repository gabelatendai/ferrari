import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_responsive/flutter_responsive.dart';

// import 'Bible.dart';
// import 'Connect.dart';
// import 'EventsPage.dart';
// import 'LiveMenu.dart';
// import 'PageR.dart';
// import 'Teachings.dart';
// import 'Updates.dart';

class IndexScreen extends StatefulWidget {
  IndexScreen({Key key}) : super(key: key);

  @override
  _IndexScreenState createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(25, 90, 25, 0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 2.0,
                        color: Colors.grey,
                      ),
                    ]),
                child: ResponsiveRow(
                  margin: EdgeInsets.only(top: 20, bottom: 5),

                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(25, 25, 5, 5),
                          child: AutoSizeText(
                            "Lets Connect".toUpperCase(),
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(25, 45, 5, 25),
                          child: AutoSizeText(
                            '201',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 40),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              print("clicked");
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(builder: (context) => PageR()),
// //
//                               );
                            },
                            child: AutoSizeText(
                              "Find More",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 10),
          GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 4.0,
              primary: false,
              shrinkWrap: true,
              mainAxisSpacing: 8.0,
              children: List.generate(choices.length, (index) {
                return Center(
                  child: SelectCard(choice: choices[index]),
                );
              }))
        ],
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.image, this.msg});
  final String title;
  final String msg;
  final String image;
}

const List<Choice> choices = const <Choice>[
  const Choice(
      title: 'Scuderia Challenge',
      image: 'assets/2.jpg',
      msg: "Watch Speed or Magic"),
  const Choice(
      title: 'Updates and Events',
      image: 'assets/c.jpg',
      msg: "Our Upcoming Events"),
  // const Choice(title: 'Italia', image:'assets/b.jpg',msg: "Ferrari World"),
  // const Choice(title: 'Complaints', image:'assets/a.png',msg: "Ferrari World "),
  // const Choice(title: 'Feedback', image:'assets/a.png',msg: "Abu Dhabi 2020"),
  // const Choice(title: 'Suggestions', image:'assets/a.png',msg: "Watch Speed or Magic"),
];

class SelectCard extends StatelessWidget {
  const SelectCard({Key key, this.choice}) : super(key: key);
  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return InkWell(
        onTap: () {
          print(choice.title);
          // if (choice.title=="Watch Live"){
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) =>  LiveMenu()),
          //   );
          // }
          // if (choice.title=="Bible"){
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) =>  Bible()),
          //   );
          // }
          // if (choice.title=="Connect"){
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) =>  ConnectPage()),
          //   );
          // }
          // if (choice.title=="Apostles Update"){
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) =>  UpadatesPage()),
          //   );
          // }
          // if (choice.title=="Teachings"){
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) =>  Teachings()),
          //   );
          // }
          // if (choice.title=="Events"){
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) =>  EventsPage()),
          //   );
          // }
        },
        child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            // color: Colors.orange,
            child: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Image.asset(
                        choice.image,
                        height: 20.17,
                      ),
                    ),
                    AutoSizeText(
                      choice.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 17.0,
                      ),
                    ),
                    Center(
                      child: Container(
                        // width:_width*0.5,
                        height: 50.0,
                        decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            )),

                        child: Center(
                          child: AutoSizeText(
                            choice.msg,
                            style: TextStyle(color: Colors.white),
                            maxLines: 1,
                          ),
                        ),
                      ),
                    )
                    // AutoSizeText(choice.msg),
                  ]),
            )));
  }
}
