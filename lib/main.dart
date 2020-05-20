import 'package:flutter/material.dart';
import 'package:speitec/aprobadas.dart';
import 'home.dart';
import 'solicitud.dart';
import 'main1.dart';
import 'pendientes.dart';
import 'liberadas.dart';

void main() {
  // Instancia de la clase para la manipulación de datos

  // Inserto datos ficticios a la base de datos SQLite

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static String routeName = "/MyApp";

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Drawer Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Home(),
        routes: <String, WidgetBuilder>{
          MyApp.routeName: (BuildContext context) => MyApp(),
          Solicitudes.routeName: (BuildContext context) => solicitud(),
          pendientes.routeName: (BuildContext context) => pendientes(),
          aprobadas.routeName: (BuildContext context) => aprobadas(),
          liberadas.routeName: (BuildContext context) => liberadas(),
          //'/': (BuildContext context) => Home(),
        });
  }
}
