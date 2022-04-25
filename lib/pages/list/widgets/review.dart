import 'package:flutter/material.dart';

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 2,
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
                    children: const [
                      Text("{order[index]['customer']['name']}"),
                      Text("{order[index]['customer']['phone']}"),
                    ],
                  ),
                  subtitle: const Text('DateFormat'),
                  isThreeLine: true,
                  // trailing: order[index]['score'] != 0
                  //     ? CircleAvatar(
                  //         backgroundColor: Colors.white,
                  //         child: Text("${order[0]["score"]}"),
                  //       )
                  //     : ElevatedButton(
                  //         onPressed: () {
                  //           showDialog<String>(
                  //             context: context,
                  //             builder:
                  //                 (BuildContext context) =>
                  //                     AlertDialog(
                  //               title: const Text('คะแนน'),
                  //               content: Row(
                  //                   children:
                  //                       List.generate(
                  //                               6,
                  //                               (int index) =>
                  //                                   index++)
                  //                           .map(
                  //                               (score) =>
                  //                                   Flexible(
                  //                                     flex: 1,
                  //                                     fit: FlexFit
                  //                                         .loose,
                  //                                     child:
                  //                                         Container(
                  //                                       margin:
                  //                                           const EdgeInsets.all(6),
                  //                                       child: ElevatedButton(
                  //                                           onPressed: () {
                  //                                             setState(() {
                  //                                               Provider.of<OrderProvider>(context, listen: false).setScoreOrder(order[0]["_id"], score);
                  //                                               Navigator.pop(context);
                  //                                             });
                  //                                           },
                  //                                           child: Text('$score')),
                  //                                     ),
                  //                                   ))
                  //                           .toList()),
                  //             ),
                  //           );
                  //         },
                  // child: Text(order[index]['score'] ==
                  //         0
                  //     ? 'ให้คะแนน'
                  //     : '${order[index]['score']}'))
                ),
              ],
            ),
          );
        });
  }
}
