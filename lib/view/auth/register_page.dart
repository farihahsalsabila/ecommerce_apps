import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_magang/cubit/auth/register/register_cubit.dart';
import 'package:training_magang/view/auth/login_page.dart';
import 'package:training_magang/view/auth/register_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController fullname = TextEditingController();
  TextEditingController telp = TextEditingController();
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [BlocProvider(create: (context) => RegisterCubit())],
        child: Scaffold(
            body: Container(
          margin: EdgeInsets.all(30),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Form(
            key: _keyForm,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: 50,
                  child: Icon(
                    Icons.person,
                    size: 75,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                TextFormField(
                  validator: (val) {
                    return val!.isEmpty ? "Fullname tidak boleh kosong" : null;
                  },
                  keyboardType: TextInputType.name,
                  controller: fullname,
                  decoration: InputDecoration(
                      hintText: 'Full Name',
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10)),
                      filled: true,
                      prefixIcon: Icon(Icons.person),
                      fillColor: Colors.grey.withOpacity(0.3)),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (val) {
                    return val!.isEmpty ? "Telephone tidak boleh kosong" : null;
                  },
                  keyboardType: TextInputType.phone,
                  controller: telp,
                  decoration: InputDecoration(
                      hintText: 'Telephone',
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10)),
                      filled: true,
                      prefixIcon: Icon(Icons.call),
                      fillColor: Colors.grey.withOpacity(0.3)),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (val) {
                    return val!.isEmpty ? "Email tidak boleh kosong" : null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  controller: email,
                  decoration: InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10)),
                      filled: true,
                      prefixIcon: Icon(Icons.email),
                      fillColor: Colors.grey.withOpacity(0.3)),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (val) {
                    return val!.isEmpty ? "Password tidak boleh kosong" : null;
                  },
                  keyboardType: TextInputType.visiblePassword,
                  controller: password,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10)),
                      filled: true,
                      prefixIcon: Icon(Icons.lock),
                      fillColor: Colors.grey.withOpacity(0.3)),
                ),
                SizedBox(
                  height: 15,
                ),
                BlocBuilder<RegisterCubit, RegisterState>(
                  builder: (context, state) {
                    RegisterCubit cubit = context.read<RegisterCubit>();
                    if (state is RegisterLoding) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is RegisterError) {
                      log('${state.message}');
                    }
                    return MaterialButton(
                        minWidth: 320,
                        height: 50,
                        onPressed: () async {
                          if (_keyForm.currentState!.validate()) {
                            await cubit.registerAccount(context, fullname.text,
                                email.text, telp.text, password.text);
                          }
                        },
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ));
                  },
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: Text('Anda sudah punya akun? silahkan login'))
              ],
            ),
          ),
        ))));
  }
}
