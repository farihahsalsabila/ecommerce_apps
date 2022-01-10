import 'package:flutter/material.dart';
import 'package:training_magang/data_lokal/preference_data.dart';
import 'package:training_magang/main.dart';
import 'package:training_magang/view/auth/login_page.dart';

import '../data_global.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> startSplash() async {
    return Future.delayed(Duration(seconds: 7), () async{
      dataGlobal.user = await SavePreference().loadUser();
      if(dataGlobal.user != null){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>HomeScreen()), (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>LoginPage()), (route) => false);
      }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startSplash();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('UDACODING STORE', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
      ),
    );
  }
}
