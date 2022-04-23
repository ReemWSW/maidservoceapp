import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:maid/pages/home/widgets/method.dart';
import 'package:maid/widget/button_long.dart';
import 'package:maid/widget/textfield_custom.dart';

import 'widgets/provinces.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _amphureController = TextEditingController();
  final TextEditingController _tombonController = TextEditingController();

  String? _province, _amphure, _tombon;

  List? _resultProvince;
  List? _resulTamphure;
  List? _resultTombon;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('ที่อยู่'),
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                label('จังหวัด'),
                TextFieldCustom(
                  controller: _provinceController,
                  hintText: "จังหวัด",
                  readOnly: true,
                  onTap: () async {
                    _resultProvince = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const ProvincesListScreen()));
                    _province = _resultProvince![0];
                    setState(() {
                      _provinceController.text = _province!;
                    });
                  },
                ),
                // dropDown(context, 'จังหวัด', dataProvinces!),
                const SizedBox(height: 10),
                label('เขต/อำเภอ'),
                const TextFieldCustom(hintText: "เขต/อำเภอ"),
                // dropDown(context, 'เขต/อำเภอ', dataAmphures!),
                const SizedBox(height: 10),
                label('แขวง/ตำบล'),
                const TextFieldCustom(hintText: "แขวง/ตำบล"),
                // dropDown(context, 'แขวง/ตำบล', dataTombons!),
                const SizedBox(height: 10),
                const SizedBox(height: 10),
                label('รายละเอียด'),
                const TextFieldCustom(hintText: "รายละเอียดที่อยู่"),
              ],
            ),
            ButtonLong(
              label: 'บันทึก',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
