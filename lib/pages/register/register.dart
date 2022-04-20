import 'package:flutter/material.dart';
import 'package:maid/widget/button_long.dart';
import 'package:maid/widget/textfield_custom.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
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
                  imageButton(),
                  const SizedBox(height: 15),
                  TextFieldCustom(
                    hintText: 'ชื่อ นามสกุล',
                    icon: Icons.people,
                    validator: nameValidate,
                  ),
                  const SizedBox(height: 15),
                  TextFieldCustom(
                    hintText: 'อีเมลล์',
                    icon: Icons.email,
                    validator: emailValidate,
                  ),
                  const SizedBox(height: 15),
                  TextFieldCustom(
                    hintText: 'รหัสผ่าน',
                    icon: Icons.password,
                    validator: passValidate,
                  ),
                  const SizedBox(height: 30),
                ],
              ),
              ButtonLong(
                label: 'ลงทะเบียน',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {}
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  InkWell imageButton() {
    return InkWell(
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.6),
              spreadRadius: 2,
              blurRadius: 10,
            ),
          ],
        ),
        child: const Icon(Icons.photo),
      ),
    );
  }
}
