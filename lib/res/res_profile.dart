// To parse this JSON data, do
//
//     final restGetProfile = restGetProfileFromJson(jsonString);

import 'dart:convert';

RestGetProfile restGetProfileFromJson(String str) => RestGetProfile.fromJson(json.decode(str));

String restGetProfileToJson(RestGetProfile data) => json.encode(data.toJson());

class RestGetProfile {
  RestGetProfile({
    this.message,
    this.status,
    this.profile,
  });

  String? message;
  int? status;
  List<Profile>? profile;

  factory RestGetProfile.fromJson(Map<String, dynamic> json) => RestGetProfile(
    message: json["message"] == null ? null : json["message"],
    status: json["status"] == null ? null : json["status"],
    profile: json["profile"] == null ? null : List<Profile>.from(json["profile"].map((x) => Profile.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "status": status == null ? null : status,
    "profile": profile == null ? null : List<dynamic>.from(profile!.map((x) => x.toJson())),
  };
}

class Profile {
  Profile({
    this.userId,
    this.userNama,
    this.userEmail,
    this.userPassword,
    this.userHp,
    this.userStatus,
    this.userLevel,
    this.userToken,
    this.userTanggal,
    this.userImage,
  });

  int? userId;
  String? userNama;
  String? userEmail;
  String? userPassword;
  dynamic? userHp;
  int? userStatus;
  int? userLevel;
  dynamic? userToken;
  DateTime? userTanggal;
  String? userImage;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    userId: json["user_id"] == null ? null : json["user_id"],
    userNama: json["user_nama"] == null ? null : json["user_nama"],
    userEmail: json["user_email"] == null ? null : json["user_email"],
    userPassword: json["user_password"] == null ? null : json["user_password"],
    userHp: json["user_hp"],
    userStatus: json["user_status"] == null ? null : json["user_status"],
    userLevel: json["user_level"] == null ? null : json["user_level"],
    userToken: json["user_token"],
    userTanggal: json["user_tanggal"] == null ? null : DateTime.parse(json["user_tanggal"]),
    userImage: json["user_image"] == null ? null : json["user_image"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId == null ? null : userId,
    "user_nama": userNama == null ? null : userNama,
    "user_email": userEmail == null ? null : userEmail,
    "user_password": userPassword == null ? null : userPassword,
    "user_hp": userHp,
    "user_status": userStatus == null ? null : userStatus,
    "user_level": userLevel == null ? null : userLevel,
    "user_token": userToken,
    "user_tanggal": userTanggal == null ? null : userTanggal!.toIso8601String(),
    "user_image": userImage == null ? null : userImage,
  };
}
