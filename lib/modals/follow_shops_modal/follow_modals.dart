
class FollowShopModal {
  String? status;
  bool? success;
  Data? data;

  FollowShopModal({this.status, this.success, this.data});

  FollowShopModal.fromJson(Map<String, dynamic> json) {
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
  String? follower;
  String? supplier;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Doc(
      {this.follower,
        this.supplier,
        this.sId,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Doc.fromJson(Map<String, dynamic> json) {
    follower = json['follower'];
    supplier = json['supplier'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['follower'] = follower;
    data['supplier'] = supplier;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
