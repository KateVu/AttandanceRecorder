/// bottom screen handle bottom navigation of the app
/// @return: navigate to correct screen when clicking on the icon at the bottom
/// @created by KateVu
/// @require dependencies:

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:record_attendance/data/bottom_nav.dart';
import 'package:record_attendance/data/my_colors.dart';
import 'package:record_attendance/screens/classes.dart';
import 'package:record_attendance/screens/timetable_screen.dart';
import 'package:record_attendance/widgets/app_drawer.dart';

class BottomNavigationScreen extends StatefulWidget {
  static const routeName = '/bottom-nav';

  final List<BottomNav> itemsNav = <BottomNav>[
    BottomNav('Classes', Icons.dashboard, null),
    BottomNav('Timetable', Icons.calendar_today, null),
    //BottomNav('Inbox', Icons.chat_bubble, null),
  ];

  @override
  _BottomNavigationScreenState createState() =>
      _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _currentIndex = 0;
  BuildContext ctx;

  final List<Map<String, Object>> _page = [
    {'page': ClassesScreen(), 'title': 'Classes'},
    {'page': TimetableScreen(), 'title': 'Timetable'},
  ];

  void _selectPage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;

    return Scaffold(
        backgroundColor: MyColors.primary,
        appBar: AppBar(
          //title: Text(_page[_currentIndex]['title']),
          title: Text(_page[_currentIndex]['title']),
          centerTitle: true,
          backgroundColor: MyColors.primary,
        ),
        drawer: AppDrawer(),
        body: _page[_currentIndex]['page'],
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
              // sets the background color of the `BottomNavigationBar`
              canvasColor: MyColors.primary,
              // sets the active color of the `BottomNavigationBar` if `Brightness` is light
              // primaryColor: Colors.red,
              // textTheme: Theme.of(context)
              //     .textTheme
              //     .copyWith(caption: new TextStyle(color: Colors.yellow))
          ),
          child: BottomNavigationBar(
            backgroundColor: MyColors.primary,
            selectedItemColor: Colors.grey.shade600,
            unselectedItemColor: Colors.white,
            currentIndex: _currentIndex,
            onTap: _selectPage,
            items: widget.itemsNav.map((BottomNav d) {
              return BottomNavigationBarItem(
                icon: Icon(d.icon),
                label: d.title,
              );
            }).toList(),
          ),
        ));
  }
}
