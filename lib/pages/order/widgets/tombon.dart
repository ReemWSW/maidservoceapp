import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:flutter/services.dart';

class TombonsListScreen extends StatefulWidget {
  const TombonsListScreen({
    Key? key,
    required this.idpass,
  }) : super(key: key);

  final String idpass;

  @override
  _TombonsListScreenState createState() => _TombonsListScreenState();
}

class _TombonsListScreenState extends State<TombonsListScreen> {
  List data = [];

  List? tombonsFilter;

  Future<String> loadJsonData() async {
    var jsonText = await rootBundle.loadString('assets/json/tombons.json');
    setState(() {
      data = json.decode(jsonText);

      tombonsFilter = data.where((element) {
        var province_id = int.parse(element["id"].substring(0, 4));
        var idpass = int.parse(widget.idpass);

        return province_id == idpass;
      }).toList();
    });
    print(widget.idpass);
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
        backgroundColor: Colors.green,
        title: const Text('ตำบล'),
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          buildSearchContainer(),
          Expanded(
              child: ListView.builder(
                  itemCount: tombonsFilter == null ? 0 : tombonsFilter!.length,
                  itemBuilder: (BuildContext context, int index) {
                    var name = tombonsFilter![index]['name_th'];
                    var id_name = tombonsFilter![index]['id'];
                    return Column(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.pop(context, [name, id_name]);
                            print(id_name);
                          },
                          child: ListTile(title: Text(name)),
                        ),
                        const Divider(),
                      ],
                    );
                  })),
        ],
      ),
    );
  }

  Widget buildSearchContainer() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.green,
      ),
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
      child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: TextField(
            decoration: const InputDecoration.collapsed(hintText: "จังหวัด.."),
            onChanged: search,
          )),
    );
  }

  void search(String query) {
    if (query.isEmpty) {
      tombonsFilter = data;
      setState(() {});
      return;
    }

    print(query);
    List result = [];
    for (var p in tombonsFilter!) {
      var name = p["name_th"].toString();
      if (name.contains(query)) {
        result.add(p);
      }
    }

    tombonsFilter = result;
    setState(() {});
  }
}
