import 'dart:ui';

import 'package:avi_test_app/pages/instruction.dart';
import 'package:avi_test_app/pages/newresetpassword.dart';
import 'package:flutter/material.dart';
import 'package:avi_test_app/pages/history_page.dart';
import 'package:avi_test_app/pages/logger.dart';

class DrawerUI extends StatelessWidget {
  final String username;
  final String userid;
  final String branchid;

  const DrawerUI({Key key, this.username, this.userid, this.branchid}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          new Container(color: Colors.lightGreen[800],),
          UserAccountsDrawerHeader(
             decoration: BoxDecoration(
        color: Colors.lightGreen[800],
    ),
            accountName: Text(username),
            accountEmail: Text('Userid: '+userid+'  Branchid: '+branchid),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
        child: Image.asset(
          'assets/avi.JPG',
        ),
    ),
              backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
                  ? Colors.orange[700]
                  : Colors.white,
              
              //backgroundImage: Image.asset('assets/avi.JPG'),
              //child:
              //Text(
               // "U",
               // style: TextStyle(fontSize: 40.0, color: Colors.orange[900]),
                
             // ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
          ),
          ListTile(
            title: Text("Login"),
            trailing: Icon(Icons.supervised_user_circle),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Logger()),
              );
            },
          ),
          ListTile(
            title: Text("Recent History"),
            trailing: Icon(Icons.history),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HistoryPage()),
              );
            },
          ),
          ListTile(
            title: Text("Instructions"),
            trailing: Icon(Icons.info),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Instructions()),
              );
            },
          ),
          ListTile(
            title: Text("Reset Password"),
            trailing: Icon(Icons.lock),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewResetpass()),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
          ),
          ListTile(
            title: Text("Settings"),
            trailing: Icon(Icons.settings),
          ),
          ListTile(
            title: Text("Share"),
            trailing: Icon(Icons.share),
          ),
        ],
      ),
    );
  }
}
