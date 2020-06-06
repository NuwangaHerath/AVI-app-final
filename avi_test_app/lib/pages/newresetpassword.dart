import 'dart:async';
import 'dart:convert';
import 'package:avi_test_app/pages/image_picker.dart';
import 'package:avi_test_app/pages/logger.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'image_picker.dart';
import 'package:avi_test_app/database/database.dart';
import 'package:avi_test_app/database/user.dart';

var db = new DatabaseHelper();

class NewResetpass extends StatefulWidget {
  final String userid;
  NewResetpass({
    Key key,
    this.userid,
  }) : super(key: key);
  @override
  _ResetpassState createState() => _ResetpassState();
}

class _ResetpassState extends State<NewResetpass> {
  TextEditingController pass1 = new TextEditingController();
  TextEditingController pass2 = new TextEditingController();
  TextEditingController username = new TextEditingController();
  TextEditingController cpass = new TextEditingController();

  String msg = '';

  Future<Map<String, dynamic>> _reset() async {
    final resetrequest = http.MultipartRequest('POST',
        Uri.parse("http://54.81.132.149/flutterdemoapi_x/newreset.php"));

    resetrequest.fields['password1'] = pass1.text.toString();
    resetrequest.fields['password2'] = pass2.text.toString();
    resetrequest.fields['username'] = username.text.toString();
    resetrequest.fields['password'] = cpass.text.toString();

    try {
      final streamedResponse = await resetrequest.send();

      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode != 200) {
        return null;
      }

      final Map<String, dynamic> responseData = json.decode(response.body);

      return responseData;
    } catch (e) {
      return null;
    }
  }

  void _resetstart() async {
    final Map<String, dynamic> datauser = await _reset();

    if (datauser == null) {
      Toast.show("Reset details upload Failed!!!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      msg = 'Reset details upload Failed!!!';
      Alert(
        context: context,
        type: AlertType.warning,
        title: "Connection Error",
        desc: msg,
        buttons: [
          DialogButton(
            color: Colors.teal[500],
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    } else if (datauser.containsKey("error")) {
      Toast.show(datauser['error'], context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      msg = datauser['error'];
      Alert(
        context: context,
        type: AlertType.error,
        title: "Reset Error",
        desc: msg,
        buttons: [
          DialogButton(
            color: Colors.teal[500],
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    } else {
      msg = datauser['response'];
      Toast.show(datauser['response'], context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Logger()),
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Reset Password"),
          backgroundColor: Colors.teal[700],
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.time_to_leave,
                color: Colors.white,
              ),
              onPressed: () {
                // do something
              },
            )
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
              color: Colors.yellow[50],
            ),
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                  SizedBox(
                    height: 155.0,
                    child: Image.asset(
                      'assets/password.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.teal[50],
                        borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(20.0),
                          bottomLeft: const Radius.circular(20.0),
                          bottomRight: const Radius.circular(20.0),
                          topRight: const Radius.circular(20.0),
                        )),
                    margin: const EdgeInsets.all(15.0),
                    padding: EdgeInsets.all(15.0),
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          new ListTile(
                            leading: const Icon(
                              Icons.person,
                              color: Colors.black,
                            ),
                            title: new TextField(
                              controller: username,
                              obscureText: false,
                              decoration: InputDecoration(hintText: 'Username'),
                              cursorColor: Colors.teal,
                            ),
                          ),
                          new ListTile(
                            leading: const Icon(
                              Icons.enhanced_encryption,
                              color: Colors.black,
                            ),
                            title: new TextField(
                              controller: cpass,
                              obscureText: true,
                              decoration:
                                  InputDecoration(hintText: 'Current Password'),
                              cursorColor: Colors.teal,
                            ),
                          ),
                          new ListTile(
                            leading: const Icon(
                              Icons.enhanced_encryption,
                              color: Colors.black,
                            ),
                            title: new TextField(
                              controller: pass1,
                              obscureText: true,
                              decoration:
                                  InputDecoration(hintText: 'New Password'),
                              cursorColor: Colors.teal,
                            ),
                          ),
                          new ListTile(
                            leading: const Icon(
                              Icons.enhanced_encryption,
                              color: Colors.black,
                            ),
                            title: new TextField(
                              controller: pass2,
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: 'Re-enter Password'),
                              cursorColor: Colors.teal,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 5.0),
                          ),
                          RaisedButton(
                            child: Text("Reset"),
                            color: Colors.teal[600],
                            hoverColor: Colors.teal[800],
                            onPressed: () {
                              _resetstart();
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 5.0),
                          ),
                          //Text(
                          //msg,
                          //style: TextStyle(fontSize: 20.0, color: Colors.red),
                          //)
                        ],
                      ),
                    ),
                  ),
                ]))));
  }
}
