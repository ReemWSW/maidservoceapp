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
  List<dynamic>? waitOrder;
  List<dynamic>? acceptOrder;
  List<dynamic>? successOrder;
  List<dynamic>? customer;

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

  Future<Map<String, dynamic>> getorderCustomer(
      String id, bool customer) async {
    var result;

    final Map<String, dynamic> orderData = {"id": id, "customer": customer};

    _loadingOrderStatus = StatusOrder.LOADING;
    notifyListeners();

    Response response = await post(
      Uri.parse(AppUrl.getorder),
      body: json.encode(orderData),
      headers: {'Content-Type': 'application/json'},
    );

    final Map<String, dynamic> responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      var orderData = responseData;
      result = {
        'status': true,
        'message': orderData['message'],
        'order': orderData['data']
      };
      waitOrder = result['order']['waitOrder'];
      acceptOrder = result['order']['acceptOrder'];
      successOrder = result['order']['successOrder'];

      _loadingOrderStatus = StatusOrder.SUCCESS;
      notifyListeners();
    } else {
      result = {
        'status': false,
        'message': responseData['message'],
      };
      _loadingOrderStatus = StatusOrder.FAIL;
      notifyListeners();
    }
    return result;
  }

  Future setStatusOrder(String order, String status) async {
    final Map<String, dynamic> orderData = {
      'order': order,
      'status': status,
    };

    var uri = AppUrl.setStatusOrder;
    // print(uri);
    Response response = await post(
      Uri.parse(uri),
      body: json.encode(orderData),
      headers: {'Content-Type': 'application/json'},
    );
    // print(response.body);

    final Map<String, dynamic> responseData = json.decode(response.body);
    var result;
    if (response.statusCode == 200) {
      var orderData = responseData['data'];
      result = {'status': true, 'message': 'Successful', 'order': orderData};

      if (result["order"]["status"] == 'StatusOrder.ACCEPT') {
        for (var item in waitOrder!) {
          if (item["_id"] == result["order"]["_id"]) {
            acceptOrder!.add(item);
            waitOrder!.remove(item);
            notifyListeners();
          }
        }
      } else if (result["order"]["status"] == 'StatusOrder.SUCCESS') {
        for (var item in waitOrder!) {
          if (item["_id"] == result["order"]["_id"]) {
            successOrder!.add(item);
            acceptOrder!.remove(item);
            notifyListeners();
          }
        }
      }
      print(result["order"]["_id"]);
    } else {
      result = {
        'status': false,
        'message': responseData['message'],
      };
    }
    notifyListeners();
  }

  Future setScoreOrder(String order, int score) async {
    final Map<String, dynamic> orderData = {
      'order': order,
      'score': score,
    };

    var uri = AppUrl.setScoreOrder;
    // print(uri);
    Response response = await post(
      Uri.parse(uri),
      body: json.encode(orderData),
      headers: {'Content-Type': 'application/json'},
    );
    // print(response.body);

    final Map<String, dynamic> responseData = json.decode(response.body);
    var result;
    if (response.statusCode == 200) {
      var orderData = responseData['data'];
      for (var item in successOrder!) {
        if (item["_id"] == orderData["_id"]) {
          item["score"] = orderData["score"];
          notifyListeners();
        }
      }

      result = {
        'status': true,
        'message': responseData['message'],
        'order': orderData
      };
    } else {
      result = {
        'status': false,
        'message': responseData['message'],
      };
    }
  }
}
