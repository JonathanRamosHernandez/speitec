// To parse this JSON data, do
//
//     final liberarJson = liberarJsonFromJson(jsonString);

import 'dart:convert';

LiberarJson liberarJsonFromJson(String str) => LiberarJson.fromJson(json.decode(str));

String liberarJsonToJson(LiberarJson data) => json.encode(data.toJson());

class LiberarJson {
  List<Dato> datos;

  LiberarJson({
    this.datos,
  });

  factory LiberarJson.fromJson(Map<String, dynamic> json) => LiberarJson(
    datos: List<Dato>.from(json["datos"].map((x) => Dato.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "datos": List<dynamic>.from(datos.map((x) => x.toJson())),
  };
}

class Dato {
  String folioDoc;
  String status;
  DateTime fecha;
  DateTime fechaLiberacion;
  String docSol;

  Dato({
    this.folioDoc,
    this.status,
    this.fecha,
    this.fechaLiberacion,
    this.docSol,
  });

  factory Dato.fromJson(Map<String, dynamic> json) => Dato(
    folioDoc: json["folio_doc"],
    status: json["status"],
    fecha: DateTime.parse(json["fecha"]),
    fechaLiberacion: DateTime.parse(json["fecha_liberacion"]),
    docSol: json["doc_sol"],
  );

  Map<String, dynamic> toJson() => {
    "folio_doc": folioDoc,
    "status": status,
    "fecha": "${fecha.year.toString().padLeft(4, '0')}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')}",
    "fecha_liberacion": fechaLiberacion.toIso8601String(),
    "doc_sol": docSol,
  };
}
