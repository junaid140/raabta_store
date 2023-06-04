


class PostAddressModal {
  String? status;
  bool? success;
  Data? data;

  PostAddressModal({this.status, this.success, this.data});

  PostAddressModal.fromJson(Map<String, dynamic> json) {
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
  String? message;
  Doc? doc;

  Data({this.message, this.doc});

  Data.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    doc = json['doc'] != null ? Doc.fromJson(json['doc']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (doc != null) {
      data['doc'] = doc!.toJson();
    }
    return data;
  }
}

class Doc {
  String? user;
  String? phoneNo;
  String? houseNo;
  String? streetNo;
  String? block;
  String? nearestLandmark;
  String? city;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Doc(
      {this.user,
        this.phoneNo,
        this.houseNo,
        this.streetNo,
        this.block,
        this.nearestLandmark,
        this.city,
        this.sId,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Doc.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    phoneNo = json['phoneNo'];
    houseNo = json['houseNo'];
    streetNo = json['streetNo'];
    block = json['block'];
    nearestLandmark = json['nearestLandmark'];
    city = json['city'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = user;
    data['phoneNo'] = phoneNo;
    data['houseNo'] = houseNo;
    data['streetNo'] = streetNo;
    data['block'] = block;
    data['nearestLandmark'] = nearestLandmark;
    data['city'] = city;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
