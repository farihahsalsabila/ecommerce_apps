import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:training_magang/cubit/auth/profile/profile_cubit.dart';
import 'package:training_magang/cubit/auth/updateprofile/update_profile_cubit.dart';
import 'package:training_magang/network/api.dart';
import 'package:training_magang/res/res_profile.dart';
import 'package:training_magang/view/update_profile.dart';

class ProfileUser extends StatefulWidget {
  const ProfileUser({Key? key}) : super(key: key);

  @override
  _ProfileUserState createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
  ProfileCubit? cubitProfile;
  // Profile? dataProfile;
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   dataProfile = cubitProfile?.restGetProfile?.profile?[0];
  // }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<ProfileCubit>(
            create: (context) => ProfileCubit(),
          ),
          BlocProvider<UpdateProfileCubit>(
            create: (context) => UpdateProfileCubit(),
          )
        ],
        child: Scaffold(
            appBar: AppBar(
              title: Text('Profile User'),
            ),
            body: BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                cubitProfile = context.read<ProfileCubit>();
                if (state is ProfileInitial) {
                  cubitProfile?.getProfile(context);
                }
                if (state is ProfileLoading) {
                  return Center(
                    child: CircularProgressIndicator()
                  );
                }
                if (state is ProfileSuccess) {
                  return ListView.builder(
                      itemCount: cubitProfile?.restGetProfile?.profile?.length,
                      itemBuilder: (context, index) {
                        Profile? data =
                            cubitProfile?.restGetProfile?.profile?[index];
                        return Container(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              data?.userImage != ""
                                  ? Image.network(
                                      imageUrl + '${data?.userImage}',
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    )
                                  : CircleAvatar(
                                      radius: 30,
                                      child: Icon(Icons.person),
                                    ),
                              SizedBox(
                                height: 10,
                              ),
                              Text('${data?.userNama}'),
                              SizedBox(
                                height: 10,
                              ),
                              Text('${data?.userEmail}'),
                              SizedBox(
                                height: 10,
                              ),
                              Text('${data?.userHp}'),
                              SizedBox(
                                height: 20,
                              ),
                              BlocBuilder<UpdateProfileCubit,
                                  UpdateProfileState>(
                                builder: (context, state) {
                                  UpdateProfileCubit cubit =
                                      context.read<UpdateProfileCubit>();
                                  if (state is UpdateProfileLoading) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }
                                  if (state is UpdateProfileError) {
                                    log('${state.message}');
                                  }
                                  return MaterialButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    minWidth: 200,
                                    color: Colors.blue,
                                    textColor: Colors.white,
                                    onPressed: () async {
                                      await showDialog(
                                          context: context,
                                          builder: (context) {
                                            return UpdateProfile(
                                              telp: cubitProfile?.restGetProfile?.profile?[0].userHp,
                                              nama: cubitProfile?.restGetProfile?.profile?[0].userNama,
                                              email: cubitProfile?.restGetProfile?.profile?[0].userEmail,
                                              image: XFile(
                                                  cubitProfile?.restGetProfile?.profile?[0].userImage ?? ""),
                                              onUpdate: (String? telp,
                                                  String? nama,
                                                  String? email,
                                                  XFile? image) async {
                                                await cubit.updateProfileUser(
                                                    context,
                                                    telp,
                                                    nama,
                                                    email,
                                                    image).then((value){
                                                  cubitProfile?.getProfile(context);
                                                });
                                              },
                                            );
                                          });
                                    },
                                    child: Text('Update Profile'),
                                  );
                                },
                              )
                            ],
                          ),
                        );
                      });
                }
                return Container();
              },
            )));
  }
}
