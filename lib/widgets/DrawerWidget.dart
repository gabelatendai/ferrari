import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:griev_app/screens/Page4.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  String name = "";
  String msg = 'Please Login';
  String txt = 'Sign In';
  String log = 'Register';
  bool _isLogin = false;
  var loading = false;

  String address = '';
  String id = '';
  String mobile = '';
  String _username = '';
  // String newzip ='';
  var data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _checkLogin2();
    // _checkUser();
    // _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.65,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            _createDrawerHeader(),

            _createDrawerItem(
              icon: Icons.share,
              text: 'Ferrari World',
              onTap: () async {
                try {
                  // await  WcFlutterShare.share(
                  //     sharePopupTitle: 'Share',
                  //     subject: "https://play.google.com/store/apps/details?id=com.forward.fif_ad",
                  //     text: "https://play.google.com/store/apps/details?id=com.forward.fif_ad",
                  //     mimeType: 'text/plain');
                  print('e');
                } catch (e) {
                  print(e);
                }
              },
            ),

            _createDrawerItem(
                icon: Icons.call,
                text: 'Contact Us',
                onTap: () => {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => AddUpdatesPage()),
                      // )
                    }),

            _createDrawerItem(
                icon: Icons.info_outline,
                text: 'About Us',
                onTap: () => {
                      //   Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => Page5()),
                      // )
                    }),
            _createDrawerItem(
                icon: FontAwesomeIcons.user, text: txt, onTap: () => {}
                // _checkLogin()
                ),
            _createDrawerItem(
              icon: Icons.lock_open,
              text: log,
              onTap: () {
                // _setLogOut();
              },
            ),
            // Text('gabriel musodza')
          ],
        ),
      ),
    );
  }

  Widget _createDrawerHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        child: Stack(children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Image.asset(
                'assets/logo.png',
                width: 130,
                height: 130,
              ),
            ),
          ),
          Positioned(
              bottom: 12.0,
              left: 16.0,
              child: Text("$msg  $_username",
                  style: TextStyle(
                      color: Color(0xFF545454),
                      fontSize: 10.0,
                      fontWeight: FontWeight.w500))),
        ]));
  }

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(
            icon,
            color: Color(0xFF808080),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Text(
              text,
              style: TextStyle(color: Color(0xFF484848)),
            ),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
