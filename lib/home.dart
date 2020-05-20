import 'package:flutter/material.dart';

import 'solicitud.dart';
import 'pendientes.dart';
import 'liberadas.dart';
import 'aprobadas.dart';

class Home extends StatelessWidget {
  static BuildContext contexto;

  const Home({Key key}) : super(key: key);

  ListTile getListItem(Icon icono, String opcion, String route) {
    return ListTile(
      leading: icono,
      title: Text(opcion),
      onTap: () {
        Navigator.popAndPushNamed(contexto, route);
      },
    );
  }

  ListView getMenu(BuildContext context) {
    return ListView(
      children: <Widget>[
        DrawerHeader(child: Text("Bienvenido")),
        getListItem(Icon(Icons.create), "Solicitud", "/Solicitudes"),
        getListItem(Icon(Icons.check), "Aprobadas", "/Aprobadas"),
        getListItem(Icon(Icons.offline_pin), "Liberadas", "/liberadas"),
        getListItem(Icon(Icons.history), "Pendientes", "/pendientes"),
      ],
    );
  }

  @override
  // This widget is the root of your application.

  Widget build(BuildContext context) {
    contexto = context;

    return Scaffold(
      appBar: AppBar(
        title: Text("Pagina principal"),
      ),
      drawer: Drawer(
        child: getMenu(context),
      ),
      body: solicitud(),
    );
  }
}
