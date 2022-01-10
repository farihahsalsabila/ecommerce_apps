// To parse this JSON data, do
//
//     final restInsertKeranjang = restInsertKeranjangFromJson(jsonString);

import 'dart:convert';

RestInsertKeranjang restInsertKeranjangFromJson(String str) => RestInsertKeranjang.fromJson(json.decode(str));

String restInsertKeranjangToJson(RestInsertKeranjang data) => json.encode(data.toJson());

class RestInsertKeranjang {
  RestInsertKeranjang({
    this.status,
    this.message,
  });

  int? status;
  String? message;

  factory RestInsertKeranjang.fromJson(Map<String, dynamic> json) => RestInsertKeranjang(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
  };
}
