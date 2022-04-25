import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:provider/provider.dart';
import 'package:maid/models/user.dart';
import 'package:maid/providers/auth.dart';
import 'package:maid/pages/login/login.dart';
import 'package:maid/widget/button_long.dart';
import 'package:maid/widget/textfield_custom.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  String? emailValidate(String? value) {
    RegExp regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (value!.isEmpty) {
      return "กรุณาระบุอีเมล์";
    } else if (!regex.hasMatch(value)) {
      return "อีเมลล์ไม่ถูกต้อง";
    }
  }

  String? passValidate(String? value) =>
      value!.isEmpty ? 'กรุณาระบุรหัสผ่าน' : null;

  String? nameValidate(String? value) =>
      value!.isEmpty ? 'กรุณาระบุชื่อนาทสกุล' : null;

  String? phoneValidate(String? value) =>
      value!.isEmpty ? 'กรุณาระบุชื่อนาทสกุล' : null;

  String? _name, _email, _password, _phone, _image64 = '';

  void submitRegister() {
    AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);
    final form = _formKey.currentState!;
    if (_image64! == '') {
      _image64 = '-';
    }
    if (form.validate()) {
      form.save();
      auth
          .register(
        _image64!,
        _name!,
        _email!,
        _password!,
        _phone!,
      )
          .then((response) {
        if (response['status']) {
          User user = response['data'];
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        } else {
          Flushbar(
            title: "ไม่สามารถลงทะเบียนได้",
            backgroundColor: Colors.red,
            message: response['data'],
            duration: const Duration(seconds: 5),
          ).show(context);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);

    final imageContainer = Center(
      child: InkWell(
        child: Container(
          child: _image64 == ''
              ? const Icon(
                  Icons.account_circle_rounded,
                  color: Colors.grey,
                  size: 50,
                )
              // : SizedBox(),
              : Image.memory(base64Decode(_image64!)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey),
          ),
          width: 200,
          height: 200,
        ),
        onTap: () {
          selectPhoto(context);
        },
      ),
    );

    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        CircularProgressIndicator(),
        Text("กรุณารอสักครู่")
      ],
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("ลงทะเบียน"),
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  imageContainer,
                  const SizedBox(height: 15),
                  TextFieldCustom(
                    hintText: 'ชื่อ นามสกุล',
                    icon: Icons.people,
                    validator: nameValidate,
                    onSaved: (value) => _name = value,
                  ),
                  const SizedBox(height: 15),
                  TextFieldCustom(
                    hintText: 'อีเมลล์',
                    icon: Icons.email,
                    validator: emailValidate,
                    onSaved: (value) => _email = value,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 15),
                  TextFieldCustom(
                    hintText: 'รหัสผ่าน',
                    icon: Icons.password,
                    validator: passValidate,
                    obscureText: true,
                    onSaved: (value) => _password = value,
                  ),
                  const SizedBox(height: 15),
                  TextFieldCustom(
                    hintText: 'เบอร์โทรศัพท์',
                    icon: Icons.phone,
                    validator: phoneValidate,
                    onSaved: (value) => _phone = value,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 30),
                ],
              ),
              auth.loggedInStatus == Status.Authenticating
                  ? loading
                  : ButtonLong(
                      label: 'ลงทะเบียน',
                      onPressed: submitRegister,
                    )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> selectPhoto(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            InkWell(
              child: const ListTile(
                leading: Icon(Icons.camera),
                title: Text('กล้องถ่ายรูป'),
              ),
              onTap: () => _getFromGallery(ImageSource.camera),
            ),
            InkWell(
              child: const ListTile(
                leading: Icon(Icons.photo),
                title: Text('อัลบั้ม'),
              ),
              onTap: () => _getFromGallery(ImageSource.gallery),
            ),
          ],
        );
      },
    );
  }

  _getFromGallery(ImageSource source) async {
    var imagePick = await ImagePicker().getImage(
      source: source,
      maxWidth: 500,
      maxHeight: 500,
      imageQuality: 25,
    );
    if (imagePick != null) {
      try {
        final bytes = File(imagePick.path).readAsBytesSync();
        setState(() {
          _image64 = base64Encode(bytes);
        });
      } catch (e) {
        Flushbar(
          title: "เพิ่มรูปภาพไม่สำเร็จ",
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
        ).show(context);
      }
    }
  }
}
