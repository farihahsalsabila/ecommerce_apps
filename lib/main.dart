import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_magang/cubit/kategori/kategori_cubit.dart';
import 'package:training_magang/data_global.dart';
import 'package:training_magang/data_lokal/preference_data.dart';
import 'package:training_magang/network/api.dart';
import 'package:training_magang/res/res_get_kategori.dart';
import 'package:training_magang/res/res_get_produk.dart';
import 'package:training_magang/view/auth/login_page.dart';
import 'package:training_magang/view/data_produk.dart';
import 'package:training_magang/view/list_keranjang.dart';
import 'package:training_magang/view/profile_user.dart';
import 'package:training_magang/view/splashscreen.dart';

void main() {
  runApp(MaterialApp(
    home: SplashScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<KategoriCubit>(create: (context) => KategoriCubit()),
        ],
        child: Scaffold(
            appBar: AppBar(
              title: Text('Udacoding Store'),
              actions: [
                IconButton(onPressed: () async{
                  await SavePreference().clearAll().then((value) => {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => LoginPage()), (route) => false)
                  });
                }, icon: Icon(Icons.lock)),
                IconButton(onPressed: () async{
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ListKeranjang()));
                  }, icon: Icon(Icons.shopping_cart))
              ],
            ),
            drawer: Drawer(
              child: ListView(
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text('${dataGlobal.user?.userNama}'),
                    accountEmail: Text('${dataGlobal.user?.userEmail}'),
                  currentAccountPicture: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileUser()));
                    },
                   child: CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.person),
                  ),),),
                  ListTile(
                    title: Text('List Cart'),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ListKeranjang()));
                    },
                  ),
                  ListTile(
                    title: Text('List History'),
                    onTap: (){
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>ListKeranjang()));
                    },
                  )
                ],
              ),
            ),
            body: BlocBuilder<KategoriCubit, KategoriState>(
                builder: (context, state) {
              KategoriCubit cubit = context.read<KategoriCubit>();
              if (state is KategoriInitial) {
                cubit.getDataKategori();
              }
              if (state is KategoriLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is KategoriSuccess) {
                return SingleChildScrollView(
                    child: Column(children: [
                  CarouselSlider(
                      items: cubit.restGetKategori?.data?.map((e) {
                        return Image.network(
                          imageUrl + '${e.foto}',
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                        );
                      }).toList(),
                      options: CarouselOptions(
                          autoPlay: true, enlargeCenterPage: true)),
                  Container(
                      height: 150,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: cubit.restGetKategori?.data?.length,
                          itemBuilder: (context, index) {
                            DataKategori? data =
                                cubit.restGetKategori?.data?[index];
                            return Container(
                              margin: EdgeInsets.all(5),
                              height: 110,
                              width: 110,
                              child: Column(
                                children: [
                                  Image.network(
                                    imageUrl + '${data?.foto}',
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  Text('${data?.kategoriNama}')
                                ],
                              ),
                            );
                          })),
                  Container(
                    height: 600, child: DataProduk()
                  )

                ]));
              }
              return Container();
            })));
  }
}
