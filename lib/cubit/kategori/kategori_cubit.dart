import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:training_magang/repository/repo_kategori.dart';
import 'package:training_magang/res/res_get_kategori.dart';

part 'kategori_state.dart';

class KategoriCubit extends Cubit<KategoriState> {
  KategoriCubit() : super(KategoriInitial());

  RepoKategori repo = RepoKategori();
  RestGetKategori? restGetKategori;

  Future<void> getDataKategori() async {
    try{
      emit(KategoriLoading());
      RestGetKategori? res = await repo.getKategori();
      if(res != null) {
        restGetKategori = res;
        emit(KategoriSuccess(restGetKategori));
      } else {
        log('${res?.message}');
        emit(KategoriError(res?.message));
      }
    } catch (e) {
      log('${e.toString()}');
      emit(KategoriError(e.toString()));
    }
  }
}
