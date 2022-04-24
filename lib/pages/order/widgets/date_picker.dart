import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({Key? key}) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  final TextEditingController _dateController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

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
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
  }
}
