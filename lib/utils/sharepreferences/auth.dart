// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:maid/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("id", user.id!);
    prefs.setString("image", user.image!);
    prefs.setString("name", user.name!);
    prefs.setString("email", user.email!);
    prefs.setString("phone", user.phone!);
    prefs.setString("token", user.token!);
    prefs.setBool("maid", user.maid!);
    if (user.address != null) {
      prefs.setString("province", user.address!.province!);
      prefs.setString("tombon", user.address!.tombon!);
      prefs.setString("amphure", user.address!.amphure!);
    }
    if (user.category != null) prefs.setString("category", user.category!);
    if (user.datetime != null) {
      prefs.setString("datetime", user.datetime.toString());
    }

    return prefs.commit();
  }

  Future<bool> setMaid(
    bool maid,
    String province,
    String amphure,
    String tombon,
    String category,
    DateTime datetime,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool("maid", maid);
    prefs.setString("amphure", amphure);
    prefs.setString("province", province);
    prefs.setString("tombon", tombon);
    prefs.setString("category", category);

    prefs.setString("datetime", datetime.toString());

    return prefs.commit();
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userid = prefs.getString("id");
    String? image = prefs.getString("image");
    String? name = prefs.getString("name");
    String? email = prefs.getString("email");
    String? phone = prefs.getString("phone");
    bool? maid = prefs.getBool("maid");
    String? amphure = prefs.getString("amphure");
    String? province = prefs.getString("province");
    String? tombon = prefs.getString("tombon");
    String? category = prefs.getString("category");
    String? datetime = prefs.getString("datetime");
    String? token = prefs.getString("token");

    var address = Address(tombon: tombon, amphure: amphure, province: province);

    return User(
      id: userid,
      image: image,
      name: name,
      email: email,
      phone: phone,
      maid: maid,
      address: address,
      category: category,
      datetime: DateTime.tryParse(datetime!),
      token: token,
    );
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("userid");
    prefs.remove("image");
    prefs.remove("name");
    prefs.remove("email");
    prefs.remove("phone");
    prefs.remove("maid");
    prefs.remove("token");
  }

  Future<String?> getToken(args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    return token;
  }
}
