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
          RowText(label: 'ชื่อ', text: '$_name'),
          RowText(label: 'อีเมลล์', text: '$_email'),
          RowText(label: 'เบอร์โทรศัพท์', text: '$_phone'),
        ],
      ),
    );
  }
}
