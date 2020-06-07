import 'package:avi_test_app/database/database.dart';
import 'package:avi_test_app/pages/homenav.dart';
import 'package:avi_test_app/pages/image_picker.dart';
import 'package:avi_test_app/pages/newresetpassword.dart';
import 'package:avi_test_app/pages/resetpassword.dart';

import './pages/splashScreen.dart';
import 'package:flutter/material.dart';

import 'pages/logger.dart';
import 'widgets/drawer.dart';



void main() => runApp(MyApp());


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
     
    WidgetsFlutterBinding.ensureInitialized();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue
      ),
     
      home: new SplashScreen(),
    
    routes: <String, WidgetBuilder>{
      '/imagePicker': (BuildContext context) => new Logger()
    },
   
   
    );
  }
}