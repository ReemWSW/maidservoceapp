import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:maid/utils/enum.dart';
import 'package:maid/widget/button_long.dart';
import 'package:maid/widget/textfield_custom.dart';

import 'address.dart';
import 'detail_category.dart';
import '../home/widgets/method.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({
    Key? key,
    required this.category,
  }) : super(key: key);

  final Categories category;

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  String? addressValidate(String? value) =>
      value!.isEmpty ? 'กรุณาที่อยู่' : null;

  String? _address, _detail, _time, _date, _category;
  String? _typeSelected = null;
  int index = 0;

  List? data;
  List? filterData;
  String? _head;

  Future<String> loadJsonData() async {
    var jsonText = await rootBundle.loadString('assets/json/select.json');
    setState(() {
      data = json.decode(jsonText);
    });
    return 'success';
  }

  void submitOrder() {
    if (_formKey.currentState!.validate()) {
      print("address: $_address");
      print("detail: $_detail");
      print("time: $_time");
      print("date: $_date");
      print("category: $_category");
    }
  }

  @override
  void initState() {
    switch (widget.category) {
      case Categories.wash:
        index = 0;
        _category = "ซักผ้า";
        break;
      case Categories.clean:
        index = 1;
        _category = "ทำความสะอาดบ้าน";
        break;
      case Categories.furniture:
        index = 2;
        _category = "ทำความสะอาดเฟอร์นิเจอร์";
        break;
      case Categories.all:
        index = 3;
        _category = "ทำความสะอาดทั้งหมด";
        break;
    }
    loadJsonData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sizedBoxDate = SizedBox(
      width: MediaQuery.of(context).size.width * .6,
      child: TextFormField(
        controller: _dateController,
        decoration: const InputDecoration(
            icon: Icon(Icons.calendar_today), labelText: "วันที่"),
        validator: (value) =>
            value!.isEmpty ? "กรุณาระบุวันที่ที่ต้องการ" : null,
        readOnly: true,
        onTap: () async {
          await datePicker(context);
        },
      ),
    );

    final sizedBoxTime = SizedBox(
      width: MediaQuery.of(context).size.width * .3,
      child: TextFormField(
        controller: _timeController,
        decoration:
            const InputDecoration(icon: Icon(Icons.timer), labelText: "เวลา"),
        validator: (value) => value!.isEmpty ? "กรุณาระบุเวลาที่ต้องการ" : null,
        readOnly: true,
        onTap: () async {
          await timePicker(context);
        },
      ),
    );

    final addressTextfield = TextFieldCustom(
      hintText: 'ที่อยู่',
      icon: Icons.location_on,
      controller: _addressController,
      validator: addressValidate,
      onSaved: (value) => _address = value,
      readOnly: true,
      onTap: () async {
        _address = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const AddressPage(),
          ),
        );
        setState(() {
          _addressController.text = _address!;
        });
      },
    );

    final detailTextfield = TextFieldCustom(
      hintText: 'รายละเอียดเพิ่มเติม',
      icon: Icons.details,
      onChanged: (value) {
        setState(() {
          _detail = value;
        });
      },
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('$_category'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => DetailCategoryPage(index: index)));
              },
              icon: const Icon(Icons.info))
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FutureBuilder(
                future: loadJsonData(),
                builder: (context, snapshot) => snapshot.hasData
                    ? Column(
                        children: [
                          const SizedBox(height: 10),
                          label('สถานที่รับริการ'),
                          addressTextfield,
                          const SizedBox(height: 20),
                          label('${data![index]["head"]}'),
                          dropdownType(),
                          const SizedBox(height: 20),
                          label('รายละเอียดเพิ่มเติม'),
                          detailTextfield,
                          const SizedBox(height: 20),
                          label('เลือกวันที่ต้องการรับบริการ'),
                          Row(
                            children: [
                              sizedBoxDate,
                              sizedBoxTime,
                            ],
                          ),
                        ],
                      )
                    : const CircularProgressIndicator(),
              ),
              ButtonLong(label: 'บันทึก', onPressed: submitOrder)
            ],
          ),
        ),
      ),
    );
  }

  DropdownButtonFormField<String> dropdownType() {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        hintText: data![index]["head"],
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        filled: true,
      ),
      validator: (value) => value == null ? "กรุณาเลือกรูปแบบที่ต้องการ" : null,
      value: _typeSelected,
      onChanged: (String? newValue) {},
      items: ['1', '2'].map((str) {
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

  Future<void> datePicker(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(
            1800), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      print(formattedDate);

      setState(() {
        _dateController.text =
            formattedDate; //set output date to TextField value.
        _selectedDate = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
        );
      });
    } else {
      print("Date is not selected");
    }
  }

  Future<void> timePicker(BuildContext context) async {
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
        _timeController.text = formattedTime; //set the value of text field.
        _selectedDate = DateTime(
          _selectedDate.year,
          _selectedDate.month,
          _selectedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      });
    } else {
      print("Time is not selected");
    }
  }
}