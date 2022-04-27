import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maid/pages/list/widgets/container_image.dart';
import 'package:maid/providers/order_provider.dart';
import 'package:maid/widget/bottombar.dart';
import 'package:provider/provider.dart';

class ListInfoPage extends StatelessWidget {
  const ListInfoPage({
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

    print(index);

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
                      image: '${order[index]["customer"]["image"]}',
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
                      textData('${order[index]["customer"]["name"]}'),
                      textData(
                          'เบอร์โทรศัพท์ ${order[index]["customer"]["phone"]}'),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'สถานที่รับบริการ:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      textData(
                          'ที่อยู่ ${order[index]["address"]["detail"]} ตำบล ${order[index]["address"]["tombon"]} อำเภอ ${order[index]["address"]["amphure"]} จังหวัด ${order[index]["address"]["province"]}'),
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
                      if (order[index]["category"] == "Categories.CLEANING")
                        textData("ทำความสะอาดบ้าน")
                      else if (order[index]["category"] ==
                          "Categories.FURNITURE")
                        textData("ทำความสะอาดเฟอร์นิดจอร์")
                      else if (order[index]["category"] == "Categories.WASH")
                        textData("ซักผ้า"),
                      textData(order[index]["type"]),
                      textData(DateFormat('วันที่ yyyy-MM-dd')
                          .format(DateTime.parse(order[index]['datetime']))),
                      textData(DateFormat('เวลา kk:mm')
                          .format(DateTime.parse(order[index]['datetime']))),
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
                await Provider.of<OrderProvider>(context, listen: false)
                    .setStatusOrder(order[index]["_id"], 'EnumOrder.SUCCESS');

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomePage(page: 1)),
                );
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
