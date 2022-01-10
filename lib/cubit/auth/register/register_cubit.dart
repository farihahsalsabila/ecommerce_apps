import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:training_magang/repository/repo_auth.dart';
import 'package:training_magang/res/res_register.dart';
import 'package:flutter/material.dart';
import 'package:training_magang/view/auth/login_page.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  RepoAuth repo = RepoAuth();
  RestRegister? restRegister;

  Future<void> registerAccount(BuildContext context, String? fullname, String? email, String? telephone, String? password) async {
    try {
      emit(RegisterLoding());
      RestRegister? res = await repo.registerAccount(fullname, email, telephone, password);
     if(res != null) {
       restRegister = res;
       emit(RegisterSuccess(restRegister));
       if(res.status == 200) {
         restRegister = res;
         emit(RegisterSuccess(restRegister));
         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => LoginPage()), (route) => false);
       } else if (res.status == 404) {
         emit(RegisterError(res.message));
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${res.message}'),));
       } else {
         emit(RegisterError(res.message));
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${res.message}'),));
       }
     }
    } catch (e) {
      log('${e.toString()}');
      emit(RegisterError(e.toString()));
    }
  }
}
