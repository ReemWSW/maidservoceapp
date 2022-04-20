import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:maid/models/user.dart';
import 'package:maid/providers/auth.dart';
import 'package:maid/providers/user_provider.dart';
import 'package:maid/widget/button_long.dart';
import 'package:maid/widget/textfield_custom.dart';
import 'package:provider/provider.dart';

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

  String? _name, _email, _password, _phone;
  String _image64 = ' ';

  void submitRegister() {
    AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);
    final form = _formKey.currentState!;
    if (form.validate()) {
      print(_image64);
      print(_name);
      print(_email);
      print(_password);
      print(_phone);
      form.save();
      auth
          .register(
        _image64 == null ? '' : _image64,
        _name!,
        _email!,
        _password!,
        _phone!,
      )
          .then((response) {
        if (response['status']) {
          User user = response['data'];
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
                  imageButton(),
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
