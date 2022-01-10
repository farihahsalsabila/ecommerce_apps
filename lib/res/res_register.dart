// To parse this JSON data, do
//
//     final restRegister = restRegisterFromJson(jsonString);

import 'dart:convert';

RestRegister restRegisterFromJson(String str) => RestRegister.fromJson(json.decode(str));

String restRegisterToJson(RestRegister data) => json.encode(data.toJson());

class RestRegister {
  RestRegister({
    this.message,
    this.status,
  });

  String? message;
  int? status;

  factory RestRegister.fromJson(Map<String, dynamic> json) => RestRegister(
    message: json["message"] == null ? null : json["message"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "status": status == null ? null : status,
  };
}
