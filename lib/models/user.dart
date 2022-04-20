// ignore_for_file: file_names

class User {
  String? userid;
  String? image;
  String? email;
  String? name;
  String? password;
  String? phone;
  bool? maid;
  String? token;

  User({
    this.userid,
    this.image,
    this.email,
    this.name,
    this.password,
    this.phone,
    this.maid,
    this.token,
  });

  User.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    image = json['image'];
    email = json['email'];
    name = json['name'];
    password = json['password'];
    phone = json['phone'];
    maid = json['maid'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userid'] = userid;
    data['image'] = image;
    data['email'] = email;
    data['name'] = name;
    data['password'] = password;
    data['phone'] = phone;
    data['maid'] = maid;
    data['token'] = token;
    return data;
  }
}
