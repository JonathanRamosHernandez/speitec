import 'package:flutter/material.dart';
import 'package:speitec/login.dart';
import 'package:splashscreen/splashscreen.dart';
import 'home.dart';
import 'liberadas.dart';
import 'pendientes.dart';

import 'aprobadas.dart';

void main() {
  runApp(new MaterialApp(
    home: new MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 5,
        navigateAfterSeconds: new Log(),
        image: new Image.asset("Assets/logo.png"),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 180.0,
        onClick: () => print("Flutter Egypt"),
        loaderColor: Colors.lightBlue);
  }
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SpeiTec',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Log(),
        routes: <String, WidgetBuilder>{
          aprobadas.routeName: (BuildContext context) => aprobadas(),
          liberadas.routeName: (BuildContext context) => liberadas(),
        });
  }
}
