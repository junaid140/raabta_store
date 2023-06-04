
class TextBannerModal {
  String? status;
  bool? success;
  Data? data;

  TextBannerModal({this.status, this.success, this.data});

  TextBannerModal.fromJson(Map<String, dynamic> json) {
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
  Doc? doc;

  Data({this.doc});

  Data.fromJson(Map<String, dynamic> json) {
    doc = json['doc'] != null ? new Doc.fromJson(json['doc']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.doc != null) {
      data['doc'] = this.doc!.toJson();
    }
    return data;
  }
}

class Doc {
  String? sId;
  String? text;
  String? createdAt;
  int? iV;

  Doc({this.sId, this.text, this.createdAt, this.iV});

  Doc.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    text = json['text'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['text'] = this.text;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

