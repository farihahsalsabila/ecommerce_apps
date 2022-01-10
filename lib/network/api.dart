import 'package:dio/dio.dart';

Dio dio = Dio();
const String baseUrl = "http://192.168.100.4/server_commerce/index.php/api";
const String imageUrl = "http://192.168.100.4/server_commerce/image_growback/";
const String apiKategori = "$baseUrl/getKategori";
const String apiProduk = "$baseUrl/getProduk";
const String apiRegister= "$baseUrl/registerCustomer";
const String apiLogin = '$baseUrl/loginCustomer';
const String apiKeranjang = '$baseUrl/addItemKeranjang';
const String apiListKeranjang = '$baseUrl/getKeranjang';
const String apiProfile = '$baseUrl/getProfile';
const String apiUpdateProfile = '$baseUrl/updateDataUser';