// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maid/providers/order_provider.dart';
import 'package:maid/utils/enum.dart';
import 'package:maid/widget/bottombar.dart';
import 'package:provider/provider.dart';

class MyWorkInfo extends StatelessWidget {
  const MyWorkInfo({
    Key? key,
    required this.booking,
    required this.order,
    required this.index,
  }) : super(key: key);

  final bool booking;
  final List order;
  final int index;

  @override
  Widget build(BuildContext context) {
    const textheadStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('รายละเอียดงาน'),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Text("${order[index]["customer"]["name"]}",
                      style: const TextStyle(fontSize: 20)),
                  Text('เบอร์โทรศัพท์ ${order[index]["customer"]["phone"]}',
                      style: const TextStyle(fontSize: 20)),
                  Container(
                    margin: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Card(
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'รายละเอียดของงาน',
                                  style: textheadStyle,
                                ),
                                if (order[index]["category"] ==
                                    "Categories.CLEANING")
                                  textData("ทำความสะอาดบ้าน")
                                else if (order[index]["category"] ==
                                    "Categories.FURNITURE")
                                  textData("ทำความสะอาดเฟอร์นิดจอร์")
                                else if (order[index]["category"] ==
                                    "Categories.WASH")
                                  textData("ซักผ้า"),
                                textData(order[index]["type"]),
                                textData(DateFormat('วันที่ yyyy-MM-dd').format(
                                    DateTime.parse(order[index]['datetime']))),
                                textData(DateFormat('เวลา kk:mm').format(
                                    DateTime.parse(order[index]['datetime']))),
                                const SizedBox(
                                  height: 50,
                                ),
                                const Text('ที่อย่', style: textheadStyle),
                                textData(
                                    'ที่อยู่ ${order[index]["address"]["detail"]} ตำบล ${order[index]["address"]["tombon"]} อำเภอ ${order[index]["address"]["amphure"]} จังหวัด ${order[index]["address"]["province"]}'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            booking
                ? Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 100,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green),
                              onPressed: () async {
                                await Provider.of<OrderProvider>(context,
                                        listen: false)
                                    .setStatusOrder(order[index]["_id"],
                                        'EnumOrder.ACCEPT');
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => const HomePage()),
                                    (Route<dynamic> route) => false);
                              },
                              child: const Text('รับงาน'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }

  Text textData(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 16),
    );
  }
}
