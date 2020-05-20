import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:speitec/pages/tablas.dart';
import 'home.dart';
import 'package:speitec/pages/powerpage.dart';
import 'package:http/http.dart' as http;
import 'package:speitec/modelos/datosjson.dart';
import 'package:speitec/login.dart';

//void main() => runApp(Solicitudes());

Future<DatosJson> Datos_Alum() async {
  final resp =
      await http.get('http://192.168.0.6/example/ProyectoFinal/AlumJson.php');
  return datosJsonFromJson(resp.body);
}

class Solicitudes extends StatelessWidget {
  static String routeName = "/Solicitudes";
  final String value;

  Solicitudes({Key key, this.value}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final String valor = ModalRoute.of(context).settings.arguments;
    print("valor en solicitud: $value");

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Speitec',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: solicitud(),
      //routes: <String, WidgetBuilder>{
      //'/Solicitudes': (BuildContext context) => new Solicitudes(),

      //},
    );
  }
}

class Solicitud {
  int id;
  String name;

  Solicitud(this.id, this.name);

  static List<Solicitud> getSolicitudes() {
    return <Solicitud>[
      Solicitud(1, 'Certificado de Estudios MXN 750.00'),
      Solicitud(2, 'Certificado de Estudios de Posgrado MXN 1000.00'),
      Solicitud(3, 'Certificado Parcial MXN 750.00'),
      Solicitud(4, 'Duplicado de Certificado MXN 750.00'),
      Solicitud(5, 'Constancia MXN 50.00'),
      Solicitud(4, 'Kardex  MXN 100.00'),
      Solicitud(5, 'Duplicado de Credencial  MXN 150.00'),
    ];
  }
}

class _ListaUsuarios extends StatelessWidget {
  final List<Alumno> alumno;
  String num_control;

  _ListaUsuarios(this.alumno);

  @override
  Widget build(BuildContext context) {
    final usuario = ModalRoute.of(context).settings.arguments;
    print(usuario.toString());
    return ListView.builder(
        itemCount: alumno.length,
        itemBuilder: (BuildContext context, int index) {
          final usuario = alumno[index];
          return Text(
              '      BIENVENIDO ${usuario.nombreAlumno} ${usuario.apellidoP} ${usuario.apellidoM}');
        });
  }
}

class solicitud extends StatefulWidget {
  _solicitud createState() => _solicitud();
}

class _solicitud extends State<solicitud> {
  List<Solicitud> _solicitudes = Solicitud.getSolicitudes();
  List<DropdownMenuItem<Solicitud>> _dropdownMenuItems;
  Solicitud _selectedSolicitud;

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_solicitudes);
    _selectedSolicitud = _dropdownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<Solicitud>> buildDropdownMenuItems(List solicitudes) {
    List<DropdownMenuItem<Solicitud>> items = List();
    for (Solicitud solicitud in solicitudes) {
      items.add(
        DropdownMenuItem(
          value: solicitud,
          child: Text(solicitud.name),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(Solicitud selectedSolicitud) {
    setState(() {
      _selectedSolicitud = selectedSolicitud;
    });
  }

  @override
  insertMethod() async {
    String theUrl="http://192.168.0.6/example/ProyectoFinal/recuperajson.php";
    var res= await http.post(Uri.encodeFull(theUrl),headers: {"Accept":"aplication/json"},
    body: {
      "tramite":_selectedSolicitud.id.toString()

        });
    var respBody=json.decode(res.body);
    print(respBody);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Solicitudes'),
      ),
      body: Container(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  height: 100.0,
                  child: FutureBuilder(
                    future: Datos_Alum(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DatosJson> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return _ListaUsuarios(snapshot.data.datos);
                      }
                    },
                  )),
              SizedBox(
                height: 180.0,
              ),
              Text(
                "Solicitudes",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.0,
              ),
              DropdownButton(
                underline: Container(
                  height: 2,
                  width: 2,
                  color: Colors.blue,
                ),
                iconSize: 24,
                elevation: 16,
                value: _selectedSolicitud,
                items: _dropdownMenuItems,
                icon: Icon(Icons.attach_money),
                onChanged: onChangeDropdownItem,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'A solicitar: ${_selectedSolicitud.name}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 110.0),
                child: RaisedButton(
                  onPressed: () {
                    insertMethod();
                  },
                  color: Colors.blueAccent,
                  splashColor: Colors.lightBlue,
                  child: Text(
                    'Solicitar',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
