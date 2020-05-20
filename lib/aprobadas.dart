import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:speitec/modelos/aprobadojson.dart';


class aprobadas extends StatelessWidget {
  static String routeName = "/Aprobadas";

  const aprobadas({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MaterialApp',
      home: MiPagina(),
    );
  }
}

Future<AprobadoJson> getUsuarios() async {
  final resp =
  await http.get("http://192.168.0.6/example/ProyectoFinal/aprobadoJson.php");
  return aprobadoJsonFromJson(resp.body);
}

class MiPagina extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aprobado'),
      ),
      body: FutureBuilder(
        future: getUsuarios(),
        builder: (BuildContext context, AsyncSnapshot<AprobadoJson> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return _ListaDatos(snapshot.data.datos);
          }
        },
      ),
    );
  }
}

class _ListaDatos extends StatelessWidget {
  final List<Dato> datos;

  _ListaDatos(this.datos);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: datos.length,
      itemBuilder: (BuildContext context, int i) {
        final dato = datos[i++];
        return Column(

          children: <Widget>[

            ListTile(
              leading: Text( '$i'),
              title: Text('Folio: ${dato.folioDoc} | Documento: ${dato.docSol} | Fecha: ${dato.fecha}  '),
              subtitle: Text('Status: ${dato.status} | Fecha Liberacion: ${dato.fechaLiberacion}'),
            ),
          ],
        );
      },
    );
  }
}