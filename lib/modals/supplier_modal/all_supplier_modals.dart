


class GetAllSuppliers {
  String? status;
  bool? success;
  Data? data;

  GetAllSuppliers({this.status, this.success, this.data});

  GetAllSuppliers.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Docs>? docs;
  int? page;
  int? pages;
  int? docCount;

  Data({this.docs, this.page, this.pages, this.docCount});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['docs'] != null) {
      docs = <Docs>[];
      json['docs'].forEach((v) {
        docs!.add(Docs.fromJson(v));
      });
    }
    page = json['page'];
    pages = json['pages'];
    docCount = json['docCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (docs != null) {
      data['docs'] = docs!.map((v) => v.toJson()).toList();
    }
    data['page'] = page;
    data['pages'] = pages;
    data['docCount'] = docCount;
    return data;
  }
}

class Docs {
  String? sId;
  String? firstName;
  String? lastName;
  String? email;
  String? image;
  String? identityNumber;
  String? coverImage;
  String? phone;
  String? shipmentId;
  String? address;
  String? cityName;
  int? cityId;
  String? password;
  String? fcmToken;
  int? userType;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Docs(
      {this.sId,
        this.firstName,
        this.lastName,
        this.email,
        this.image,
        this.identityNumber,
        this.coverImage,
        this.phone,
        this.shipmentId,
        this.address,
        this.cityName,
        this.cityId,
        this.password,
        this.fcmToken,
        this.userType,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Docs.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    image = json['image'];
    identityNumber = json['identityNumber'];
    coverImage = json['coverImage'];
    phone = json['phone'];
    shipmentId = json['shipmentId'];
    address = json['address'];
    cityName = json['cityName'];
    cityId = json['cityId'];
    password = json['password'];
    fcmToken = json['fcmToken'];
    userType = json['userType'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['image'] = image;
    data['identityNumber'] = identityNumber;
    data['coverImage'] = coverImage;
    data['phone'] = phone;
    data['shipmentId'] = shipmentId;
    data['address'] = address;
    data['cityName'] = cityName;
    data['cityId'] = cityId;
    data['password'] = password;
    data['fcmToken'] = fcmToken;
    data['userType'] = userType;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
