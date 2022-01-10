import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_magang/cubit/kategori/kategori_cubit.dart';
import 'package:training_magang/cubit/keranjang/list_keranjang_cubit.dart';
import 'package:training_magang/network/api.dart';
import 'package:training_magang/res/res_get_keranjang.dart';

class ListKeranjang extends StatefulWidget {
  const ListKeranjang({Key? key}) : super(key: key);

  @override
  _ListKeranjangState createState() => _ListKeranjangState();
}

class _ListKeranjangState extends State<ListKeranjang> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<ListKeranjangCubit>(create: (context) => ListKeranjangCubit(),)
    ], child: Scaffold(
      appBar: AppBar(
        title: Text('List keranjang'),
      ),
      body: BlocBuilder<ListKeranjangCubit, ListKeranjangState>(
        builder: (context, state) {
          ListKeranjangCubit cubit = context.read<ListKeranjangCubit>();
          if(state is ListKeranjangInitial) {
            cubit.getDataKeranjang(context);
          }
          if(state is ListKeranjangLoding) {
            return Center(
              child: CircularProgressIndicator()
            );
          }
          if(state is ListKeranjangSuccess) {
            return Container(
                height: 800,
                child: ListView.builder(
                itemCount : cubit.restGetKeranjang?.dataKeranjang?.length,
                itemBuilder: (context, index) {
                  DataKeranjang? data = cubit.restGetKeranjang?.dataKeranjang?[index];
                return Container(
                  child: Column(
                    children: [
                      ListTile(
                        leading: Image.network(imageUrl + '${data?.produkGambar}', width: 100,
                          height: 100,
                          fit: BoxFit.cover,),
                        title: Text('${data?.produkNama}'),
                        trailing: Text('${data?.detailQty}'),
                        subtitle: Text('${data?.produkHarga}'),
                      ),
                    ],
                  )
                );}));
          };
          return Container();
          },
      ),
    ));
  }
}
