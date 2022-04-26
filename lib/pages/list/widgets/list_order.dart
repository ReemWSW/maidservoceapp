import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListOrder extends StatelessWidget {
  const ListOrder({
    Key? key,
    required this.booking,
    required this.order,
  }) : super(key: key);

  final bool? booking;
  final List? order;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: order!.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 6.0,
                ),
              ],
            ),
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.people),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${order![index]['customer']['name']}"),
                  Text("${order![index]['customer']['phone']}"),
                ],
              ),
              subtitle: Text(DateFormat('วันที่ yyyy-MM-dd เวลา kk:mm')
                  .format(DateTime.parse(order![index]['datetime']))),
              isThreeLine: true,
            ),
          ),
        );
      },
    );
  }
}
