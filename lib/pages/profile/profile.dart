import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:maid/pages/login/login.dart';
import 'package:maid/providers/auth.dart';
import 'package:maid/providers/user_provider.dart';
import 'package:maid/utils/sharepreferences/auth.dart';
import 'package:provider/provider.dart';

import 'maid.dart';
import 'widgets/container_image.dart';
import 'widgets/row_text.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _image, _name, _phone, _email, _id;

  bool? _maid;

  void logout(BuildContext context) {
    Provider.of<AuthProvider>(context, listen: false).logout();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const LoginPage(),
      ),
      (route) => false,
    );
  }

  void regisMaid(BuildContext context, String _id) async {
    Provider.of<UserProvider>(context, listen: false).setPostMaid();
    Provider.of<UserProvider>(context, listen: false).setMaid(_id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    UserPreferences().getUser().then((user) {
      _image = user.image;
      _name = user.name;
      _phone = user.phone;
      _email = user.email;
      _maid = user.maid;
      _id = user.id;
    });

    return Container(
      margin: const EdgeInsets.all(16),
      child: FutureBuilder(
          future: UserPreferences().getUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  ContainerImage(image: _image),
                  RowText(label: 'ชื่อ', widget: Text('$_name')),
                  RowText(label: 'อีเมลล์', widget: Text('$_email')),
                  RowText(label: 'เบอร์โทรศัพท์', widget: Text('$_phone')),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const MaidSetupPage()));
                    },
                    child: RowText(
                        label: 'สถานะ',
                        widget: Text(_maid == true ? "แม่บ้าน" : 'ลูกค้า')),
                  ),
                  // RowText(
                  //     label: 'สถานะ',
                  //     widget: _maid == false
                  //         ? ElevatedButton(
                  //             onPressed: () => regisMaid(context, _id!),
                  //             child: const Text('ลงทะเบียนแม่บ้านที่นี่'))
                  //         : const Text('แม่บ้าน')),
                  RowText(
                      label: '',
                      widget: ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                          onPressed: () => logout(context),
                          child: const Text('ออกจากระบบ'))),
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }
}
