class GetMyOrdersModal {
  String? status;
  bool? success;
  Data? data;

  GetMyOrdersModal({this.status, this.success, this.data});

  GetMyOrdersModal.fromJson(Map<String, dynamic> json) {
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
  int? pages;
  int? docCount;
  String? page;
  List<Docs>? docs;

  Data({this.pages, this.docCount, this.page, this.docs});

  Data.fromJson(Map<String, dynamic> json) {
    pages = json['pages'];
    docCount = json['docCount'];
    page = json['page'].toString(); // convert to String
    if (json['docs'] != null) {
      docs = <Docs>[];
      json['docs'].forEach((v) {
        docs!.add(Docs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pages'] = pages;
    data['docCount'] = docCount;
    data['page'] = page;
    if (docs != null) {
      data['docs'] = docs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class Docs {
  String? sId;
  User? user;
  List<OrderItems>? orderItems;
  int? orderAmount;
  String? orderStatus;
  String? paymentStatus;
  String? paymentMethod;
  ShippingAddress? shippingAddress;
  int? deliveryFee;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Docs(
      {this.sId,
        this.user,
        this.orderItems,
        this.orderAmount,
        this.orderStatus,
        this.paymentStatus,
        this.paymentMethod,
        this.shippingAddress,
        this.deliveryFee,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Docs.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['orderItems'] != null) {
      orderItems = <OrderItems>[];
      json['orderItems'].forEach((v) {
        orderItems!.add(OrderItems.fromJson(v));
      });
    }
    orderAmount = json['orderAmount'];
    orderStatus = json['orderStatus'];
    paymentStatus = json['paymentStatus'];
    paymentMethod = json['paymentMethod'];
    shippingAddress = json['shippingAddress'] != null
        ? ShippingAddress.fromJson(json['shippingAddress'])
        : null;
    deliveryFee = json['deliveryFee'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (orderItems != null) {
      data['orderItems'] = orderItems!.map((v) => v.toJson()).toList();
    }
    data['orderAmount'] = orderAmount;
    data['orderStatus'] = orderStatus;
    data['paymentStatus'] = paymentStatus;
    data['paymentMethod'] = paymentMethod;
    if (shippingAddress != null) {
      data['shippingAddress'] = shippingAddress!.toJson();
    }
    data['deliveryFee'] = deliveryFee;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
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
  int? userType;

  User(
      {this.sId,
        this.firstName,
        this.lastName,
        this.email,
        this.image,
        this.phone,
        this.userType});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    image = json['image'];
    phone = json['phone'];
    userType = json['userType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['image'] = image;
    data['phone'] = phone;
    data['userType'] = userType;
    return data;
  }
}

class OrderItems {
  Product? product;
  int? qty;
  int? status;
  int? unitPrice;
  int? userProfit;
  String? productSize;
  String? productColor;
  String? productOwner;
  String? sId;

  OrderItems(
      {this.product,
        this.qty,
        this.status,
        this.unitPrice,
        this.userProfit,
        this.productSize,
        this.productColor,
        this.productOwner,
        this.sId});

  OrderItems.fromJson(Map<String, dynamic> json) {
    product =
    json['product'] != null ? Product.fromJson(json['product']) : null;
    qty = json['qty'];
    status = json['status'];
    unitPrice = json['unitPrice'];
    userProfit = json['userProfit'];
    productSize = json['productSize'];
    productColor = json['productColor'];
    productOwner = json['productOwner'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (product != null) {
      data['product'] = product!.toJson();
    }
    data['qty'] = qty;
    data['status'] = status;
    data['unitPrice'] = unitPrice;
    data['userProfit'] = userProfit;
    data['productSize'] = productSize;
    data['productColor'] = productColor;
    data['productOwner'] = productOwner;
    data['_id'] = sId;
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
  num? ratingsAvg;
  num? ratingsCount;
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
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['unit'] = unit;
    if (owner != null) {
      data['owner'] = owner!.toJson();
    }
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

class ShippingAddress {
  String? sId;
  String? user;
  String? phoneNo;
  String? houseNo;
  String? streetNo;
  String? block;
  String? nearestLandmark;
  String? city;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? area;
  int? cityId;

  ShippingAddress(
      {this.sId,
        this.user,
        this.phoneNo,
        this.houseNo,
        this.streetNo,
        this.block,
        this.nearestLandmark,
        this.city,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.area,
        this.cityId});

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'];
    phoneNo = json['phoneNo'];
    houseNo = json['houseNo'];
    streetNo = json['streetNo'];
    block = json['block'];
    nearestLandmark = json['nearestLandmark'];
    city = json['city'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    area = json['area'];
    cityId = json['cityId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['user'] = user;
    data['phoneNo'] = phoneNo;
    data['houseNo'] = houseNo;
    data['streetNo'] = streetNo;
    data['block'] = block;
    data['nearestLandmark'] = nearestLandmark;
    data['city'] = city;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['area'] = area;
    data['cityId'] = cityId;
    return data;
  }
}
