import 'package:apptest/model/user.model.dart';
import 'package:apptest/service/UserService.dart';
import 'package:apptest/states/user.state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './register.page.dart';
// import 'package:testrawbank/main_app.dart';
import './main_app.dart';
import './register.page.dart';
import './register/welcome.page.dart';

Future<void> main() async {
  runApp(MyApp());
} 

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool isBackGroundNotification = false;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  @override
  void initState() {
      isBackGroundNotification = false;
      _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        setState(() {
          isBackGroundNotification = true;
        });
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        setState(() {
          isBackGroundNotification = true;
        });
      },
    );
    _firebaseMessaging.subscribeToTopic("news");
    super.initState();
  }
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<SharedPreferences>(
        future: widget._prefs,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: Container(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(),
            ));
          }
          UserState.intance.currentUser = new UserModel(pseudo: snapshot.data.getString("pseudo"));
          if (UserState.intance.currentUser.pseudo == null) {
            print("ooops");
            return RegisterPage();
          }
          return MainApp();
        }
      ),
    );
  }
}
