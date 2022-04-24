import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimePicker extends StatefulWidget {
  const TimePicker({Key? key}) : super(key: key);

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  final TextEditingController _timeController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
  }
}
