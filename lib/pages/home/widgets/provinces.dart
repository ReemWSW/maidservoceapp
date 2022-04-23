import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:flutter/services.dart';

class ProvincesListScreen extends StatefulWidget {
  const ProvincesListScreen({Key? key}) : super(key: key);

  @override
  _ProvincesListScreenState createState() => _ProvincesListScreenState();
}

class _ProvincesListScreenState extends State<ProvincesListScreen> {
  List? data;

  List? provincesFilter;

  Future<String> loadJsonData() async {
    var jsonText = await rootBundle.loadString('assets/json/provinces.json');
    setState(() {
      data = json.decode(jsonText);
      provincesFilter = json.decode(jsonText);
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
        backgroundColor: Colors.green,
        title: const Text('จังหวัด'),
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          buildSearchContainer(),
          Expanded(
              child: ListView.builder(
                  itemCount:
                      provincesFilter == null ? 0 : provincesFilter!.length,
                  itemBuilder: (BuildContext context, int index) {
                    var name = provincesFilter![index]['name_th'];
                    var id_name = provincesFilter![index]['id'];
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
      provincesFilter = data;
      setState(() {});
      return;
    }

    print(query);
    List result = [];
    for (var p in provincesFilter!) {
      var name = p["name_th"].toString();
      if (name.contains(query)) {
        result.add(p);
      }
    }

    provincesFilter = result;
    setState(() {});
  }
}
