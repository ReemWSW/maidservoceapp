// ignore_for_file: file_names

class User {
  String? image;
  String? email;
  String? name;
  String? password;
  String? phone;
  bool? maid;

  User(
      {this.image,
      this.email,
      this.name,
      this.password,
      this.phone,
      this.maid});

  User.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    email = json['email'];
    name = json['name'];
    password = json['password'];
    phone = json['phone'];
    maid = json['maid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['email'] = email;
    data['name'] = name;
    data['password'] = password;
    data['phone'] = phone;
    data['maid'] = maid;
    return data;
  }
}
