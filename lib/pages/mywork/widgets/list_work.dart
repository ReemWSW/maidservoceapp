import 'package:flutter/material.dart';

class ListWork extends StatelessWidget {
  const ListWork({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 2,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              // print(order[index]['customer']);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => JobInfo(
              //             order: order[index],
              //             booking: booking,
              //           )),
              // );
            },
            child: Container(
              padding: const EdgeInsets.only(top: 10),
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
                  children: const [
                    Text("{order[index]['customer']['name']}"),
                    Text("{order[index]['customer']['phone']}"),
                  ],
                ),
                subtitle: const Text('DateFormat'),
                isThreeLine: true,
              ),
            ),
          );
        });
  }
}
