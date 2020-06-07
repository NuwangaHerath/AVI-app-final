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
          new Container(color: Colors.teal[300],),
          UserAccountsDrawerHeader(
             decoration: BoxDecoration(
        color: Colors.teal[500],
    ),
            accountName: Text(username),
            accountEmail: Text('Userid: '+userid+'  Branchid: '+branchid),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
        child: Image.asset(
          'assets/avatar.png',
        ),
    ),
              backgroundColor: Theme.of(context).platform == TargetPlatform.android
                  ? Colors.teal[500]
                  : Colors.white,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
          ),
          ListTile(
            title: Text("Login"),
            trailing: Icon(Icons.supervised_user_circle,
            color: Colors.teal,),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Logger()),
              );
            },
          ),
          ListTile(
            title: Text("Recent History"),
            trailing: Icon(Icons.history,
            color: Colors.teal,),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HistoryPage()),
              );
            },
          ),
          ListTile(
            title: Text("Instructions"),
            trailing: Icon(Icons.info,
              color: Colors.teal,),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Instructions()),
              );
            },
          ),
          ListTile(
            title: Text("Reset Password"),
            trailing: Icon(Icons.lock,
              color: Colors.teal,),
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
            trailing: Icon(Icons.settings,
              color: Colors.teal,),
          ),
          ListTile(
            title: Text("Share"),
            trailing: Icon(Icons.share,
              color: Colors.teal,),
          ),
        ],
      ),
    );
  }
}
