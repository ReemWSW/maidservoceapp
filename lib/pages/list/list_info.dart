import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maid/pages/list/widgets/container_image.dart';
import 'package:maid/providers/order_provider.dart';
import 'package:provider/provider.dart';

class ListInfoPage extends StatelessWidget {
  const ListInfoPage({
    Key? key,
    required this.booking,
    required this.order,
  }) : super(key: key);

  final bool booking;
  final List order;
  @override
  Widget build(BuildContext context) {
    const textheadStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
    DateTime dateTime = DateTime.parse(order[0]["datetime"]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('รายละเอียดงาน'),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(16),
                  child: Align(
                    alignment: Alignment.center,
                    child: ContainerImage(
                      image: '${order[0]["customer"]["image"]}',
                    ),
                  ),
                ),
                cardCustom(
                  context,
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'ข้อมูลผู้ติดต่อ',
                        style: textheadStyle,
                      ),
                      textData('${order[0]["customer"]["name"]}'),
                      textData(
                          'เบอร์โทรศัพท์ ${order[0]["customer"]["phone"]}'),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'สถานที่รับบริการ:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      textData(
                          'ที่อยู่ ${order[0]["address"]["detail"]} ตำบล ${order[0]["address"]["tombon"]} อำเภอ ${order[0]["address"]["amphure"]} จังหวัด ${order[0]["address"]["province"]}'),
                    ],
                  ),
                ),
                cardCustom(
                  context,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'รายละเอียดของงาน',
                        style: textheadStyle,
                      ),
                      if (order[0]["category"] == "Categories.CLEANING")
                        textData("ทำความสะอาดบ้าน")
                      else if (order[0]["category"] == "Categories.FURNITURE")
                        textData("ทำความสะอาดเฟอร์นิดจอร์")
                      else if (order[0]["category"] == "Categories.WASH")
                        textData("ซักผ้า"),
                      textData(order[0]["type"]),
                      textData(
                          DateFormat('วันที่ yyyy-MM-dd').format(dateTime)),
                      textData(DateFormat('เวลา kk:mm').format(dateTime)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: !booking
          ? FloatingActionButton(
              onPressed: () async {
                // await Provider.of<OrderProvider>(context, listen: false)
                //     .setStatusOrder(order[0]["_id"], StatusOrder.SUCCESS);

                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const ListPage()),
                // );
              },
              backgroundColor: Colors.green,
              child: const Icon(Icons.check),
            )
          : null,
    );
  }

  Container cardCustom(BuildContext context, Widget child) {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        ),
        child: child);
  }

  Text textData(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16),
    );
  }
}
