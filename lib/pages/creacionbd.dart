import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


//Esta clase fue creada con el propósito de definir la base de datos y su tabla

class creacionbd {
// Se requiere de un objeto que contenga la conexión una única vez,
// es por eso que se declara static
  static final creacionbd dbProvider = creacionbd();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await crearBD();
    return _database;
  }


  /*
  Conceptos de cláusulas que deben investigar
  Future:
  async:
  await:
  */

  crearBD() async {
    //Se recupera la ruta donde se enceuntra la base de datos
    //y se concatena el nombre de la misma para poder usarla
    String path = join(await getDatabasesPath(), "speitec.db");
    var bd;

    bd = await openDatabase(path,
        version: 1, onCreate: _initDB, onUpgrade: _onUpgrade);

    return bd;
  }

  //This is optional, and only used for changing DB schema migrations
  void _onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }
// Crea la tabla vuelos en la base de datos bitacora
  void _initDB(Database database, int version) async {
    await database.execute("CREATE TABLE usuarios ("
        "usuario TEXT, "
        "contrasena INT, "
        ")");
  }




}


