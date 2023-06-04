


class GetSupplierProducts {
  GetSupplierProducts({
    String? status,
    bool? success,
    Data? data,}){
    _status = status;
    _success = success;
    _data = data;
  }

  GetSupplierProducts.fromJson(dynamic json) {
    _status = json['status'];
    _success = json['success'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _status;
  bool? _success;
  Data? _data;

  String? get status => _status;
  bool? get success => _success;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
    num? page,
    List<Docs>? docs,
    num? docCount,
    num? pages,}){
    _page = page;
    _docs = docs;
    _docCount = docCount;
    _pages = pages;
  }

  Data.fromJson(dynamic json) {
    _page = json['page'];
    if (json['docs'] != null) {
      _docs = [];
      json['docs'].forEach((v) {
        _docs?.add(Docs.fromJson(v));
      });
    }
    _docCount = json['docCount'];
    _pages = json['pages'];
  }
  num? _page;
  List<Docs>? _docs;
  num? _docCount;
  num? _pages;

  num? get page => _page;
  List<Docs>? get docs => _docs;
  num? get docCount => _docCount;
  num? get pages => _pages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page'] = _page;
    if (_docs != null) {
      map['docs'] = _docs?.map((v) => v.toJson()).toList();
    }
    map['docCount'] = _docCount;
    map['pages'] = _pages;
    return map;
  }

}

class Docs {
  Docs({
    String? id,
    String? name,
    String? description,
    num? price,
    String? unit,
    num? discount,
    Owner? owner,
    String? discountType,
    num? stock,
    Category? category,
    SubCategory? subCategory,
    List<Attributes>? attributes,
    List<String>? images,
    num? ratingsAvg,
    num? ratingsCount,
    num? status,
    String? createdAt,
    String? updatedAt,
    num? v,}){
    _id = id;
    _name = name;
    _description = description;
    _price = price;
    _unit = unit;
    _discount = discount;
    _owner = owner;
    _discountType = discountType;
    _stock = stock;
    _category = category;
    _subCategory = subCategory;
    _attributes = attributes;
    _images = images;
    _ratingsAvg = ratingsAvg;
    _ratingsCount = ratingsCount;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
  }

  Docs.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _description = json['description'];
    _price = json['price'];
    _unit = json['unit'];
    _discount = json['discount'];
    _owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    _discountType = json['discountType'];
    _stock = json['stock'];
    _category = json['category'] != null ? Category.fromJson(json['category']) : null;
    _subCategory = json['subCategory'] != null ? SubCategory.fromJson(json['subCategory']) : null;
    if (json['attributes'] != null) {
      _attributes = [];
      json['attributes'].forEach((v) {
        _attributes?.add(Attributes.fromJson(v));
      });
    }
    _images = json['images'] != null ? json['images'].cast<String>() : [];
    _ratingsAvg = json['ratingsAvg'];
    _ratingsCount = json['ratingsCount'];
    _status = json['status'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  String? _id;
  String? _name;
  String? _description;
  num? _price;
  String? _unit;
  num? _discount;
  Owner? _owner;
  String? _discountType;
  num? _stock;
  Category? _category;
  SubCategory? _subCategory;
  List<Attributes>? _attributes;
  List<String>? _images;
  num? _ratingsAvg;
  num? _ratingsCount;
  num? _status;
  String? _createdAt;
  String? _updatedAt;
  num? _v;

  String? get id => _id;
  String? get name => _name;
  String? get description => _description;
  num? get price => _price;
  String? get unit => _unit;
  num? get discount => _discount;
  Owner? get owner => _owner;
  String? get discountType => _discountType;
  num? get stock => _stock;
  Category? get category => _category;
  SubCategory? get subCategory => _subCategory;
  List<Attributes>? get attributes => _attributes;
  List<String>? get images => _images;
  num? get ratingsAvg => _ratingsAvg;
  num? get ratingsCount => _ratingsCount;
  num? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['description'] = _description;
    map['price'] = _price;
    map['unit'] = _unit;
    map['discount'] = _discount;
    if (_owner != null) {
      map['owner'] = _owner?.toJson();
    }
    map['discountType'] = _discountType;
    map['stock'] = _stock;
    if (_category != null) {
      map['category'] = _category?.toJson();
    }
    if (_subCategory != null) {
      map['subCategory'] = _subCategory?.toJson();
    }
    if (_attributes != null) {
      map['attributes'] = _attributes?.map((v) => v.toJson()).toList();
    }
    map['images'] = _images;
    map['ratingsAvg'] = _ratingsAvg;
    map['ratingsCount'] = _ratingsCount;
    map['status'] = _status;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    return map;
  }

}

class Attributes {
  Attributes({
    String? value,
    String? label,
    String? name,}){
    _value = value;
    _label = label;
    _name = name;
  }

  Attributes.fromJson(dynamic json) {
    _value = json['value'];
    _label = json['label'];
    _name = json['name'];
  }
  String? _value;
  String? _label;
  String? _name;

  String? get value => _value;
  String? get label => _label;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['value'] = _value;
    map['label'] = _label;
    map['name'] = _name;
    return map;
  }

}

class SubCategory {
  SubCategory({
    String? id,
    String? name,
    MainCategory? mainCategory,}){
    _id = id;
    _name = name;
    _mainCategory = mainCategory;
  }

  SubCategory.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _mainCategory = json['mainCategory'] != null ? MainCategory.fromJson(json['mainCategory']) : null;
  }
  String? _id;
  String? _name;
  MainCategory? _mainCategory;

  String? get id => _id;
  String? get name => _name;
  MainCategory? get mainCategory => _mainCategory;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    if (_mainCategory != null) {
      map['mainCategory'] = _mainCategory?.toJson();
    }
    return map;
  }

}

class MainCategory {
  MainCategory({
    String? id,
    String? name,}){
    _id = id;
    _name = name;
  }

  MainCategory.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
  }
  String? _id;
  String? _name;

  String? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    return map;
  }

}

class Category {
  Category({
    String? id,
    String? name,}){
    _id = id;
    _name = name;
  }

  Category.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
  }
  String? _id;
  String? _name;

  String? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    return map;
  }

}

class Owner {
  Owner({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    num? userType,}){
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _phone = phone;
    _userType = userType;
  }

  Owner.fromJson(dynamic json) {
    _id = json['_id'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _email = json['email'];
    _phone = json['phone'];
    _userType = json['userType'];
  }
  String? _id;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _phone;
  num? _userType;

  String? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get phone => _phone;
  num? get userType => _userType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['email'] = _email;
    map['phone'] = _phone;
    map['userType'] = _userType;
    return map;
  }

}