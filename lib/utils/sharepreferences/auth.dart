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
    var address = user.address;
    if (address != null) {
      prefs.setString("amphure", address.amphure!);
      prefs.setString("province", address.province!);
      prefs.setString("tombon", address.tombon!);
    }
    if (user.category != null) prefs.setString("category", user.category!);

    return prefs.commit();
  }

  Future<bool> setMaid(
    bool maid,
    String province,
    String amphure,
    String tombon,
    String category,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool("maid", maid);
    prefs.setString("amphure", amphure);
    prefs.setString("province", province);
    prefs.setString("tombon", tombon);
    prefs.setString("category", category);

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
