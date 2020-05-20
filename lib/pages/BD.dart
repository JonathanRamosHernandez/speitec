import 'package:sqflite/sqflite.dart';
import 'package:speitec/pages/tablas.dart';
import 'package:speitec/pages/creacionbd.dart';
class ManipulacionBD {

  final dbProvider = creacionbd.dbProvider;

  void cargarDatos() async {
    //Esta sección debe ser sustituida por un formulario. Practiquen creando uno propio con ayuda de los tutoriales de Flutter, checa
    // https://flutter.dev/docs/cookbook/forms/validation
    var vuelo1 = usuarios(
        usuario: 'Phantom 4 pro',
        contrasena: 'Vuelo sin contratiempos de BD');

    //Inserta registros a la tabla
    await insertVuelo(vuelo1);

    //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  }

  Future<void> insertVuelo(usuarios vuelo) async {
    final db = await dbProvider.database;
    // Inserta un vueo en la tabla correspondiente. También prevee
    // la repetición de registros `conflictAlgorithm`, reemplazandolos
    await db.insert(
      'usuarios',
      vuelo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<usuarios>> getVuelos() async {
    final db = await dbProvider.database;
    // Se recuperan todos los registros de la tabla.
    final List<Map<String, dynamic>> maps = await db.query('vuelos');

    // Convierte  List<Map<String, dynamic>  a List<Dog>.
    return List.generate(maps.length, (i) {
      return usuarios(
        usuario: maps[i]['usuario'],
        contrasena: maps[i]['contrasena'],

      );
    });
  }




}