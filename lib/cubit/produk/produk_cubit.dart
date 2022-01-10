import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:training_magang/repository/repo_kategori.dart';
import 'package:training_magang/res/res_get_produk.dart';

part 'produk_state.dart';

class ProdukCubit extends Cubit<ProdukState> {
  ProdukCubit() : super(ProdukInitial());

  RepoKategori repo = RepoKategori();
  RestGetProduk? restGetProduk;

  Future<void> getDataProduk() async {
    try {
      emit(ProdukLoading());
      RestGetProduk? res = await repo.getProduk();
      if(res != null) {
        restGetProduk = res;
        emit(ProdukSuccess(restGetProduk));
      } else {
        log('${res?.message}');
        emit(ProdukError(res?.message));
      }
    } catch (e) {
      log('${e.toString()}');
      emit(ProdukError('${e.toString()}'));
    }
  }
}
