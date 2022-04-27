import 'package:flutter/material.dart';
import 'package:maid/pages/order/widgets/amphure.dart';
import 'package:maid/pages/order/widgets/provinces.dart';
import 'package:maid/pages/order/widgets/tombon.dart';
import 'package:maid/providers/user_provider.dart';
import 'package:maid/utils/sharepreferences/auth.dart';
import 'package:maid/widget/button_long.dart';
import 'package:maid/widget/method.dart';
import 'package:maid/widget/textfield_custom.dart';
import 'package:provider/provider.dart';

class MaidSetupPage extends StatefulWidget {
  const MaidSetupPage({Key? key}) : super(key: key);

  @override
  State<MaidSetupPage> createState() => _MaidSetupPageState();
}

class _MaidSetupPageState extends State<MaidSetupPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _amphureController = TextEditingController();
  final TextEditingController _tombonController = TextEditingController();

  String? addressValidate(String? value) =>
      value!.isEmpty ? 'กรุณาที่อยู่' : null;

  List? address;
  String? _province, _amphure, _tombon, _id;
  bool valuefirst = false;

  List? _resultProvince;
  List? _resultAmphure;
  List? _resultTombon;

  String? maidcategory = null;

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
        _province = user.address!.province!;
        _amphure = user.address!.amphure!;
        _tombon = user.address!.tombon!;
      });
    });
    _provinceController.text = _province!;
    _amphureController.text = _amphure!;
    _tombonController.text = _tombon!;
  }

  Future regisMaid(
      BuildContext context,
      String _id,
      bool maid,
      String _province,
      String _amphure,
      String _tombon,
      String maidcategory) async {
    // Provider.of<UserProvider>(context, listen: false).setPostMaid(
    //   maid,
    //   _province,
    //   _amphure,
    //   _tombon,
    // );
    await Provider.of<UserProvider>(context, listen: false)
        .setMaid(_id, maid, _province, _amphure, _tombon, maidcategory);
  }

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
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: edgeInsets,
                      decoration: boxDecoration,
                      child: Column(
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
                              _resultProvince = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          const ProvincesListScreen()));
                              setState(() {
                                _province = _resultProvince![0];
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
                                      builder: (_) => AmphureListScreen(
                                          idpass: _resultProvince![1])));
                              setState(() {
                                _amphure = _resultAmphure![0];
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
                                      builder: (_) => TombonsListScreen(
                                          idpass: _resultAmphure![1])));
                              setState(() {
                                _tombon = _resultTombon![0];
                                _tombonController.text = _tombon!;
                              });
                            },
                          ),
                        ],
                      )),
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
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    await regisMaid(context, _id!, valuefirst, _province!,
                        _amphure!, _tombon!, maidcategory!);
                    Navigator.pop(context, [
                      _tombon,
                      _amphure,
                      _province,
                    ]);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  DropdownButtonFormField<String> dropdownCategory() {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        hintText: '',
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        filled: true,
      ),
      validator: (value) => value == null ? "กรุณาเลือกรูปแบบที่ต้องการ" : null,
      value: maidcategory,
      onChanged: (String? newValue) {
        maidcategory = newValue!;
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
