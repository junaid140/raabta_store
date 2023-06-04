

class GetWishModals {
  String? status;
  bool? success;
  Data? data;

  GetWishModals({this.status, this.success, this.data});

  GetWishModals.fromJson(Map<String, dynamic> json) {
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
  String? page;
  int? pages;
  int? docCount;

  Data({this.docs, this.page, this.pages, this.docCount});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['docs'] != null) {
      docs = <Docs>[];
      json['docs'].forEach((v) {
        docs!.add(new Docs.fromJson(v));
      });
    }
    page = json['page'];
    pages = json['pages'];
    docCount = json['docCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.docs != null) {
      data['docs'] = this.docs!.map((v) => v.toJson()).toList();
    }
    data['page'] = this.page;
    data['pages'] = this.pages;
    data['docCount'] = this.docCount;
    return data;
  }
}

class Docs {
  String? sId;
  Product? product;
  User? user;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Docs(
      {this.sId,
        this.product,
        this.user,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Docs.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Product {
  String? sId;
  String? name;
  String? description;
  int? price;
  String? unit;
  Owner? owner;
  int? stock;
  Category? category;
  SubCategory? subCategory;
  List<Attributes>? attributes;
  List<String>? images;
  int? ratingsAvg;
  int? ratingsCount;
  int? status;
  String? createdAt;
  String? updatedAt;

  Product(
      {this.sId,
        this.name,
        this.description,
        this.price,
        this.unit,
        this.owner,
        this.stock,
        this.category,
        this.subCategory,
        this.attributes,
        this.images,
        this.ratingsAvg,
        this.ratingsCount,
        this.status,
        this.createdAt,
        this.updatedAt});

  Product.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    unit = json['unit'];
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    stock = json['stock'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    subCategory = json['subCategory'] != null
        ? new SubCategory.fromJson(json['subCategory'])
        : null;
    if (json['attributes'] != null) {
      attributes = <Attributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(new Attributes.fromJson(v));
      });
    }
    images = json['images'].cast<String>();
    ratingsAvg = json['ratingsAvg'];
    ratingsCount = json['ratingsCount'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['unit'] = this.unit;
    if (this.owner != null) {
      data['owner'] = this.owner!.toJson();
    }
    data['stock'] = this.stock;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.subCategory != null) {
      data['subCategory'] = this.subCategory!.toJson();
    }
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.map((v) => v.toJson()).toList();
    }
    data['images'] = this.images;
    data['ratingsAvg'] = this.ratingsAvg;
    data['ratingsCount'] = this.ratingsCount;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Owner {
  String? sId;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? shipmentId;
  int? userType;

  Owner(
      {this.sId,
        this.firstName,
        this.lastName,
        this.email,
        this.phone,
        this.shipmentId,
        this.userType});

  Owner.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phone = json['phone'];
    shipmentId = json['shipmentId'];
    userType = json['userType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['shipmentId'] = this.shipmentId;
    data['userType'] = this.userType;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
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
        ? new Category.fromJson(json['mainCategory'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    if (this.mainCategory != null) {
      data['mainCategory'] = this.mainCategory!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['label'] = this.label;
    data['name'] = this.name;
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

  User(
      {this.sId,
        this.firstName,
        this.lastName,
        this.email,
        this.image,
        this.phone});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    image = json['image'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['image'] = this.image;
    data['phone'] = this.phone;
    return data;
  }
}
