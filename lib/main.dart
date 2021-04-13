import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:record_attendance/providers/auth.dart';
import 'package:record_attendance/screens/auth_screen.dart';
import 'package:record_attendance/screens/bottom_navigation.dart';
import 'package:record_attendance/screens/classes.dart';
import 'package:record_attendance/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) =>
              MaterialApp(
                title: 'Attendance Recorder',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                ),
                home: auth.isAuth
                    ? BottomNavigationScreen()
                    : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                  authResultSnapshot.connectionState ==
                      ConnectionState.waiting
                      ? SplashScreen()
                      : AuthScreen(),
                ),
                routes: {
                  ClassesScreen.routeName: (context) => ClassesScreen(),
                },
              ),
        )
    );
  }
}
