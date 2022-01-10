import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:training_magang/cubit/cart/insert_cart_cubit.dart';
import 'package:training_magang/data_lokal/preference_data.dart';
import 'package:training_magang/network/api.dart';
import 'package:training_magang/res/res_get_produk.dart';
import 'package:training_magang/view/auth/login_page.dart';

const chart = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
String? randomString(int? strlen) {
  Random rnd = Random(DateTime.now().millisecondsSinceEpoch);
  String result = "";
  for (int i = 0; i < strlen!; i++) {
    result += chart[rnd.nextInt(chart.length)];
  }
  return result;
}

class DetailProduk extends StatefulWidget {
  DataProduct? dataProduct;
  DetailProduk({Key? key, this.dataProduct});

  @override
  _DetailProdukState createState() => _DetailProdukState();
}

class _DetailProdukState extends State<DetailProduk> {
  int counter = 1;

  void minusItem() {
    if (counter == 1) {
      setState(() {
        counter;
      });
    } else {
      setState(() {
        counter--;
      });
    }
  }

  void addItem() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [BlocProvider(create: (context) => InsertCartCubit())],
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text('Detail Produk'),
          ),
          body: SingleChildScrollView(
    child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                    child: Column(children: [
                  Image.network(
                    imageUrl + '${widget.dataProduct!.produkGambar}',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${widget.dataProduct!.produkNama}',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('Rp. ${widget.dataProduct!.produkHarga}'),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height / 5,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                Container(
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    height:
                                        MediaQuery.of(context).size.height / 3,
                                    width:
                                        MediaQuery.of(context).size.height / 4,
                                    child: Image.network(imageUrl +
                                        '${widget.dataProduct!.produkGambar}')),
                                Container(
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    height:
                                        MediaQuery.of(context).size.height / 3,
                                    width:
                                        MediaQuery.of(context).size.height / 4,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withAlpha(50))),
                              ],
                            );
                          })),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.height,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              minusItem();
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.blue,
                              radius: 18,
                              child: Icon(Icons.remove),
                            ),
                          ),
                          Text(
                            '$counter',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: () {
                              addItem();
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.blue,
                              radius: 18,
                              child: Icon(Icons.add),
                            ),
                          ),
                        ],
                      ))
                ])),
              ],
            ),
          ),
          ),bottomNavigationBar: BottomAppBar(
            child: BlocBuilder<InsertCartCubit, InsertCartState>(
              builder: (context, state) {
                InsertCartCubit cubit = context.read<InsertCartCubit>();
                if (state is InsertCartLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is InsertCartError) {
                  print('${state.message}');
                }
                return MaterialButton(
                  height: 45,
                  minWidth: MediaQuery.of(context).size.width,
                  color: Colors.blue,
                  onPressed: () async {
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    var _orderid = pref.getString('idorder');
                    if (_orderid != null) {
                      await cubit.addItemKeranjang(
                          context,
                          _orderid,
                          widget.dataProduct?.produkId.toString(),
                          counter,
                          widget.dataProduct?.produkHarga);
                    } else {
                      String? idOrder = randomString(8);
                      pref.setString('idorder', idOrder!);
                      await cubit.addItemKeranjang(
                          context,
                          idOrder,
                          widget.dataProduct?.produkId.toString(),
                          counter,
                          widget.dataProduct?.produkHarga);
                    }
                  },
                  child: Text(
                    'Add to Cart',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          ),
        ));
  }
}
