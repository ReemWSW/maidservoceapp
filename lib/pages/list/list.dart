import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListPage extends StatefulWidget {
  const ListPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<String> name = ['รายการปัจจุบัน', 'รายการที่ผ่าน', 'รีวิว'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.green,
            elevation: 0,
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.refresh))
            ],
            bottom: TabBar(
              labelColor: Colors.green,
              unselectedLabelColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  color: Colors.white),
              tabs: name
                  .map((label) => Tab(
                      child: Align(
                          alignment: Alignment.center, child: Text(label))))
                  .toList(),
            ),
          ),
          body: TabBarView(children: [
            // Icon(Icons.apps),
            ListView.builder(
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
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
                );
              },
            ),
            const Icon(Icons.movie),
            const Icon(Icons.games),
          ]),
        ));
  }
}
