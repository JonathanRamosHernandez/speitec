import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:speitec/modelos/espera_Json.dart';

class pendientes extends StatelessWidget {
  static String routeName = "/pendientes";

  const pendientes({Key key}) : super(key: key);

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

Future<EsperaJson> getUsuarios() async {
  final resp =
      await http.get("http://192.168.0.6/example/ProyectoFinal/esperajson.php");
  return esperaJsonFromJson(resp.body);
}

class MiPagina extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pendiente'),
      ),
      body: FutureBuilder(
        future: getUsuarios(),
        builder: (BuildContext context, AsyncSnapshot<EsperaJson> snapshot) {
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
