import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:training_magang/data_global.dart';
import 'package:training_magang/data_lokal/preference_data.dart';
import 'package:training_magang/main.dart';
import 'package:training_magang/repository/repo_auth.dart';
import 'package:training_magang/res/res_login.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  RepoAuth repo = RepoAuth();
  RestLogin? restLogin;

  Future<void> loginAccount(BuildContext context, String? fullname, String? password) async {
    try {
      emit(LoginLoading());
      RestLogin? res = await repo.loginAccount(fullname, password);
      if(res != null) {
        restLogin = res;
        emit(LoginSuccess(restLogin));
        if(res.status == 200) {
          restLogin = res;
          dataGlobal.user = restLogin?.user;
          await SavePreference().saveUser();
          emit(LoginSuccess(restLogin));
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => HomeScreen()), (route) => false);
        } else if (res.status == 404) {
          emit(LoginError(res.message));
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${res.message}'),));
        } else {
          emit(LoginError(res.message));
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${res.message}'),));
        }
      }
    } catch (e) {
      log('${e.toString()}');
      emit(LoginError(e.toString()));
    }
  }
}
