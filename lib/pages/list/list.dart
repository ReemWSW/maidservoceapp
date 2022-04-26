import 'package:flutter/material.dart';
import 'package:maid/providers/order_provider.dart';
import 'package:maid/utils/sharepreferences/auth.dart';
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
  String? _idCustomer;

  void fetchData() async {
    await UserPreferences().getUser().then((user) {
      _idCustomer = user.id;
    });
    await Provider.of<OrderProvider>(context, listen: false)
        .getorderCustomer(_idCustomer!, true);
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

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
                      .toList()),
            ),
            body: Consumer<OrderProvider>(
              builder: (context, order, child) {
                return TabBarView(
                  children: <Widget>[
                    ListOrder(
                      booking: true,
                      order: order.waitOrder!,
                    ),
                    ListOrder(
                      booking: false,
                      order: order.acceptOrder!,
                    ),
                    ReviewWidget(order: order.successOrder!)
                    // currentItem(true, order.waitOrder!)
                    // currentItem(false, order.acceptOrder!)
                    // reviewOrder(order.successOrder!)
                  ],
                );
              },
            )));
  }
}
