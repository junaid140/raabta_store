class GetFollowedShopModal {
  String? status;
  bool? success;
  Data? data;

  GetFollowedShopModal({this.status, this.success, this.data});

  GetFollowedShopModal.fromJson(Map<String, dynamic> json) {
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
  int? docCount;
  String? page;
  int? pages;

  Data({this.docs, this.docCount, this.page, this.pages});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['docs'] != null) {
      docs = <Docs>[];
      json['docs'].forEach((v) {
        docs!.add(Docs.fromJson(v));
      });
    }
    docCount = json['docCount'];
    page = json['page'];
    pages = json['pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (docs != null) {
      data['docs'] = docs!.map((v) => v.toJson()).toList();
    }
    data['docCount'] = docCount;
    data['page'] = page;
    data['pages'] = pages;
    return data;
  }
}

class Docs {
  String? sId;
  Follower? follower;
  Supplier? supplier;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Docs(
      {this.sId,
        this.follower,
        this.supplier,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Docs.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    follower = json['follower'] != null
        ? Follower.fromJson(json['follower'])
        : null;
    supplier = json['supplier'] != null
        ? Supplier.fromJson(json['supplier'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (follower != null) {
      data['follower'] = follower!.toJson();
    }
    if (supplier != null) {
      data['supplier'] = supplier!.toJson();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Follower {
  String? sId;
  String? firstName;
  String? lastName;
  String? email;
  String? image;
  String? phone;

  Follower(
      {this.sId,
        this.firstName,
        this.lastName,
        this.email,
        this.image,
        this.phone});

  Follower.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    image = json['image'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['image'] = image;
    data['phone'] = phone;
    return data;
  }
}

class Supplier {
  String? sId;
  String? firstName;
  String? lastName;
  String? email;
  String? image;
  String? phone;

  Supplier(
      {this.sId,
        this.firstName,
        this.lastName,
        this.email,
        this.image,
        this.phone});

  Supplier.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    image = json['image'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['image'] = image;
    data['phone'] = phone;
    return data;
  }
}
