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
String validate;

class NewResetpass extends StatefulWidget {
  final String userid;
  final String username;
  NewResetpass({
    Key key,
    this.userid,
    this.username,
  }) : super(key: key);
  @override
  _ResetpassState createState() => _ResetpassState();
}

class _ResetpassState extends State<NewResetpass> {
  TextEditingController pass1 = new TextEditingController();
  TextEditingController pass2 = new TextEditingController();
  //TextEditingController username = new TextEditingController();
  TextEditingController cpass = new TextEditingController();

  String msg = '';

  Future<Map<String, dynamic>> _reset() async {
    final resetrequest = http.MultipartRequest(
        'POST', Uri.parse("http://192.168.8.195/flutterdemoapi/newreset.php"));

    resetrequest.fields['password1'] = pass1.text.toString();
    resetrequest.fields['password2'] = pass2.text.toString();
    resetrequest.fields['username'] = username.toString();
    resetrequest.fields['password'] = cpass.text.toString();

    validate = validatePassword(pass1.text.toString());

    if (validate == null) {
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
    } else {
      return null;
    }
  }

  String validatePassword(String value) {
    Pattern pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$';
    RegExp regex = new RegExp(pattern);
    print(value);
    if (value.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter valid password';
      } else {
        return null;
      }
    }
  }

  void _resetstart() async {
    final Map<String, dynamic> datauser = await _reset();
    if (validate == null) {
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
    } else {
      Toast.show(validate, context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      msg = validate;
      Alert(
        context: context,
        type: AlertType.error,
        title: "Validation Error",
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
    }
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
                          Text(
                            "Password must contain at least 6 characters, including UPPER/lowercase, numbers and special characters.",
                            style: TextStyle(fontSize: 15.0, color: Colors.red),
                          )
                        ],
                      ),
                    ),
                  ),
                ]))));
  }
}
