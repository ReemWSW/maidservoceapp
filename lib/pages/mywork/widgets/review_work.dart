import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReviewWork extends StatelessWidget {
  const ReviewWork({
    Key? key,
    required this.order,
  }) : super(key: key);

  final List order;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: order.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.people),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${order[index]['customer']['name']}"),
                      Text("${order[index]['customer']['phone']}"),
                    ],
                  ),
                  subtitle: Text(DateFormat('วันที่ yyyy-MM-dd เวลา kk:mm')
                      .format(DateTime.parse(order[index]['datetime']))),
                  trailing: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text("${order[index]['score']}"),
                  ),
                  isThreeLine: true,
                ),
              ],
            ),
          );
        });
  }
}
