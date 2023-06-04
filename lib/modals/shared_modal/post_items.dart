class PostSharedItemModal {
  String? status;
  bool? success;
  Data? data;

  PostSharedItemModal({this.status, this.success, this.data});

  PostSharedItemModal.fromJson(Map<String, dynamic> json) {
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
  String? product;
  String? user;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Doc(
      {this.product,
        this.user,
        this.sId,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Doc.fromJson(Map<String, dynamic> json) {
    product = json['product'];
    user = json['user'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product'] = product;
    data['user'] = user;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
