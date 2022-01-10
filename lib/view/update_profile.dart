import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfile extends StatefulWidget {
  final String? telp, nama, email;
  final XFile? image;
  final void Function(String? telp, String? nama, String? email, XFile? image)?
      onUpdate;
  const UpdateProfile(
      {Key? key,
      this.telp,
      this.nama,
      this.email,
      this.image,
      @required this.onUpdate})
      : super(key: key);

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  TextEditingController? telp, nama, email;
  XFile? image;

  Future<void> getImageCamera() async {
    var takeImage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (takeImage != null) {
      setState(() {
        image = takeImage;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nama = TextEditingController(text: widget.nama);
    telp = TextEditingController(text: widget.telp);
    email = TextEditingController(text: widget.email);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        insetPadding: EdgeInsets.all(10),
        content: Container(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: getImageCamera,
              child: image != null
                  ? Image.file(
                      File(image!.path),
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                fit: BoxFit.fitWidth,
                    )
                  : Text(
                      'Select Image',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
              ),
              SizedBox(height: 18,),
              TextFormField(
                controller: nama,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    hintText: 'Nama',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none
                    ),
                    filled: true,
                    fillColor: Colors.blue.withOpacity(0.3)
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none
                    ),
                    filled: true,
                    fillColor: Colors.blue.withOpacity(0.3)
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: telp,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    hintText: 'Telp',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none
                    ),
                    filled: true,
                    fillColor: Colors.blue.withOpacity(0.3)
                ),
              ),
              SizedBox(height: 15,),
              MaterialButton(
                  minWidth: 200,
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: (){
                    widget.onUpdate!(telp?.text, nama?.text, email?.text, image!);
                    Navigator.pop(context);
                  },
                  child: Text('Update'))
            ],
          ),
        )));
  }
}
