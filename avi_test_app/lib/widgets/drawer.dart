import 'dart:ui';

import 'package:avi_test_app/pages/instruction.dart';
import 'package:avi_test_app/pages/newresetpassword.dart';
import 'package:flutter/material.dart';
import 'package:avi_test_app/pages/history_page.dart';
import 'package:avi_test_app/pages/logger.dart';
import 'package:flutter/services.dart';

class DrawerUI extends StatelessWidget {
  final String username;
  final String userid;
  final String branchname;

  const DrawerUI({Key key, this.username, this.userid, this.branchname})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          new Container(
            color: Colors.teal[300],
          ),
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.teal[500],
            ),
            accountName: Text('User     : '+username),
            accountEmail: Text('Branch : ' + branchname),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'assets/logo1.png',
                ),
              ),
              backgroundColor:
                  Theme.of(context).platform == TargetPlatform.android
                      ? Colors.teal[500]
                      : Colors.white,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
          ),
          ListTile(
            title: Text("Recent History"),
            trailing: Icon(
              Icons.history,
              color: Colors.teal,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HistoryPage()),
              );
            },
          ),
          ListTile(
            title: Text("Instructions"),
            trailing: Icon(
              Icons.info,
              color: Colors.teal,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Instructions()),
              );
            },
          ),
          ListTile(
            title: Text("Reset Password"),
            trailing: Icon(
              Icons.lock,
              color: Colors.teal,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewResetpass(userid: userid)),
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
            trailing: Icon(
              Icons.settings,
              color: Colors.teal,
            ),
          ),
          ListTile(
            title: Text("Share"),
            trailing: Icon(
              Icons.share,
              color: Colors.teal,
            ),
          ),
          ListTile(
            title: Text("Logout"),
            trailing: Icon(
              Icons.exit_to_app,
              color: Colors.teal,
            ),
            onTap: () {
              _exitApp(context);
            },
          ),
        ],
      ),
    );
  }
}

Future<bool> _exitApp(BuildContext context) {
  return showDialog(
        context: context,
        child: AlertDialog(
          title: Text('Do you want to logout?'),
          //content: Text('We hate to see you leave...'),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                print("you choose no");
                Navigator.of(context).pop(false);
              },
              child: Text('No', style: TextStyle(color: Colors.white),),
              color: Colors.redAccent,
            ),
            FlatButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Logger()),
                );
              },
              child: Text('Yes', style: TextStyle(color: Colors.white),),
              color: Colors.teal[700],
            ),
          ],
        ),
      ) ??
      false;
}
