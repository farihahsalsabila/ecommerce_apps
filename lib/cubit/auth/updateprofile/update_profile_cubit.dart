import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:training_magang/cubit/auth/profile/profile_cubit.dart';
import 'package:training_magang/repository/repo_auth.dart';
import 'package:training_magang/res/res_update_profile.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit() : super(UpdateProfileInitial());

  RepoAuth repo = RepoAuth();
  RestUpdateProfile? restUpdateProfile;

  Future<void> updateProfileUser (BuildContext context, String? telp, String? nama, String? email, XFile? image) async {
    try {
      emit(UpdateProfileLoading());
      RestUpdateProfile? res = await repo.updateProfile(nama, email, telp, image);
      if(res != null) {
        restUpdateProfile = res;
        emit(UpdateProfileSuccess(restUpdateProfile));
        // Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${res?.message}'),));
        emit(UpdateProfileError(res?.message));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${e.toString()}'),));
      emit(UpdateProfileError(e.toString()));
    }
  }
}
