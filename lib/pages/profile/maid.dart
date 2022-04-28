import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart';
import 'package:maid/pages/order/widgets/amphure.dart';
import 'package:maid/pages/order/widgets/provinces.dart';
import 'package:maid/pages/order/widgets/tombon.dart';
import 'package:maid/providers/user_provider.dart';
import 'package:maid/utils/enum.dart';
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

  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _amphureController = TextEditingController();
  final TextEditingController _tombonController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  String? addressValidate(String? value) =>
      value!.isEmpty ? 'กรุณาที่อยู่' : null;

  List? address;
  String? _province, _amphure, _tombon, _id;
  bool valuefirst = false;

  List? _resultProvince;
  List? _resultAmphure;
  List? _resultTombon;

  String? maidcategory;

  var items = [
    'ซักผ้า',
    'ทำความสะอาดบ้าน',
    'ทำความสะอาดเฟอร์นิเจอร์',
    'ทำความสะอาดทั้งหมด',
  ];

  void fetchUser() async {
    await UserPreferences().getUser().then((user) {
      var categoryPost;

      switch (user.category!) {
        case 'Categories.wash':
          categoryPost = 'ซักผ้า';
          break;
        case 'Categories.clean':
          categoryPost = "ทำความสะอาดบ้าน";
          break;
        case 'Categories.furniture':
          categoryPost = "ทำความสะอาดเฟอร์นิเจอร์";
          break;
        case 'Categories.all':
          categoryPost = "ทำความสะอาดทั้งหมด";
          break;
        default:
          categoryPost = user.category!;
      }
      print(categoryPost);
      setState(() {
        valuefirst = user.maid!;
        _id = user.id;
        _province = user.address!.province!;
        _amphure = user.address!.amphure!;
        _tombon = user.address!.tombon!;
        maidcategory = categoryPost;
        _selectedDate = user.datetime!;
        _timeController.text = DateFormat.Hms().format(_selectedDate);
        _dateController.text = DateFormat('yyyy-MM-dd').format(_selectedDate);
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
    String maidcategory,
    DateTime datetime,
  ) async {
    // Provider.of<UserProvider>(context, listen: false).setPostMaid(
    //   maid,
    //   _province,
    //   _amphure,
    //   _tombon,
    // );
    await Provider.of<UserProvider>(context, listen: false).setMaid(
        _id, maid, _province, _amphure, _tombon, maidcategory, datetime);
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
          child: SingleChildScrollView(
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
                    const SizedBox(height: 20),
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
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              style: BorderStyle.solid,
                              color: Colors.grey),
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        children: [
                          label('วันและเวลาปฏิบัติงาน'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              textfieldDatePicker(context),
                              textfieldTimePicker(context),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ButtonLong(
                  label: 'บันทึก',
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      await regisMaid(context, _id!, valuefirst, _province!,
                          _amphure!, _tombon!, maidcategory!, _selectedDate);
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
      ),
    );
  }

  Widget textfieldTimePicker(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .3,
      child: TextFormField(
        controller: _timeController,
        decoration:
            const InputDecoration(icon: Icon(Icons.timer), labelText: "เวลา"),
        validator: (value) => value!.isEmpty ? "กรุณาระบุเวลาที่ต้องการ" : null,
        readOnly: true,
        onTap: () async {
          TimeOfDay? pickedTime = await showTimePicker(
              initialTime: TimeOfDay.now(),
              context: context,
              builder: (context, child) {
                return MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                        // Using 12-Hour format
                        alwaysUse24HourFormat: true),
                    // If you want 24-Hour format, just change alwaysUse24HourFormat to true
                    child: child!);
              });

          if (pickedTime != null) {
            DateTime parsedTime =
                DateFormat.jm().parse(pickedTime.format(context).toString());
            String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);

            setState(() {
              _timeController.text =
                  formattedTime; //set the value of text field.
              _selectedDate = DateTime(
                _selectedDate.year,
                _selectedDate.month,
                _selectedDate.day,
                pickedTime.hour,
                pickedTime.minute,
              );
            });
          }
        },
      ),
    );
  }

  Widget textfieldDatePicker(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .45,
      child: TextFormField(
        controller: _dateController,
        decoration: const InputDecoration(
            icon: Icon(Icons.calendar_today), labelText: "วันที่"),
        validator: (value) =>
            value!.isEmpty ? "กรุณาระบุวันที่ที่ต้องการ" : null,
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(
                  1800), //DateTime.now() - not to allow to choose before today.
              lastDate: DateTime(2101));

          if (pickedDate != null) {
            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
            setState(() {
              _dateController.text =
                  formattedDate; //set output date to TextField value.
              _selectedDate = DateTime(
                pickedDate.year,
                pickedDate.month,
                pickedDate.day,
              );
            });
          }
        },
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
