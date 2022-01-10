import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:training_magang/data_global.dart';
import 'package:training_magang/network/api.dart';
import 'package:training_magang/res/res_get_kategori.dart';
import 'package:training_magang/res/res_get_keranjang.dart';
import 'package:training_magang/res/res_get_produk.dart';
import 'package:training_magang/res/res_insert_keranjang.dart';

class RepoKategori {
  Future<RestGetKategori?> getKategori() async {
    try{
      Response res = await dio.get(apiKategori);
      return RestGetKategori.fromJson(jsonDecode(res.data));
    } catch (e) {
      log('${e.toString()}');
    }
  }

  Future<RestGetProduk?> getProduk() async {
    try {
      Response res = await dio.get(apiProduk);
      return RestGetProduk.fromJson(jsonDecode(res.data));
    } catch (e) {
      log('${e.toString()}');
    }
  }
  Future<RestInsertKeranjang?> addKeranjang(String? cartIdOrder, String? cartIdProduk, int? cartQty, int? cartHarga) async {
    Response res = await dio.post(apiKeranjang, data: FormData.fromMap({
      'idorder' : '$cartIdOrder',
      'idproduk' : '$cartIdProduk',
      'qty' : cartQty,
      'harga' : cartHarga,
      'iduser' : '${dataGlobal.user?.userId}'
    }));
    return RestInsertKeranjang.fromJson(jsonDecode(res.data));
  }
  Future<RestGetKeranjang?> listKeranjang() async {
    try {
      Response res = await dio.post(apiListKeranjang, data: FormData.fromMap({
        'iduser' : '${dataGlobal.user?.userId}'
      }));
      return RestGetKeranjang.fromJson(jsonDecode(res.data));
    } catch (e) {
      log('${e.toString()}');
    }
  }
}