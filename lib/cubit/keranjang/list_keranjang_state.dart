part of 'list_keranjang_cubit.dart';

@immutable
abstract class ListKeranjangState {}

class ListKeranjangInitial extends ListKeranjangState {}

class ListKeranjangLoding extends ListKeranjangState {}

class ListKeranjangSuccess extends ListKeranjangState {
  final RestGetKeranjang? restGetKeranjang;
  ListKeranjangSuccess(this.restGetKeranjang);
}

class ListKeranjangError extends ListKeranjangState {
  final String? message;
  ListKeranjangError(this.message);
}


