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

  String? name;

  Future<String> loadJsonData() async {
    var jsonText = await rootBundle.loadString('assets/json/detail.json');
    setState(() {
      data = json.decode(jsonText);
      dataDetail = data[widget.index]['detail'];
      name = data[widget.index]["name"];
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
    return FutureBuilder<String>(
        future: loadJsonData(),
        builder: (
          BuildContext context,
          AsyncSnapshot<String> snapshot,
        ) {
          return Scaffold(
            appBar: AppBar(
              title: Text("$name"),
              // title: const Text('รายละเอียดบริการ'),
            ),
            body: ListView.builder(
              itemCount: dataDetail.isEmpty ? 0 : dataDetail.length,
              itemBuilder: (BuildContext context, int index) {
                return cardList(dataDetail, index, context);
              },
            ),
          );
        });
  }

  Widget cardList(List detail, int indexde, BuildContext context) {
    return Column(
      children: [
        Container(
            height: 150,
            margin: const EdgeInsets.all(16),
            child: ListView.builder(
              itemCount: detail[indexde]['type'].length,
              itemBuilder: (context, index) => Text(
                detail[indexde]['type'][index],
                style: TextStyle(
                  color: index == 0 ? Colors.red : Colors.black,
                ),
              ),
            )

            // ListView(
            //   children: [
            //     Text(
            //       "${detail[index]['head']}",
            //       style: const TextStyle(color: Colors.red),
            //     ),
            //     for (int i = 0; i < detail[index]['type'].length; i++)
            //       Text(detail[index]['type'][i])
            //   ],
            // ),
            ),
        const Divider(
          color: Colors.black,
        )
      ],
    );
  }
}
