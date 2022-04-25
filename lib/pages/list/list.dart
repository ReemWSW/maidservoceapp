import 'package:flutter/material.dart';

class ListPage extends StatelessWidget {
  ListPage({
    Key? key,
  }) : super(key: key);
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
          body: const TabBarView(children: [
            Icon(Icons.apps),
            Icon(Icons.movie),
            Icon(Icons.games),
          ]),
        ));
  }
}
