class GetMyAddressModal {
  String? status;
  bool? success;
  Data? data;

  GetMyAddressModal({this.status, this.success, this.data});

  GetMyAddressModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Docs>? docs;

  Data({this.docs});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['docs'] != null) {
      docs = <Docs>[];
      json['docs'].forEach((v) {
        docs!.add(new Docs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.docs != null) {
      data['docs'] = this.docs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Docs {
  String? sId;
  User? user;
  String? phoneNo;
  String? houseNo;
  String? streetNo;
  String? block;
  String? nearestLandmark;
  String? city;
  String? cityId;
  String? area;
  String? customerName;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Docs(
      {this.sId,
        this.user,
        this.phoneNo,
        this.houseNo,
        this.streetNo,
        this.block,
        this.nearestLandmark,
        this.city,
        this.cityId,
        this.area,
        this.customerName,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Docs.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    phoneNo = json['phoneNo'];
    houseNo = json['houseNo'];
    streetNo = json['streetNo'];
    block = json['block'];
    nearestLandmark = json['nearestLandmark'];
    city = json['city'];
    cityId = json['cityId'];
    area = json['area'];
    customerName = json['customerName'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['phoneNo'] = this.phoneNo;
    data['houseNo'] = this.houseNo;
    data['streetNo'] = this.streetNo;
    data['block'] = this.block;
    data['nearestLandmark'] = this.nearestLandmark;
    data['city'] = this.city;
    data['cityId'] = this.cityId;
    data['area'] = this.area;
    data['customerName'] = this.customerName;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class User {
  String? sId;
  String? firstName;
  String? lastName;
  String? email;
  String? image;
  String? phone;
  int? userType;

  User(
      {this.sId,
        this.firstName,
        this.lastName,
        this.email,
        this.image,
        this.phone,
        this.userType});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    image = json['image'];
    phone = json['phone'];
    userType = json['userType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['image'] = this.image;
    data['phone'] = this.phone;
    data['userType'] = this.userType;
    return data;
  }
}
