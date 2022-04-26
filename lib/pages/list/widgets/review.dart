import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maid/providers/order_provider.dart';
import 'package:provider/provider.dart';

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({
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
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(8),
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
                    isThreeLine: true,
                    trailing: order[index]['score'] != 0
                        ? CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Text("${order[0]["score"]}"),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              generateScore(context, index);
                            },
                            child: Text(order[index]['score'] == 0
                                ? 'ให้คะแนน'
                                : '${order[index]['score']}'))),
              ],
            ),
          );
        });
  }

  Future<String?> generateScore(BuildContext context, int index) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('คะแนน'),
        content: Row(
            children: List.generate(6, (int index) => index++)
                .map((score) => Flexible(
                      flex: 1,
                      fit: FlexFit.loose,
                      child: Container(
                        margin: const EdgeInsets.all(6),
                        child: ElevatedButton(
                            onPressed: () {
                              Provider.of<OrderProvider>(context, listen: false)
                                  .setScoreOrder(order[index]["_id"], score);
                              Navigator.pop(context);
                            },
                            child: Text('$score')),
                      ),
                    ))
                .toList()),
      ),
    );
  }
}
