import 'package:flutter/material.dart';

class ReviewWork extends StatelessWidget {
  const ReviewWork({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.all(8),
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
                    children: const [
                      Text("order[0]['customer']['name']"),
                    ],
                  ),
                  subtitle: const Text('วันที่ yyyy-MM-dd เวลา kk:mm'),
                  trailing: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text("{order[0]['score']}"),
                  ),
                  isThreeLine: true,
                ),
              ],
            ),
          );
        });
  }
}
