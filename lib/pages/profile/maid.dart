import 'package:flutter/material.dart';
import 'package:maid/providers/user_provider.dart';
import 'package:maid/utils/sharepreferences/auth.dart';
import 'package:maid/widget/button_long.dart';
import 'package:maid/widget/method.dart';
import 'package:provider/provider.dart';

import 'widgets/address_maid.dart';

class MaidSetupPage extends StatefulWidget {
  const MaidSetupPage({Key? key}) : super(key: key);

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

  List? _resultProvince;
  List? _resultAmphure;
  List? _resultTombon;

  String dropdownvalue = 'ซักผ้า';

  var items = [
    'ซักผ้า',
    'ทำความสะอาดบ้าน',
    'ทำความสะอาดเฟอร์นิเจอร์',
    'ทำความสะอาดทั้งหมด',
  ];

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

  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _amphureController = TextEditingController();
  final TextEditingController _tombonController = TextEditingController();

  String? provinceValidate(String? value) =>
      value!.isEmpty ? 'กรุณาระบุจังหวัด' : null;
  String? amphureValidate(String? value) =>
      value!.isEmpty ? 'กรุณาระบุอำเภอ' : null;
  String? tombonValidate(String? value) =>
      value!.isEmpty ? 'กรุณาระบุตำบล' : null;

  @override
  void initState() {
    fetchUser();
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var boxDecoration = BoxDecoration(
        border:
            Border.all(width: 1, color: Colors.grey, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(5));
    const edgeInsets = EdgeInsets.all(5);
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: edgeInsets,
                    decoration: boxDecoration,
                    child: const AddressMaid()),
                const SizedBox(height: 20),
                Container(
                  padding: edgeInsets,
                  decoration: boxDecoration,
                  child: Column(
                    children: [
                      label('เลือกรูปแบบ'),
                      dropdownCategory(),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: edgeInsets,
                  decoration: boxDecoration,
                  child: Column(
                    children: [
                      label('สถานะ'),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                style: BorderStyle.solid,
                                color: Colors.grey),
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('สถานะแม่บ้าน',
                                style: TextStyle(fontSize: 16)),
                            Checkbox(
                                value: valuefirst,
                                onChanged: (value) {
                                  setState(() {
                                    valuefirst = value!;
                                  });
                                }),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
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

  DropdownButtonFormField<String> dropdownCategory() {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        hintText: 'data![index]["head"]',
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        filled: true,
      ),
      validator: (value) => value == null ? "กรุณาเลือกรูปแบบที่ต้องการ" : null,
      value: dropdownvalue,
      onChanged: (String? newValue) {
        dropdownvalue = newValue!;
      },
      items: items.map((str) {
        return DropdownMenuItem<String>(
          value: str,
          child: Text(
            str,
            style: const TextStyle(color: Colors.black),
          ),
        );
      }).toList(),
    );
  }
}
