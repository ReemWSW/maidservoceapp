import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maid/pages/register/register.dart';
import 'package:maid/widget/button_long.dart';
import 'package:maid/widget/text_button.dart';

import 'package:maid/widget/textfield_custom.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  String? passwordValidate(String? value) =>
      value!.isEmpty ? 'กรุณาระบุรหัสผ่าน' : null;
  String? emailValidate(String? value) =>
      value!.isEmpty ? 'กรุณาระบุอีเมลล์' : null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/login.svg',
                height: 200,
              ),
              TextFieldCustom(
                hintText: 'อีเมลล์',
                icon: Icons.email,
                obscureText: false,
                validator: emailValidate,
              ),
              const SizedBox(height: 10),
              TextFieldCustom(
                hintText: 'รหัสผ่าน',
                icon: Icons.password,
                obscureText: true,
                validator: passwordValidate,
              ),
              const SizedBox(height: 10),
              ButtonLong(
                label: 'เข้าสู่ระบบ',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: ButtonTextCustom(
                    label: 'ลงทะเบียน',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
