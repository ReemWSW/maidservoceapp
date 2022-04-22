import 'package:flutter/material.dart';
import 'package:maid/pages/home/widgets/method.dart';
import 'package:maid/widget/button_long.dart';
import 'package:maid/widget/textfield_custom.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ใส่ที่อยู่'),
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                label('ที่อยู่'),
                const SizedBox(height: 20),
                const TextFieldCustom(hintText: "จังหวัด, เขต/อำเภอ"),
                const SizedBox(height: 10),
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
