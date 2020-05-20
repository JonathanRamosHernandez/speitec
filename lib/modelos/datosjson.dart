// To parse this JSON data, do
//
//     final datosjson = datosjsonFromJson(jsonString);
import 'dart:convert';

DatosJson datosJsonFromJson(String str) => DatosJson.fromJson(json.decode(str));

String datosJsonToJson(DatosJson data) => json.encode(data.toJson());

class DatosJson {
  List<Alumno> datos;

  DatosJson({
    this.datos,
  });

  factory DatosJson.fromJson(Map<String, dynamic> json) => DatosJson(
    datos: List<Alumno>.from(json["Datos"].map((x) => Alumno.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Datos": List<dynamic>.from(datos.map((x) => x.toJson())),
  };
}

class Alumno {
  String nombreAlumno;
  String apellidoP;
  String apellidoM;
  String numControl;

  Alumno({
    this.nombreAlumno,
    this.apellidoP,
    this.apellidoM,
    this.numControl,
  });

  factory Alumno.fromJson(Map<String, dynamic> json) => Alumno(
    nombreAlumno: json["nombre_alumno"],
    apellidoP: json["apellido_p"],
    apellidoM: json["apellido_m"],
    numControl: json["num_control"],
  );

  Map<String, dynamic> toJson() => {
    "nombre_alumno": nombreAlumno,
    "apellido_p": apellidoP,
    "apellido_m": apellidoM,
    "num_control": numControl,
  };
}
