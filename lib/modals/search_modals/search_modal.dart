


class SearchModal {
  String? status;
  bool? success;
  Data? data;

  SearchModal({this.status, this.success, this.data});

  SearchModal.fromJson(Map<String, dynamic> json) {
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
  int? pages;
  int? page;

  Data({this.docs, this.docCount, this.pages, this.page});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['docs'] != null) {
      docs = <Docs>[];
      json['docs'].forEach((v) {
        docs!.add(Docs.fromJson(v));
      });
    }
    docCount = json['docCount'];
    pages = json['pages'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (docs != null) {
      data['docs'] = docs!.map((v) => v.toJson()).toList();
    }
    data['docCount'] = docCount;
    data['pages'] = pages;
    data['page'] = page;
    return data;
  }
}

class Docs {
  String? sId;
  String? name;
  String? description;
  int? price;
  String? unit;
  int? discount;
  Owner? owner;
  String? discountType;
  int? stock;
  Category? category;
  SubCategory? subCategory;
  List<Attributes>? attributes;
  List<String>? images;
  num? ratingsAvg;
  int? ratingsCount;
  int? status;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Docs(
      {this.sId,
        this.name,
        this.description,
        this.price,
        this.unit,
        this.discount,
        this.owner,
        this.discountType,
        this.stock,
        this.category,
        this.subCategory,
        this.attributes,
        this.images,
        this.ratingsAvg,
        this.ratingsCount,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Docs.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    unit = json['unit'];
    discount = json['discount'];
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    discountType = json['discountType'];
    stock = json['stock'];
    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;
    subCategory = json['subCategory'] != null
        ? SubCategory.fromJson(json['subCategory'])
        : null;
    if (json['attributes'] != null) {
      attributes = <Attributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(Attributes.fromJson(v));
      });
    }
    images = json['images'].cast<String>();
    ratingsAvg = json['ratingsAvg'];
    ratingsCount = json['ratingsCount'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['unit'] = unit;
    data['discount'] = discount;
    if (owner != null) {
      data['owner'] = owner!.toJson();
    }
    data['discountType'] = discountType;
    data['stock'] = stock;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (subCategory != null) {
      data['subCategory'] = subCategory!.toJson();
    }
    if (attributes != null) {
      data['attributes'] = attributes!.map((v) => v.toJson()).toList();
    }
    data['images'] = images;
    data['ratingsAvg'] = ratingsAvg;
    data['ratingsCount'] = ratingsCount;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Owner {
  String? sId;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  int? userType;

  Owner(
      {this.sId,
        this.firstName,
        this.lastName,
        this.email,
        this.phone,
        this.userType});

  Owner.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phone = json['phone'];
    userType = json['userType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['userType'] = userType;
    return data;
  }
}

class Category {
  String? sId;
  String? name;

  Category({this.sId, this.name});

  Category.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    return data;
  }
}

class SubCategory {
  String? sId;
  String? name;
  Category? mainCategory;

  SubCategory({this.sId, this.name, this.mainCategory});

  SubCategory.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    mainCategory = json['mainCategory'] != null
        ? Category.fromJson(json['mainCategory'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    if (mainCategory != null) {
      data['mainCategory'] = mainCategory!.toJson();
    }
    return data;
  }
}

class Attributes {
  String? value;
  String? label;
  String? name;

  Attributes({this.value, this.label, this.name});

  Attributes.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    label = json['label'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['label'] = label;
    data['name'] = name;
    return data;
  }
}
