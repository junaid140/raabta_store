class UpdateAddressModal {
  String? status;
  bool? success;
  Data? data;

  UpdateAddressModal({this.status, this.success, this.data});

  UpdateAddressModal.fromJson(Map<String, dynamic> json) {
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
  String? message;
  Doc? doc;

  Data({this.message, this.doc});

  Data.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    doc = json['doc'] != null ? new Doc.fromJson(json['doc']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.doc != null) {
      data['doc'] = this.doc!.toJson();
    }
    return data;
  }
}

class Doc {
  String? sId;
  String? user;
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

  Doc(
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

  Doc.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'];
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
    data['user'] = this.user;
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
