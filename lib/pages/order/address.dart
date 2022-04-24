import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:maid/pages/home/widgets/method.dart';
import 'package:maid/widget/button_long.dart';
import 'package:maid/widget/textfield_custom.dart';

import 'widgets/amphure.dart';
import 'widgets/provinces.dart';
import 'widgets/tombon.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _amphureController = TextEditingController();
  final TextEditingController _tombonController = TextEditingController();

  String? _province, _amphure, _tombon, _detail;

  List? _resultProvince;
  List? _resultAmphure;
  List? _resultTombon;

  String? detailValidate(String? value) =>
      value!.isEmpty ? 'กรุณาระบุรายละเอียด' : null;

  String? provinceValidate(String? value) =>
      value!.isEmpty ? 'กรุณาระบุจังหวัด' : null;
  String? amphureValidate(String? value) =>
      value!.isEmpty ? 'กรุณาระบุอำเภอ' : null;
  String? tombonValidate(String? value) =>
      value!.isEmpty ? 'กรุณาระบุตำบล' : null;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var textFieldProvince = TextFieldCustom(
      controller: _provinceController,
      hintText: "จังหวัด",
      readOnly: true,
      validator: provinceValidate,
      onTap: () async {
        _resultProvince = await Navigator.push(context,
            MaterialPageRoute(builder: (_) => const ProvincesListScreen()));
        _province = _resultProvince![0];
        setState(() {
          _provinceController.text = _province!;
        });
      },
    );

    var textFieldAmphure = TextFieldCustom(
      hintText: "เขต/อำเภอ",
      readOnly: true,
      controller: _amphureController,
      validator: amphureValidate,
      onTap: () async {
        _resultAmphure = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) =>
                    AmphureListScreen(idpass: _resultProvince![1])));
        _amphure = _resultAmphure![0];
        print(_resultAmphure);
        setState(() {
          _amphureController.text = _amphure!;
        });
      },
    );

    var textFieldTombon = TextFieldCustom(
      hintText: "แขวง/ตำบล",
      readOnly: true,
      controller: _tombonController,
      validator: tombonValidate,
      onTap: () async {
        _resultTombon = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => TombonsListScreen(idpass: _resultAmphure![1])));
        _tombon = _resultTombon![0];
        setState(() {
          _tombonController.text = _tombon!;
        });
      },
    );

    var textFieldDetail = TextFieldCustom(
      hintText: "รายละเอียดที่อยู่",
      onChanged: (value) => _detail = value,
      validator: detailValidate,
    );
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
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  label('จังหวัด'),
                  textFieldProvince,
                  // dropDown(context, 'จังหวัด', dataProvinces!),
                  const SizedBox(height: 10),
                  label('เขต/อำเภอ'),
                  textFieldAmphure,
                  // dropDown(context, 'เขต/อำเภอ', dataAmphures!),
                  const SizedBox(height: 10),
                  label('แขวง/ตำบล'),
                  textFieldTombon,
                  // dropDown(context, 'แขวง/ตำบล', dataTombons!),
                  const SizedBox(height: 10),
                  const SizedBox(height: 10),
                  label('รายละเอียด'),
                  textFieldDetail,
                ],
              ),
            ),
            ButtonLong(
              label: 'บันทึก',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // print("$_detail $_tombon  $_amphure $_province");
                  var address = "$_detail $_tombon  $_amphure $_province";
                  Navigator.pop(context, address);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
