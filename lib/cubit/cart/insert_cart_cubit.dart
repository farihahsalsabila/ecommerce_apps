import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:training_magang/repository/repo_kategori.dart';
import 'package:training_magang/res/res_insert_keranjang.dart';

part 'insert_cart_state.dart';

class InsertCartCubit extends Cubit<InsertCartState> {
  InsertCartCubit() : super(InsertCartInitial());

  RepoKategori repo = RepoKategori();
  RestInsertKeranjang? restInsertKeranjang;

  Future<void> addItemKeranjang(BuildContext context, String? cartIdOrder,
      String? cartIdProduk, int? cartQty, int? cartHarga) async {
    try {
      emit(InsertCartLoading());
      RestInsertKeranjang? res = await repo.addKeranjang(
          cartIdOrder, cartIdProduk, cartQty, cartHarga);
      if (res != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${res.message}')));
        emit(InsertCartSuccess(restInsertKeranjang));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${res?.message}')));
        emit(InsertCartError(res?.message));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${e.toString()}')));
      emit(InsertCartError(e.toString()));
    }
  }
}
