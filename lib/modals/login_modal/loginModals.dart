
class LoginModals {
  LoginModals({
      String? status, 
      bool? success, 
      Data? data,}){
    _status = status;
    _success = success;
    _data = data;
}

  LoginModals.fromJson(dynamic json) {
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
      Doc? doc, 
      String? token,}){
    _message = message;
    _doc = doc;
    _token = token;
}

  Data.fromJson(dynamic json) {
    _message = json['message'];
    _doc = json['doc'] != null ? Doc.fromJson(json['doc']) : null;
    _token = json['token'];
  }
  String? _message;
  Doc? _doc;
  String? _token;

  String? get message => _message;
  Doc? get doc => _doc;
  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    if (_doc != null) {
      map['doc'] = _doc?.toJson();
    }
    map['token'] = _token;
    return map;
  }

}

class Doc {
  Doc({
      String? id, 
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
      String? createdAt, 
      String? updatedAt, 
      num? v,}){
    _id = id;
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
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
}

  Doc.fromJson(dynamic json) {
    _id = json['_id'];
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
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  String? _id;
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
  String? _createdAt;
  String? _updatedAt;
  num? _v;

  String? get id => _id;
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
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
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
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    return map;
  }

}