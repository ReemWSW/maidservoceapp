// ignore_for_file: file_names

class User {
  String? id;
  String? image;
  String? email;
  String? name;
  String? password;
  String? phone;
  bool? maid;
  Address? address;
  String? category;
  String? token;

  User({
    this.id,
    this.image,
    this.email,
    this.name,
    this.password,
    this.phone,
    this.maid,
    this.address,
    this.category,
    this.token,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    email = json['email'];
    name = json['name'];
    password = json['password'];
    phone = json['phone'];
    maid = json['maid'];
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    token = json['category'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['email'] = email;
    data['name'] = name;
    data['password'] = password;
    data['phone'] = phone;
    data['maid'] = maid;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['category'] = token;
    data['token'] = token;
    return data;
  }
}

class Address {
  String? tombon;
  String? amphure;
  String? province;

  Address({this.tombon, this.amphure, this.province});

  Address.fromJson(Map<String, dynamic> json) {
    tombon = json['tombon'];
    amphure = json['amphure'];
    province = json['province'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tombon'] = tombon;
    data['amphure'] = amphure;
    data['province'] = province;
    return data;
  }
}
