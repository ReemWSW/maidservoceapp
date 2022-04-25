import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maid/providers/order_provider.dart';
import 'package:provider/provider.dart';

import 'widgets/list_order.dart';
import 'widgets/review.dart';

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
            body: Consumer<OrderProvider>(
              builder: (context, order, child) {
                return const TabBarView(
                  children: <Widget>[
                    ListOrder(booking: true),
                    ListOrder(booking: false),
                    ReviewWidget()
                    // currentItem(true, order.waitOrder!)
                    // currentItem(false, order.acceptOrder!)
                    // reviewOrder(order.successOrder!)
                  ],
                );
              },
            )
            // TabBarView(children: [
            //   ListOrder(),
            //   const Icon(Icons.movie),
            //   const Icon(Icons.games),
            // ]),
            ));
  }
}
