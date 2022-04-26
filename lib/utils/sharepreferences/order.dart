// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:maid/models/order.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderPreferences {
  Future<bool> saveOrder(Order order) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("id", order.id!);
    prefs.setString("customerImage", order.customer!.image!);
    prefs.setString("customerName", order.customer!.name!);
    prefs.setString("customerPhone", order.customer!.phone!);
    prefs.setString("maidImage", order.maid!.image!);
    prefs.setString("maidName", order.maid!.name!);
    prefs.setString("maidPhone", order.maid!.phone!);
    prefs.setString("addressDetail", order.address!.detail!);
    prefs.setString("addressTombon", order.address!.tombon!);
    prefs.setString("addressAmphure", order.address!.amphure!);
    prefs.setString("addressProvince", order.address!.province!);
    prefs.setString("categoty", order.categoty!);
    prefs.setString("type", order.type!);
    prefs.setString("detail", order.detail!);
    prefs.setString("datetime", order.datetime.toString());
    prefs.setString("status", order.status!);

    return prefs.commit();
  }

  Future<Order> getOrder() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? id = prefs.getString("id");
    String? customerImage = prefs.getString("customerImage");
    String? customerName = prefs.getString("customerName");
    String? customerPhone = prefs.getString("customerPhone");
    String? maidImage = prefs.getString("maidImage");
    String? maidName = prefs.getString("maidName");
    String? maidPhone = prefs.getString("maidPhone");
    String? addressDetail = prefs.getString("addressDetail");
    String? addressTombon = prefs.getString("addressTombon");
    String? addressAmphure = prefs.getString("addressAmphure");
    String? addressProvince = prefs.getString("addressProvince");
    String? categoty = prefs.getString("categoty");
    String? type = prefs.getString("type");
    String? detail = prefs.getString("detail");
    String? datetime = prefs.getString("datetime");
    String? status = prefs.getString("status");

    var customer = Customer(
      image: customerImage,
      name: customerName,
      phone: customerPhone,
    );
    var maid = Customer(
      image: maidImage,
      name: maidName,
      phone: maidPhone,
    );
    var address = Address(
        detail: addressDetail,
        tombon: addressTombon,
        amphure: addressAmphure,
        province: addressProvince);

    return Order(
      id: id,
      customer: customer,
      maid: maid,
      address: address,
      categoty: categoty,
      type: type,
      detail: detail,
      datetime: DateTime.parse(datetime!),
      status: status,
    );
  }

  void removeOrder() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("id");
    prefs.remove("customerImage");
    prefs.remove("customerName");
    prefs.remove("customerPhone");
    prefs.remove("maidImage");
    prefs.remove("maidName");
    prefs.remove("maidPhone");
    prefs.remove("addressDetail");
    prefs.remove("addressTombon");
    prefs.remove("addressAmphure");
    prefs.remove("addressProvince");
    prefs.remove("categoty");
    prefs.remove("type");
    prefs.remove("detail");
    prefs.remove("datetime");
    prefs.remove("status");
  }
}
