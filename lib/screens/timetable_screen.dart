import 'package:flutter/material.dart';

class TimetableScreen extends StatefulWidget {
  static const routeName = '/timetable';

  @override
  _TimetableScreenState createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen>
    with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        //height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.all(30),
        child: Text('Timetable Screen'),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
