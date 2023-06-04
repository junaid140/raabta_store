

class RegisterUsersModals {
  RegisterUsersModals({
      String? status, 
      bool? success, 
      Data? data,}){
    _status = status;
    _success = success;
    _data = data;
}

  RegisterUsersModals.fromJson(dynamic json) {
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
      String? message, 
      Doc? doc,}){
    _message = message;
    _doc = doc;
}

  Data.fromJson(dynamic json) {
    _message = json['message'];
    _doc = json['doc'] != null ? Doc.fromJson(json['doc']) : null;
  }
  String? _message;
  Doc? _doc;

  String? get message => _message;
  Doc? get doc => _doc;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    if (_doc != null) {
      map['doc'] = _doc?.toJson();
    }
    return map;
  }

}

class Doc {
  Doc({
      String? firstName, 
      String? lastName, 
      String? email, 
      dynamic emailVerificationToken, 
      String? image, 
      dynamic phone, 
      num? isPhoneVerified, 
      String? password, 
      dynamic fcmToken, 
      num? userType, 
      String? id, 
      String? createdAt, 
      String? updatedAt, 
      num? v,}){
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _emailVerificationToken = emailVerificationToken;
    _image = image;
    _phone = phone;
    _isPhoneVerified = isPhoneVerified;
    _password = password;
    _fcmToken = fcmToken;
    _userType = userType;
    _id = id;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
}

  Doc.fromJson(dynamic json) {
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _email = json['email'];
    _emailVerificationToken = json['emailVerificationToken'];
    _image = json['image'];
    _phone = json['phone'];
    _isPhoneVerified = json['isPhoneVerified'];
    _password = json['password'];
    _fcmToken = json['fcmToken'];
    _userType = json['userType'];
    _id = json['_id'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  String? _firstName;
  String? _lastName;
  String? _email;
  dynamic _emailVerificationToken;
  String? _image;
  dynamic _phone;
  num? _isPhoneVerified;
  String? _password;
  dynamic _fcmToken;
  num? _userType;
  String? _id;
  String? _createdAt;
  String? _updatedAt;
  num? _v;

  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  dynamic get emailVerificationToken => _emailVerificationToken;
  String? get image => _image;
  dynamic get phone => _phone;
  num? get isPhoneVerified => _isPhoneVerified;
  String? get password => _password;
  dynamic get fcmToken => _fcmToken;
  num? get userType => _userType;
  String? get id => _id;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['email'] = _email;
    map['emailVerificationToken'] = _emailVerificationToken;
    map['image'] = _image;
    map['phone'] = _phone;
    map['isPhoneVerified'] = _isPhoneVerified;
    map['password'] = _password;
    map['fcmToken'] = _fcmToken;
    map['userType'] = _userType;
    map['_id'] = _id;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    return map;
  }

}