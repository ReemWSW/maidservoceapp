import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maid/utils/enum.dart';
import 'package:maid/widget/button_long.dart';
import 'package:maid/widget/textfield_custom.dart';

import 'address.dart';

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
  TextEditingController _timeController = TextEditingController();
  TextEditingController _dateController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  String? addressValidate(String? value) =>
      value!.isEmpty ? 'กรุณาที่อยู่' : null;

  String? _address, _detail, _time, _date;
  String? _typeSelected = null;

  Text label(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 15,
      ),
    );
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
      onTap: () async {
        _address = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const AddressPage(),
          ),
        );
      },
      hintText: 'ที่อยู่',
      icon: Icons.location_on,
      validator: addressValidate,
      onSaved: (value) => _address = value,
    );

    final detailTextfield = TextFieldCustom(
      hintText: 'รายละเอียดเพิ่มเติม',
      icon: Icons.details,
      onSaved: (value) => _detail = value,
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('${widget.category}'),
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(height: 10),
                label('สถานที่รับริการ'),
                addressTextfield,
                const SizedBox(height: 20),
                label('เลือกรูปแบบการบริการที่ต้องการ'),
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
            ),
            ButtonLong(label: 'บันทึก', onPressed: () {})
          ],
        ),
      ),
    );
  }

  DropdownButtonFormField<String> dropdownType() {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        labelText: "เลือกแบบการบริการที่ต้องการ",
        labelStyle: const TextStyle(color: Colors.black),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
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
