

class GetMyOrdersModal {
  GetMyOrdersModal({
      String? status, 
      bool? success, 
      Data? data,}){
    _status = status;
    _success = success;
    _data = data;
}

  GetMyOrdersModal.fromJson(dynamic json) {
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
      num? pages, 
      num? docCount, 
      num? page, 
      List<Docs>? docs,}){
    _pages = pages;
    _docCount = docCount;
    _page = page;
    _docs = docs;
}

  Data.fromJson(dynamic json) {
    _pages = json['pages'];
    _docCount = json['docCount'];
    _page = json['page'];
    if (json['docs'] != null) {
      _docs = [];
      json['docs'].forEach((v) {
        _docs?.add(Docs.fromJson(v));
      });
    }
  }
  num? _pages;
  num? _docCount;
  num? _page;
  List<Docs>? _docs;

  num? get pages => _pages;
  num? get docCount => _docCount;
  num? get page => _page;
  List<Docs>? get docs => _docs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pages'] = _pages;
    map['docCount'] = _docCount;
    map['page'] = _page;
    if (_docs != null) {
      map['docs'] = _docs?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Docs {
  Docs({
      String? id, 
      User? user, 
      List<OrderItems>? orderItems, 
      num? orderAmount, 
      String? orderStatus, 
      String? paymentStatus, 
      String? paymentMethod, 
      ShippingAddress? shippingAddress, 
      num? deliveryFee, 
      String? createdAt, 
      String? updatedAt, 
      num? v,}){
    _id = id;
    _user = user;
    _orderItems = orderItems;
    _orderAmount = orderAmount;
    _orderStatus = orderStatus;
    _paymentStatus = paymentStatus;
    _paymentMethod = paymentMethod;
    _shippingAddress = shippingAddress;
    _deliveryFee = deliveryFee;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
}

  Docs.fromJson(dynamic json) {
    _id = json['_id'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['orderItems'] != null) {
      _orderItems = [];
      json['orderItems'].forEach((v) {
        _orderItems?.add(OrderItems.fromJson(v));
      });
    }
    _orderAmount = json['orderAmount'];
    _orderStatus = json['orderStatus'];
    _paymentStatus = json['paymentStatus'];
    _paymentMethod = json['paymentMethod'];
    _shippingAddress = json['shippingAddress'] != null ? ShippingAddress.fromJson(json['shippingAddress']) : null;
    _deliveryFee = json['deliveryFee'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  String? _id;
  User? _user;
  List<OrderItems>? _orderItems;
  num? _orderAmount;
  String? _orderStatus;
  String? _paymentStatus;
  String? _paymentMethod;
  ShippingAddress? _shippingAddress;
  num? _deliveryFee;
  String? _createdAt;
  String? _updatedAt;
  num? _v;

  String? get id => _id;
  User? get user => _user;
  List<OrderItems>? get orderItems => _orderItems;
  num? get orderAmount => _orderAmount;
  String? get orderStatus => _orderStatus;
  String? get paymentStatus => _paymentStatus;
  String? get paymentMethod => _paymentMethod;
  ShippingAddress? get shippingAddress => _shippingAddress;
  num? get deliveryFee => _deliveryFee;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    if (_orderItems != null) {
      map['orderItems'] = _orderItems?.map((v) => v.toJson()).toList();
    }
    map['orderAmount'] = _orderAmount;
    map['orderStatus'] = _orderStatus;
    map['paymentStatus'] = _paymentStatus;
    map['paymentMethod'] = _paymentMethod;
    if (_shippingAddress != null) {
      map['shippingAddress'] = _shippingAddress?.toJson();
    }
    map['deliveryFee'] = _deliveryFee;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    return map;
  }

}

class ShippingAddress {
  ShippingAddress({
      String? id, 
      String? user, 
      String? phoneNo, 
      String? houseNo, 
      String? streetNo, 
      String? block, 
      String? nearestLandmark, 
      String? city, 
      String? createdAt, 
      String? updatedAt, 
      num? v, 
      String? area, 
      num? cityId,}){
    _id = id;
    _user = user;
    _phoneNo = phoneNo;
    _houseNo = houseNo;
    _streetNo = streetNo;
    _block = block;
    _nearestLandmark = nearestLandmark;
    _city = city;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
    _area = area;
    _cityId = cityId;
}

  ShippingAddress.fromJson(dynamic json) {
    _id = json['_id'];
    _user = json['user'];
    _phoneNo = json['phoneNo'];
    _houseNo = json['houseNo'];
    _streetNo = json['streetNo'];
    _block = json['block'];
    _nearestLandmark = json['nearestLandmark'];
    _city = json['city'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
    _area = json['area'];
    _cityId = json['cityId'];
  }
  String? _id;
  String? _user;
  String? _phoneNo;
  String? _houseNo;
  String? _streetNo;
  String? _block;
  String? _nearestLandmark;
  String? _city;
  String? _createdAt;
  String? _updatedAt;
  num? _v;
  String? _area;
  num? _cityId;

  String? get id => _id;
  String? get user => _user;
  String? get phoneNo => _phoneNo;
  String? get houseNo => _houseNo;
  String? get streetNo => _streetNo;
  String? get block => _block;
  String? get nearestLandmark => _nearestLandmark;
  String? get city => _city;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get v => _v;
  String? get area => _area;
  num? get cityId => _cityId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['user'] = _user;
    map['phoneNo'] = _phoneNo;
    map['houseNo'] = _houseNo;
    map['streetNo'] = _streetNo;
    map['block'] = _block;
    map['nearestLandmark'] = _nearestLandmark;
    map['city'] = _city;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    map['area'] = _area;
    map['cityId'] = _cityId;
    return map;
  }

}

class OrderItems {
  OrderItems({
      Product? product, 
      num? qty, 
      num? status, 
      num? unitPrice, 
      num? userProfit, 
      dynamic productSize, 
      dynamic productColor, 
      String? productOwner, 
      String? id,}){
    _product = product;
    _qty = qty;
    _status = status;
    _unitPrice = unitPrice;
    _userProfit = userProfit;
    _productSize = productSize;
    _productColor = productColor;
    _productOwner = productOwner;
    _id = id;
}

  OrderItems.fromJson(dynamic json) {
    _product = json['product'] != null ? Product.fromJson(json['product']) : null;
    _qty = json['qty'];
    _status = json['status'];
    _unitPrice = json['unitPrice'];
    _userProfit = json['userProfit'];
    _productSize = json['productSize'];
    _productColor = json['productColor'];
    _productOwner = json['productOwner'];
    _id = json['_id'];
  }
  Product? _product;
  num? _qty;
  num? _status;
  num? _unitPrice;
  num? _userProfit;
  dynamic _productSize;
  dynamic _productColor;
  String? _productOwner;
  String? _id;

  Product? get product => _product;
  num? get qty => _qty;
  num? get status => _status;
  num? get unitPrice => _unitPrice;
  num? get userProfit => _userProfit;
  dynamic get productSize => _productSize;
  dynamic get productColor => _productColor;
  String? get productOwner => _productOwner;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_product != null) {
      map['product'] = _product?.toJson();
    }
    map['qty'] = _qty;
    map['status'] = _status;
    map['unitPrice'] = _unitPrice;
    map['userProfit'] = _userProfit;
    map['productSize'] = _productSize;
    map['productColor'] = _productColor;
    map['productOwner'] = _productOwner;
    map['_id'] = _id;
    return map;
  }

}

class Product {
  Product({
      String? id, 
      String? name, 
      String? description, 
      num? price, 
      String? unit, 
      Owner? owner, 
      num? stock, 
      Category? category, 
      SubCategory? subCategory, 
      List<Attributes>? attributes, 
      List<String>? images, 
      num? ratingsAvg, 
      num? ratingsCount, 
      num? status, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _name = name;
    _description = description;
    _price = price;
    _unit = unit;
    _owner = owner;
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
}

  Product.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _description = json['description'];
    _price = json['price'];
    _unit = json['unit'];
    _owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
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
  }
  String? _id;
  String? _name;
  String? _description;
  num? _price;
  String? _unit;
  Owner? _owner;
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

  String? get id => _id;
  String? get name => _name;
  String? get description => _description;
  num? get price => _price;
  String? get unit => _unit;
  Owner? get owner => _owner;
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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['description'] = _description;
    map['price'] = _price;
    map['unit'] = _unit;
    if (_owner != null) {
      map['owner'] = _owner?.toJson();
    }
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

class User {
  User({
      String? id, 
      String? firstName, 
      String? lastName, 
      String? email, 
      String? image, 
      dynamic phone, 
      num? userType,}){
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _image = image;
    _phone = phone;
    _userType = userType;
}

  User.fromJson(dynamic json) {
    _id = json['_id'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _email = json['email'];
    _image = json['image'];
    _phone = json['phone'];
    _userType = json['userType'];
  }
  String? _id;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _image;
  dynamic _phone;
  num? _userType;

  String? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get image => _image;
  dynamic get phone => _phone;
  num? get userType => _userType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['email'] = _email;
    map['image'] = _image;
    map['phone'] = _phone;
    map['userType'] = _userType;
    return map;
  }

}