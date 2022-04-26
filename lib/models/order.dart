class Order {
  String? id;
  Customer? customer;
  Customer? maid;
  Address? address;
  String? categoty;
  String? type;
  String? detail;
  DateTime? datetime;
  String? status;
  int? score;

  Order({
    this.id,
    this.customer,
    this.maid,
    this.address,
    this.categoty,
    this.type,
    this.detail,
    this.datetime,
    this.status,
    this.score,
  });

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    maid = json['maid'] != null ? Customer.fromJson(json['maid']) : null;
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    categoty = json['categoty'];
    type = json['type'];
    detail = json['detail'];
    datetime = DateTime.tryParse(json['datetime']);
    status = json['status'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    if (maid != null) {
      data['maid'] = maid!.toJson();
    }
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['categoty'] = categoty;
    data['type'] = type;
    data['detail'] = detail;
    data['datetime'] = datetime;
    data['status'] = status;
    data['score'] = score;
    return data;
  }
}

class Customer {
  String? id;
  String? image;
  String? name;
  String? phone;

  Customer({this.image, this.name, this.phone});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['name'] = name;
    data['phone'] = phone;
    return data;
  }
}

class Address {
  String? detail;
  String? tombon;
  String? amphure;
  String? province;

  Address({this.detail, this.tombon, this.amphure, this.province});

  Address.fromJson(Map<String, dynamic> json) {
    detail = json['detail'];
    tombon = json['tombon'];
    amphure = json['amphure'];
    province = json['province'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['detail'] = detail;
    data['tombon'] = tombon;
    data['amphure'] = amphure;
    data['province'] = province;
    return data;
  }
}

enum EnumOrder {
  WAIT,
  ACCEPT,
  SUCCESS,
}
