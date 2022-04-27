import 'package:flutter/material.dart';
import 'package:maid/providers/order_provider.dart';
import 'package:maid/utils/sharepreferences/auth.dart';
import 'package:maid/widget/bottombar.dart';
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
  String? _idMaid, _tombon;
  bool? _maid;

  void fetchData() async {
    await UserPreferences().getUser().then((user) {
      _idMaid = user.id;
      _maid = user.maid;
      _tombon = user.address!.tombon;
    });
    await Provider.of<OrderProvider>(context, listen: false)
        .getorderCustomer(_idMaid!, false, _tombon!);
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
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration.zero,
                        pageBuilder: (_, __, ___) => const HomePage(page: 2),
                      ),
                    );
                  },
                  icon: const Icon(Icons.refresh))
            ],
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
                if (_maid == true) {
                  return TabBarView(children: [
                    if (order.waitOrder!.isNotEmpty)
                      ListWork(
                        booking: true,
                        order: order.waitOrder!,
                      )
                    else
                      align,
                    if (order.acceptOrder!.isNotEmpty)
                      ListWork(
                        booking: true,
                        order: order.acceptOrder!,
                      )
                    else
                      align,
                    if (order.successOrder!.isNotEmpty)
                      ReviewWork(order: order.successOrder!)
                    else
                      align,
                  ]);
                } else {
                  return const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'กรุณาสมัครแม่บ้าน',
                      style: TextStyle(fontSize: 25, color: Colors.grey),
                    ),
                  );
                }
              } else {
                return const Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator());
              }
            },
          ),
        ));
  }
}
