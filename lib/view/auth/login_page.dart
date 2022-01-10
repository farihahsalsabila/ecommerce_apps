import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_magang/cubit/auth/login/login_cubit.dart';
import 'package:training_magang/view/auth/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => LoginCubit())
    ], child: Scaffold(
        body: Container(
          margin: EdgeInsets.all(30),
          alignment: Alignment.center,
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
                BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    LoginCubit cubit = context.read<LoginCubit>();
                    // if(state is LoginLoading){
                    //   return Center(
                    //     child: CircularProgressIndicator(),
                    //   );
                    // }
                    if(state is LoginError){
                      log('${state.message}');
                    }
                    return MaterialButton(
                        color: Colors.blue,
                        minWidth: 300,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        onPressed: () async {
                          if (_keyForm.currentState!.validate()) {
                            await cubit.loginAccount(context, email.text, password.text);
                          }
                        },
                        child: state is LoginLoading ? CircularProgressIndicator(color: Colors.white,) : Text(
                    'Login',
                    style: TextStyle(color: Colors.white)));
                  },
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()));
                    },
                    child: Text('Anda belum punya akun? silahkan daftar?'))
              ],
            ),
          ),
        )));
  }
}
