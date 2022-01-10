// To parse this JSON data, do
//
//     final restUpdateProfile = restUpdateProfileFromJson(jsonString);

import 'dart:convert';

RestUpdateProfile restUpdateProfileFromJson(String str) => RestUpdateProfile.fromJson(json.decode(str));

String restUpdateProfileToJson(RestUpdateProfile data) => json.encode(data.toJson());

class RestUpdateProfile {
  RestUpdateProfile({
    this.message,
    this.status,
    this.data,
  });

  String? message;
  int? status;
  String? data;

  factory RestUpdateProfile.fromJson(Map<String, dynamic> json) => RestUpdateProfile(
    message: json["message"] == null ? null : json["message"],
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : json["data"],
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "status": status == null ? null : status,
    "data": data == null ? null : data,
  };
}
