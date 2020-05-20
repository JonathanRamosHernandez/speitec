// To parse this JSON data, do
//
//     final aprobadoJson = aprobadoJsonFromJson(jsonString);

import 'dart:convert';

AprobadoJson aprobadoJsonFromJson(String str) => AprobadoJson.fromJson(json.decode(str));

String aprobadoJsonToJson(AprobadoJson data) => json.encode(data.toJson());

class AprobadoJson {
  List<Dato> datos;

  AprobadoJson({
    this.datos,
  });

  factory AprobadoJson.fromJson(Map<String, dynamic> json) => AprobadoJson(
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
  dynamic fechaLiberacion;
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
    fechaLiberacion: json["fecha_liberacion"],
    docSol: json["doc_sol"],
  );

  Map<String, dynamic> toJson() => {
    "folio_doc": folioDoc,
    "status": status,
    "fecha": "${fecha.year.toString().padLeft(4, '0')}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')}",
    "fecha_liberacion": fechaLiberacion,
    "doc_sol": docSol,
  };
}
