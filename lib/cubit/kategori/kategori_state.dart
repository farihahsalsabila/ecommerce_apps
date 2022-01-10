part of 'kategori_cubit.dart';

@immutable
abstract class KategoriState {}

class KategoriInitial extends KategoriState {}

class KategoriLoading extends KategoriState{}

class KategoriSuccess extends KategoriState{
  final RestGetKategori? restGetKategori;
  KategoriSuccess(this.restGetKategori);
}

class KategoriError extends KategoriState{
  final String? message;
  KategoriError(this.message);
}