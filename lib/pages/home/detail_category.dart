import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class DetailCategoryPage extends StatefulWidget {
  const DetailCategoryPage({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;
  @override
  State<DetailCategoryPage> createState() => _DetailCategoryPageState();
}

class _DetailCategoryPageState extends State<DetailCategoryPage> {
  List data = [];
  List dataDetail = [];

  Future<String> loadJsonData() async {
    var jsonText = await rootBundle.loadString('assets/json/detail.json');
    setState(() {
      data = json.decode(jsonText);
      dataDetail = data[widget.index]['detail'];
      print(dataDetail);

      // for (var item in data) {
      //   // print(item['name']);
      //   // print(item['detail']);
      //   for (var item in item['detail']) {
      //     // print(item['head']);
      //     for (var item in item['type']) {
      //       print(item);
      //     }
      //   }
      // }
    });
    return 'success';
  }

  @override
  void initState() {
    loadJsonData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.index}"),
        // title: const Text('รายละเอียดบริการ'),
      ),
      body: ListView.builder(
        itemCount: dataDetail.isEmpty ? 0 : dataDetail.length,
        itemBuilder: (BuildContext context, int index) {
          var head = data[index]['head'];
          var type = data[index]['type'];

          return const ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.account_box),
            ),
            // title: Text(head),
            // subtitle: Text(type),
          );
        },
      ),
    );
  }
}
