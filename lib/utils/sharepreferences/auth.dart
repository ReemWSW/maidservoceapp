// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:maid/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("userId", user.userid!);
    prefs.setString("image", user.image!);
    prefs.setString("name", user.name!);
    prefs.setString("email", user.email!);
    prefs.setString("phone", user.phone!);
    prefs.setString("token", user.token!);
    prefs.setBool("maid", user.maid!);

    return prefs.commit();
  }

  Future<bool> setMaid(bool maid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool("maid", maid);

    return prefs.commit();
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userid = prefs.getString("userid");
    String? image = prefs.getString("image");
    String? name = prefs.getString("name");
    String? email = prefs.getString("email");
    String? phone = prefs.getString("phone");
    bool? maid = prefs.getBool("maid");
    String? token = prefs.getString("token");

    return User(
      userid: userid,
      image: image,
      name: name,
      email: email,
      phone: phone,
      maid: maid,
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
