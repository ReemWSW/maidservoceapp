import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maid/models/user.dart';
import 'package:maid/pages/register/register.dart';
import 'package:maid/providers/auth.dart';
import 'package:maid/providers/user_provider.dart';
import 'package:maid/widget/bottombar.dart';
import 'package:maid/widget/button_long.dart';
import 'package:maid/widget/text_button.dart';

import 'package:maid/widget/textfield_custom.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  String? passwordValidate(String? value) =>
      value!.isEmpty ? 'กรุณาระบุรหัสผ่าน' : null;

  String? emailValidate(String? value) =>
      value!.isEmpty ? 'กรุณาระบุอีเมลล์' : null;

  String? _email, _password;

  void submitRegister() {
    AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final Future<Map<String, dynamic>> successfulMessage =
          auth.login(_email!, _password!);

      successfulMessage.then((response) {
        if (response['status']) {
          User user = response['user'];
          Provider.of<UserProvider>(context, listen: false).setUser(user);
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const HomePage()));
        } else {
          Flushbar(
            title: "ไม่สามารถเข้าสู่ระบบได้",
            message: response['message'].toString(),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ).show(context);
        }
      });
    } else {
      print("form is invalid");
    }
  }

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
                onSaved: (value) => _email = value,
              ),
              const SizedBox(height: 10),
              TextFieldCustom(
                hintText: 'รหัสผ่าน',
                icon: Icons.password,
                obscureText: true,
                validator: passwordValidate,
                onSaved: (value) => _password = value,
              ),
              const SizedBox(height: 10),
              ButtonLong(
                label: 'เข้าสู่ระบบ',
                onPressed: submitRegister,
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
