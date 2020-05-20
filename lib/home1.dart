import 'package:flutter/material.dart';
import 'package:speitec/solicitud.dart';
import 'pendientes.dart';
import 'liberadas.dart';
import 'aprobadas.dart';

void main() => runApp(Home());

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  int index = 0;
  List<Widget> list = [
    Solicitudes(),
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('ssa'),
      ),
      body: list[index],
      drawer: MyDrawer(onTap: (context, index) {
        setState(() {
          Navigator.pop(context);
        });
      }),
    );
  }
}

class MyDrawer extends StatelessWidget {
  final Function onTap;

  MyDrawer({this.onTap});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      drawer: Drawer(
        // Agrega un ListView al drawer. Esto asegura que el usuario pueda desplazarse
        // a través de las opciones en el Drawer si no hay suficiente espacio vertical
        // para adaptarse a todo.
        child: ListView(
          // Importante: elimina cualquier padding del ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Speitec'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: Icon(Icons.create),
              title: Text('Solicitud'),
              onTap: () => onTap(context, 0),
            ),
            ListTile(
              title: Text('Estatus'),
              leading: Icon(Icons.schedule),
              onTap: () {
                // // Actualiza el estado de la aplicación
                // ...
                // Luego cierra el drawer
              },
            ),
          ],
        ),
      ),
    );
  }
}
