import 'package:flutter/material.dart';
import 'package:maid/providers/order_provider.dart';
import 'package:maid/utils/sharepreferences/auth.dart';
import 'package:provider/provider.dart';

import 'widgets/list_work.dart';
import 'widgets/review_work.dart';

class MyWorkPage extends StatefulWidget {
  const MyWorkPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyWorkPage> createState() => _MyWorkPageState();
}

class _MyWorkPageState extends State<MyWorkPage> {
  List<String> name = ['รับงาน', 'รับงานแล้ว', 'รีวิว'];
  String? _idMaid;

  void fetchData() async {
    await UserPreferences().getUser().then((user) {
      _idMaid = user.id;
    });
    await Provider.of<OrderProvider>(context, listen: false)
        .getorderCustomer(_idMaid!, false);
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
          body: Consumer<OrderProvider>(builder: (context, order, child) {
            return TabBarView(children: [
              ListWork(
                booking: true,
                order: order.waitOrder!,
              ),
              ListWork(
                booking: true,
                order: order.acceptOrder!,
              ),
              ReviewWork(order: order.successOrder!),
            ]);
          }),
        ));
  }
}
