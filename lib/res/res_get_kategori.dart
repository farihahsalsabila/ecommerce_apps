// To parse this JSON data, do
//
//     final restGetKategori = restGetKategoriFromJson(jsonString);

import 'dart:convert';

RestGetKategori restGetKategoriFromJson(String str) => RestGetKategori.fromJson(json.decode(str));

String restGetKategoriToJson(RestGetKategori data) => json.encode(data.toJson());

class RestGetKategori {
  RestGetKategori({
    this.message,
    this.status,
    this.data,
  });

  String? message;
  int? status;
  List<DataKategori>? data;

  factory RestGetKategori.fromJson(Map<String, dynamic> json) => RestGetKategori(
    message: json["message"] == null ? null : json["message"],
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : List<DataKategori>.from(json["data"].map((x) => DataKategori.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "status": status == null ? null : status,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DataKategori {
  DataKategori({
    this.kategoriId,
    this.kategoriNama,
    this.kategoriStatus,
    this.foto,
    this.createdAt,
    this.updatedAt,
  });

  int? kategoriId;
  String? kategoriNama;
  int? kategoriStatus;
  String? foto;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory DataKategori.fromJson(Map<String, dynamic> json) => DataKategori(
    kategoriId: json["kategori_id"] == null ? null : json["kategori_id"],
    kategoriNama: json["kategori_nama"] == null ? null : json["kategori_nama"],
    kategoriStatus: json["kategori_status"] == null ? null : json["kategori_status"],
    foto: json["foto"] == null ? null : json["foto"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "kategori_id": kategoriId == null ? null : kategoriId,
    "kategori_nama": kategoriNama == null ? null : kategoriNama,
    "kategori_status": kategoriStatus == null ? null : kategoriStatus,
    "foto": foto == null ? null : foto,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
  };
}
