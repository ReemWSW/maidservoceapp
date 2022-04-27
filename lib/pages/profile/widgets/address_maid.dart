import 'package:flutter/material.dart';
import 'package:maid/pages/order/widgets/amphure.dart';
import 'package:maid/pages/order/widgets/provinces.dart';
import 'package:maid/pages/order/widgets/tombon.dart';
import 'package:maid/widget/method.dart';
import 'package:maid/widget/textfield_custom.dart';

class AddressMaid extends StatefulWidget {
  const AddressMaid({
    Key? key,
  }) : super(key: key);

  @override
  State<AddressMaid> createState() => _AddressMaidState();
}

class _AddressMaidState extends State<AddressMaid> {
  final TextEditingController _provinceController = TextEditingController();

  final TextEditingController _amphureController = TextEditingController();

  final TextEditingController _tombonController = TextEditingController();

  List? _resultProvince;
  List? _resultAmphure;
  List? _resultTombon;

  String? provinceValidate(String? value) =>
      value!.isEmpty ? 'กรุณาระบุจังหวัด' : null;

  String? amphureValidate(String? value) =>
      value!.isEmpty ? 'กรุณาระบุอำเภอ' : null;

  String? tombonValidate(String? value) =>
      value!.isEmpty ? 'กรุณาระบุตำบล' : null;

  String? _province, _amphure, _tombon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'บริเวณที่ต้องการทำงาน',
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 20),
        label('จังหวัด'),
        TextFieldCustom(
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
        ),
        const SizedBox(height: 10),
        label('เขต/อำเภอ'),
        TextFieldCustom(
          hintText: "เขต/อำเภอ",
          readOnly: true,
          controller: _amphureController,
          validator: amphureValidate,
          enabled: _resultProvince == null ? false : true,
          onTap: () async {
            _resultAmphure = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) =>
                        AmphureListScreen(idpass: _resultProvince![1])));
            _amphure = _resultAmphure![0];
            setState(() {
              _amphureController.text = _amphure!;
            });
          },
        ),
        const SizedBox(height: 10),
        label('แขวง/ตำบล'),
        TextFieldCustom(
          hintText: "แขวง/ตำบล",
          enabled: _resultAmphure == null ? false : true,
          readOnly: true,
          controller: _tombonController,
          validator: tombonValidate,
          onTap: () async {
            _resultTombon = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) =>
                        TombonsListScreen(idpass: _resultAmphure![1])));
            _tombon = _resultTombon![0];
            setState(() {
              _tombonController.text = _tombon!;
            });
          },
        ),
      ],
    );
  }
}
