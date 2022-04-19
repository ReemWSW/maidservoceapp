import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maid/widget/button_long.dart';
import 'package:maid/widget/text_button.dart';

import 'package:maid/widget/textfield_custom.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/login.svg',
              height: 200,
            ),
            const TextFieldCustom(
              labelText: 'Email',
              hintText: 'Email',
            ),
            const SizedBox(height: 10),
            const TextFieldCustom(
              labelText: 'Password',
              hintText: 'Password',
            ),
            const SizedBox(height: 10),
            const ButtonLong(
              label: 'เข้าสู่ระบบ',
            ),
            const Align(
                alignment: Alignment.centerRight,
                child: ButtonTextCustom(
                  label: 'ลงทะเบียน',
                ))
          ],
        ),
      ),
    );
  }
}
