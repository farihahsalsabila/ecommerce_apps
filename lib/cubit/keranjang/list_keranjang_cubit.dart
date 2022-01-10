import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:training_magang/repository/repo_kategori.dart';
import 'package:training_magang/res/res_get_keranjang.dart';

part 'list_keranjang_state.dart';

class ListKeranjangCubit extends Cubit<ListKeranjangState> {
  ListKeranjangCubit() : super(ListKeranjangInitial());

  RepoKategori repo = RepoKategori();
  RestGetKeranjang? restGetKeranjang;

  Future<void> getDataKeranjang(BuildContext context) async {
    try {
      emit(ListKeranjangLoding());
      RestGetKeranjang? res = await repo.listKeranjang();
      if(res != null){
        restGetKeranjang = res;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${res.message}'),));
        emit(ListKeranjangSuccess(restGetKeranjang));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${res?.message}'),));
        emit(ListKeranjangError(res?.message));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${e.toString()}'),));
      emit(ListKeranjangError(e.toString()));
    }
  }
}
