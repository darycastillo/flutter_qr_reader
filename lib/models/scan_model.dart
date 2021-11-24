import 'dart:convert';

SanModel sanModelFromJson(String str) => SanModel.fromJson(json.decode(str));

String sanModelToJson(SanModel data) => json.encode(data.toJson());

class SanModel {
  SanModel({
    this.id,
    required this.tipo,
    required this.valor,
  }) {
    tipo = tipo.contains('http') ? 'http' : 'Geo';
  }

  int? id;
  String tipo;
  String valor;

  factory SanModel.fromJson(Map<String, dynamic> json) => SanModel(
        id: json["id"],
        tipo: json["tipo"],
        valor: json["valor"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "valor": valor,
      };
}
