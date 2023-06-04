


class GetSingleSupplier {
  String? status;
  bool? success;
  Data? data;

  GetSingleSupplier({this.status, this.success, this.data});

  GetSingleSupplier.fromJson(Map<String, dynamic> json) {
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
  Doc? doc;

  Data({this.doc});

  Data.fromJson(Map<String, dynamic> json) {
    doc = json['doc'] != null ? Doc.fromJson(json['doc']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (doc != null) {
      data['doc'] = doc!.toJson();
    }
    return data;
  }
}

class Doc {
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

  Doc(
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

  Doc.fromJson(Map<String, dynamic> json) {
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
