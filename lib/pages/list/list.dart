import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:maid/models/order.dart';
import 'package:maid/providers/order_provider.dart';
import 'package:maid/utils/sharepreferences/auth.dart';
import 'package:maid/widget/bottombar.dart';
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

  List? order;

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
                IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration.zero,
                          pageBuilder: (_, __, ___) => const HomePage(page: 1),
                        ),
                      );
                    },
                    icon: const Icon(Icons.refresh))
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
                const align = Align(
                    alignment: Alignment.center,
                    child: Text(
                      'ไม่มีข้อมูล',
                      style: TextStyle(fontSize: 25, color: Colors.grey),
                    ));
                if (order.loadingOrderStatus != StatusOrder.LOADING) {
                  return TabBarView(
                    children: <Widget>[
                      if (order.waitOrder!.isNotEmpty)
                        ListOrder(
                          booking: true,
                          order: order.waitOrder!,
                        )
                      else
                        align,
                      if (order.acceptOrder!.isNotEmpty)
                        ListOrder(
                          booking: false,
                          order: order.acceptOrder!,
                        )
                      else
                        align,
                      if (order.successOrder!.isNotEmpty)
                        ReviewWidget(order: order.successOrder!)
                      else
                        align,
                    ],
                  );
                } else {
                  return const Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator());
                }
              },
            )));
  }
}
