import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:griev_app/widgets/AppBarWidget.dart';
import 'package:griev_app/widgets/DrawerWidget.dart';

import 'IndexScreen.dart';
import 'Page2.dart';
import 'Page2.dart';
import 'Page3.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final tabs = [
    IndexScreen(),
    Page2(),
    Page3(),
    // Page4(),
    // Page5(),
  ];
  final List<Color> tileColors = [
    Colors.green,
    Colors.blue,
    Colors.purple,
    Colors.pink,
    Colors.indigo,
    Colors.lightBlue,
    Colors.amber,
    Colors.deepOrange,
    Colors.red,
    Colors.brown
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context),
      drawer: DrawerWidget(),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: AutoSizeText(
                'Home',
                style: TextStyle(color: Color(0xFF545454)),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.plus),
              title: AutoSizeText(
                'Add',
                style: TextStyle(color: Color(0xFF545454)),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.arrowCircleUp,
              ),
              title: AutoSizeText(
                'Events & Updates',
                style: TextStyle(color: Color(0xFF545454)),
              ),
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(FontAwesomeIcons.calendarDay),
            //   title: AutoSizeText(
            //     'Feedback',
            //     style: TextStyle(color: Color(0xFF545454)),
            //   ),
            // ), BottomNavigationBarItem(
            //   icon:Icon( Icons.info_outline),
            //   title: AutoSizeText(
            //     'Suggestions',
            //     style: TextStyle(color: Color(0xFF545454)),
            //   ),
            // ),
          ],
          //currentIndex: _selectedIndex,
          selectedItemColor: Color(0xFFAA292E),
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              // navigateToScreens(index);
            });
          }),
    );
  }
}
