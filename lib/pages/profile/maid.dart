import 'package:flutter/material.dart';
import 'package:maid/pages/profile/widgets/row_text.dart';
import 'package:maid/providers/user_provider.dart';
import 'package:maid/utils/sharepreferences/auth.dart';
import 'package:maid/widget/button_long.dart';
import 'package:maid/widget/textfield_custom.dart';
import 'package:provider/provider.dart';

import 'address_maid.dart';

class MaidSetupPage extends StatefulWidget {
  MaidSetupPage({Key? key}) : super(key: key);

  @override
  State<MaidSetupPage> createState() => _MaidSetupPageState();
}

class _MaidSetupPageState extends State<MaidSetupPage> {
  final TextEditingController _addressController = TextEditingController();

  String? addressValidate(String? value) =>
      value!.isEmpty ? 'กรุณาที่อยู่' : null;

  List? address;
  String? _province, _amphure, _tombon, _id;
  String? _address;
  bool valuefirst = false;

  void fetchUser() async {
    await UserPreferences().getUser().then((user) {
      setState(() {
        valuefirst = user.maid!;
        _id = user.id;
      });
    });
  }

  Future regisMaid(BuildContext context, String _id, bool maid) async {
    Provider.of<UserProvider>(context, listen: false).setPostMaid(maid);
    await Provider.of<UserProvider>(context, listen: false).setMaid(_id, maid);
  }

  @override
  void initState() {
    fetchUser();
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ตั้งค่าแม่บ้าน'),
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const Text(
                  'บริเวณที่ต้องการทำงาน',
                  style: TextStyle(fontSize: 20),
                ),
                TextFieldCustom(
                    hintText: 'ที่อยู่',
                    icon: Icons.location_on,
                    controller: _addressController,
                    validator: addressValidate,
                    onSaved: (value) => _address = value,
                    readOnly: true,
                    onTap: () async {
                      address = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AddressMaidPage(),
                        ),
                      );

                      setState(() {
                        setState(() {
                          _addressController.text =
                              "${address![0]} ${address![1]} ${address![2]}";
                        });
                      });
                    }),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('สถานะแม่บ้าน', style: TextStyle(fontSize: 16)),
                    Checkbox(
                        value: valuefirst,
                        onChanged: (value) {
                          setState(() {
                            valuefirst = value!;
                          });
                        }),
                  ],
                )
              ],
            ),
            ButtonLong(
              label: 'บันทึก',
              onPressed: () async {
                await regisMaid(context, _id!, valuefirst);
                Navigator.pop(context, [
                  _tombon,
                  _amphure,
                  _province,
                ]);
              },
            ),
          ],
        ),
      ),
    );
  }
}
