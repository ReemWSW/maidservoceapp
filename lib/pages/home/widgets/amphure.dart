import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:flutter/services.dart';

class AmphureListScreen extends StatefulWidget {
  const AmphureListScreen({
    Key? key,
    required this.idpass,
  }) : super(key: key);

  final String idpass;

  @override
  _AmphureListScreenState createState() => _AmphureListScreenState();
}

class _AmphureListScreenState extends State<AmphureListScreen> {
  List data = [];

  List amphureFilter = [];

  Future<String> loadJsonData() async {
    var jsonText = await rootBundle.loadString('assets/json/amphures.json');
    setState(() {
      data = json.decode(jsonText);

      amphureFilter = data.where((element) {
        var province_id = int.parse(element["province_id"]);
        var idpass = int.parse(widget.idpass);

        return province_id == idpass;
      }).toList();
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
        title: const Text('อำเภอ/เขต'),
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          buildSearchContainer(),
          Expanded(
              child: ListView.builder(
                  itemCount: amphureFilter.isEmpty ? 0 : amphureFilter.length,
                  itemBuilder: (BuildContext context, int index) {
                    var name = amphureFilter[index]['name_th'];
                    var id_name = amphureFilter[index]['id'];
                    return Column(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.pop(context, [name, id_name]);
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
            decoration:
                const InputDecoration.collapsed(hintText: "อำเภอ/เขต.."),
            onChanged: search,
          )),
    );
  }

  void search(String query) {
    if (query.isEmpty) {
      setState(() {});
      return;
    }

    List result = [];
    for (var p in amphureFilter) {
      var name = p["name_th"].toString();
      if (name.contains(query)) {
        result.add(p);
      }
    }

    amphureFilter = result;
    setState(() {});
  }
}
