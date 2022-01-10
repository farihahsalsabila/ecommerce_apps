import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:training_magang/main.dart';
import 'package:training_magang/repository/repo_auth.dart';
import 'package:training_magang/res/res_profile.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  RepoAuth repo = RepoAuth();
  RestGetProfile? restGetProfile;

  Future<void> getProfile(BuildContext context) async {
    try {
      emit(ProfileLoading());
      RestGetProfile? res = await repo.profileAccount();
      if (res != null) {
        restGetProfile = res;
        emit(ProfileSuccess(restGetProfile));
      } else {
        emit(ProfileError(res?.message));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${res?.message}'),));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${e.toString()}'),));
    }
  }
}
