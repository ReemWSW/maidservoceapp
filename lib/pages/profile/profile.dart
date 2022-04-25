import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:maid/utils/sharepreferences/auth.dart';

import 'widgets/container_image.dart';
import 'widgets/row_text.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({
    Key? key,
  }) : super(key: key);

  String? _image, _name, _phone, _email;

  @override
  Widget build(BuildContext context) {
    UserPreferences().getUser().then((user) {
      _image = user.image;
      _name = user.name;
      _phone = user.phone;
      _email = user.email;
    });
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          ContainerImage(image: _image),
          RowText(label: 'ชื่อ', widget: Text('$_name')),
          RowText(label: 'อีเมลล์', widget: Text('$_email')),
          RowText(label: 'เบอร์โทรศัพท์', widget: Text('$_phone')),
          RowText(
              label: 'สถานะ',
              widget: ElevatedButton(
                  onPressed: () {},
                  child: const Text('ลงทะเบียนแม่บ้านที่นี่'))),
          RowText(
              label: '',
              widget: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  onPressed: () {},
                  child: const Text('ออกจากระบบ'))),
        ],
      ),
    );
  }
}
