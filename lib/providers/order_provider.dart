import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:maid/models/order.dart';
import 'package:maid/utils/app_url.dart';

enum StatusOrder {
  IDLE,
  LOADING,
  SUCCESS,
  FAIL,
}

class OrderProvider with ChangeNotifier {
  StatusOrder _loadingOrderStatus = StatusOrder.IDLE;

  StatusOrder get loadingOrderStatus => _loadingOrderStatus;

  Future<Map<String, dynamic>> order(
    String customerId,
    String customerImage,
    String customerName,
    String customerPhone,
    String addressDetail,
    String addressTombon,
    String addressAmphure,
    String addressProvince,
    String detail,
    DateTime selectedDate,
    String category,
    String typeSelected,
  ) async {
    var result;

    final Map<String, dynamic> orderData = {
      "customer": {
        "id": customerId,
        "image": customerImage,
        "name": customerName,
        "phone": customerPhone,
      },
      "address": {
        "detail": addressDetail,
        "tombon": addressTombon,
        "amphure": addressAmphure,
        "province": addressProvince
      },
      "categoty": category,
      "type": typeSelected,
      "detail": detail,
      "datetime": "$selectedDate",
      "status": "${EnumOrder.WAIT}",
    };

    _loadingOrderStatus = StatusOrder.LOADING;
    notifyListeners();

    Response response = await post(
      Uri.parse(AppUrl.orderPost),
      body: json.encode(orderData),
      headers: {'Content-Type': 'application/json'},
    );

    final Map<String, dynamic> responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      var orderData = responseData['data'];

      Order order = Order.fromJson(orderData);
      result = {'status': true, 'message': 'Successful', 'user': order};

      _loadingOrderStatus = StatusOrder.SUCCESS;
      notifyListeners();
    } else {
      _loadingOrderStatus = StatusOrder.FAIL;
      notifyListeners();
      result = {
        'status': false,
        'message': responseData['message'],
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> getorderCustomer(String id) async {
    var result;

    final Map<String, dynamic> orderData = {
      "id": id,
    };

    _loadingOrderStatus = StatusOrder.LOADING;
    notifyListeners();

    Response response = await post(
      Uri.parse(AppUrl.getorder),
      body: json.encode(orderData),
      headers: {'Content-Type': 'application/json'},
    );

    final Map<String, dynamic> responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      var orderData = responseData['data'];

      Order order = Order.fromJson(orderData);
      result = {'status': true, 'message': 'Successful', 'orders': order};

      _loadingOrderStatus = StatusOrder.SUCCESS;
      notifyListeners();
    } else {
      _loadingOrderStatus = StatusOrder.FAIL;
      notifyListeners();
      result = {
        'status': false,
        'message': responseData['message'],
      };
    }
    return result;
  }
}
