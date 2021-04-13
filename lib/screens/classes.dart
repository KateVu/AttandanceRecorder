import 'package:flutter/material.dart';
import 'package:record_attendance/widgets/app_drawer.dart';

class ClassesScreen extends StatelessWidget {
  static const routeName = '/classes';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: Text('List of classes'),
        ),

    );
  }
}
