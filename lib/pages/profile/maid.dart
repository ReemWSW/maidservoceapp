import 'package:flutter/material.dart';

class MaidSetupPage extends StatelessWidget {
  const MaidSetupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ตั้งค่าแม่บ้าน'),
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'บริเวณที่ต้องการทำงาน',
              style: TextStyle(fontSize: 20),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: Colors.grey, width: 2, style: BorderStyle.solid)),
              child: const Text(
                '',
                style: TextStyle(fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}
