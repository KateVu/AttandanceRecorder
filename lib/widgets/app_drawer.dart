import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:record_attendance/providers/auth.dart';
import '../data/img.dart';
import './my_text.dart';

class AppDrawer extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              AppBar(
                  brightness: Brightness.dark,
                  title: Text("Attendance recorder"),
                  actions: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () { Navigator.pop(context); },
                    ),
                  ]
              ),

              Container(
                height: 190,
                child: Stack(
                  children: <Widget>[
                    Image.asset(Img.get('material_bg_1.png'),
                      width: double.infinity, height: double.infinity, fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 14),
                      child: CircleAvatar(
                        radius: 36,
                        backgroundColor: Colors.grey[100],
                        child: CircleAvatar(
                          radius: 33,
                          backgroundImage: AssetImage(Img.get("photo_female_1.jpg")),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Student Name", style: MyText.body2(context).copyWith(
                                color: Colors.grey[100], fontWeight: FontWeight.bold
                            )),
                            Container(height: 5),
                            Text("Student Email", style: MyText.body2(context).copyWith(
                                color: Colors.grey[100]
                            ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Text("Classes", style: MyText.subhead(context).copyWith(
                    color: Colors.black, fontWeight: FontWeight.w500
                )),
                leading: Icon(Icons.home, size: 25.0, color: Colors.grey) ,
                onTap: (){},
              ),
              ListTile(
                title: Text("Student Timetable", style: MyText.subhead(context).copyWith(
                    color: Colors.black, fontWeight: FontWeight.w500
                )),
                leading: Icon(Icons.calendar_today, size: 25.0, color: Colors.grey) ,
                onTap: (){},
              ),

              Divider(),
              ListTile(
                leading: Icon(Icons.exit_to_app, size: 25.0, color: Colors.grey),
                title: Text('Logout',style: MyText.subhead(context).copyWith(
                    color: Colors.black, fontWeight: FontWeight.w500)
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacementNamed('/');
                  Provider.of<Auth>(context, listen: false).logout();
                },

              )
            ],
          ),
        ),
      );
  }
}

