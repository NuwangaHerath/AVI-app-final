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

class Resetpass extends StatefulWidget {
  final String userid;
  final String username;
  final String branchid;
  final String password;
  Resetpass({
    Key key,
    this.userid,
    this.username,
    this.branchid,
    this.password,
  }) : super(key: key);
  @override
  _ResetpassState createState() => _ResetpassState();
}

class _ResetpassState extends State<Resetpass> {
  TextEditingController pass1 = new TextEditingController();
  TextEditingController pass2 = new TextEditingController();

  String msg = '';

  Future<Map<String, dynamic>> _reset() async {
    final resetrequest = http.MultipartRequest(
        'POST', Uri.parse("http://54.198.249.172/flutterdemoapi_x/reset.php"));

    resetrequest.fields['password1'] = pass1.text.toString();
    resetrequest.fields['password2'] = pass2.text.toString();
    resetrequest.fields['userid'] = userid.toString();
    resetrequest.fields['password'] = password.toString();

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
            color: Colors.lightGreen[500],
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
            color: Colors.lightGreen[500],
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
      print(datauser['response']);
      msg = datauser['response'];
      Toast.show(datauser['response'], context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      Alert(
        context: context,
        type: AlertType.success,
        title: "Reset Succesfull",
        desc: msg,
        buttons: [
          DialogButton(
            color: Colors.lightGreen[500],
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ImageInput(
                  userid: userid,
                  username: username,
                  branchid: branchid,
                )),
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("         Reset Password"),
        backgroundColor: Colors.lightGreen[800],
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
        child: Center(
          child: Column(
            children: <Widget>[
              new ListTile(
                leading: const Icon(
                  Icons.enhanced_encryption,
                  color: Colors.black,
                ),
                title: new TextField(
                  controller: pass1,
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'New Password'),
                  cursorColor: Colors.deepOrange,
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
                  decoration: InputDecoration(hintText: 'Re-enter Password'),
                  cursorColor: Colors.deepOrange,
                ),
              ),
              RaisedButton(
                child: Text("Reset"),
                color: Colors.lightGreen[500],
                hoverColor: Colors.lightGreen[800],
                onPressed: () {
                  _resetstart();
                },
              ),
              //Text(
               // msg,
                //style: TextStyle(fontSize: 20.0, color: Colors.red),
              //)
            ],
          ),
        ),
      ),
    );
  }
}

