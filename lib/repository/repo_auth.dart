import 'dart:convert';
import 'dart:developer';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:training_magang/data_global.dart';
import 'package:training_magang/network/api.dart';
import 'package:training_magang/res/res_login.dart';
import 'package:training_magang/res/res_profile.dart';
import 'package:training_magang/res/res_register.dart';
import 'package:training_magang/res/res_update_profile.dart';

class RepoAuth {
  Future<RestRegister?> registerAccount(
      String? fullname, String? email, String? telp, String? password) async {
    Response res = await dio.post(apiRegister,
        data: FormData.fromMap({
          'nama': '$fullname',
          'email': '$email',
          'hp': '$telp',
          'password': '$password'
        }));
    return RestRegister.fromJson(jsonDecode(res.data));
  }

  Future<RestLogin?> loginAccount(String? email, String? password) async {
    Response res = await dio.post(apiLogin,
        data: FormData.fromMap({'email': '$email', 'password': '$password'}));
    return RestLogin.fromJson(jsonDecode(res.data));
  }

  Future<RestGetProfile?> profileAccount() async {
    Response res = await dio.post(apiProfile,
        data: FormData.fromMap({'iduser': '${dataGlobal.user?.userId}'}));
    return RestGetProfile.fromJson(jsonDecode(res.data));
  }

  Future<RestUpdateProfile?> updateProfile(
      String? nama, String? email, String? telp, XFile? image) async {
    try {
      Response res = await dio.post(apiUpdateProfile,
          data: FormData.fromMap({
            'idUser': '${dataGlobal.user?.userId}',
            'userNama': '$nama',
            'userEmail': '$email',
            'userTelp': '$telp',
            'image': await MultipartFile.fromFile(image!.path,
                filename: basename(image.path))
          }));
      return RestUpdateProfile.fromJson(jsonDecode(res.data));
    } catch (e) {
      log('${e.toString()}');
    }
  }
}
