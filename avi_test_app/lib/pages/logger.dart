import 'dart:async';
import 'dart:convert';
import 'package:avi_test_app/pages/image_picker.dart';
import 'package:avi_test_app/pages/resetpassword.dart';
import 'package:flutter/foundation.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'image_picker.dart';
import 'package:avi_test_app/database/database.dart';
import 'package:avi_test_app/database/user.dart';

String username;
String userid;
String branchid;
String branchname;
String isReset;
String password;
var db = new DatabaseHelper();

class Logger extends StatefulWidget {
  @override
  _LoggerState createState() => _LoggerState();
}

class _LoggerState extends State<Logger> {
  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();

  String uname = '';
  String msg = '';

  Future<Map<String, dynamic>> _login() async {
    final loginrequest = http.MultipartRequest(
        //'POST', Uri.parse("http://54.81.132.149/flutterdemoapi_x/login.php"));
        'POST', Uri.parse("http://192.168.8.195/flutterdemoapi/login.php"));

    loginrequest.fields['username'] = user.text.toString();
    loginrequest.fields['password'] = pass.text.toString();
    password = pass.text.toString();
    print(pass.text);

    try {
      final streamedResponse = await loginrequest.send();

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

  void _logstart() async {
    await db.deleteUser();

    final Map<String, dynamic> datauser = await _login();

    if (datauser == null) {
      Toast.show("Login details upload Failed!!!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      msg = 'Login details upload Failed!!!';
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
        title: "Login Error",
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
      branchid = (datauser['branchID']);
      branchname = (datauser['branchname']);
      userid = (datauser['userID']);
      username = (datauser['username']);
      isReset = (datauser['isReset']);
      print(branchname);

      var user = new User(username, userid, branchid);
      await db.saveUser(user);

      msg = datauser['response'];
      
      Toast.show(datauser['response'], context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

      print(isReset);
      if (isReset == '0') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Resetpass(
                  userid: userid,
                  username: username,
                  branchid: branchid,
                  branchname: branchname,
                  password: password)),
        );
      }
      if (isReset == '1') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ImageInput(
                    userid: userid,
                    username: username,
                    branchid: branchid,
                    branchname: branchname,
                  )),
        );
      }
    }
    setState(() {
      uname = datauser['username'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("A V I Login"),
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
      body:Container(
        decoration: BoxDecoration(
          color: Colors.yellow[50],
        ),
          child:Center(
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 155.0,
            child: Image.asset(
              'assets/padlock1.png',
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
          )
            ),
            margin: const EdgeInsets.all(15.0),

            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 5.0),
              ),
              new ListTile(
                leading: const Icon(
                  Icons.person,
                  color: Colors.teal,
                ),
                title: new TextField(
                  controller: user,
                  decoration: InputDecoration(hintText: 'Username'),
                  cursorColor: Colors.teal[700],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 5.0),
              ),
              new ListTile(
                leading: const Icon(
                  Icons.lock,
                  color: Colors.teal,
                ),
                title: new TextField(
                  controller: pass,
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'Password'),
                  cursorColor: Colors.teal[700],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 5.0),
              ),
              RaisedButton(
                child: Text("Login"),
                color: Colors.teal[600],
                hoverColor: Colors.teal[800],
                onPressed: () {
                  _logstart();
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
              ),
            ],
          ),
        ),
      )
              ]
      ),
          ),
      ),
    ), onWillPop: () => Future.value(false));
   
  }
}
