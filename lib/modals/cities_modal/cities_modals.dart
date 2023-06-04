
class GetAllCitiesModal {
  String? status;
  bool? success;
  Data? data;

  GetAllCitiesModal({this.status, this.success, this.data});

  GetAllCitiesModal.fromJson(Map<String, dynamic> json) {
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

  Data({this.docs});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['docs'] != null) {
      docs = <Docs>[];
      json['docs'].forEach((v) {
        docs!.add(new Docs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.docs != null) {
      data['docs'] = this.docs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Docs {
  String? id;
  String? name;
  List<String>? shipmentType;
  bool? allowAsOrigin;
  bool? allowAsDestination;

  Docs(
      {this.id,
        this.name,
        this.shipmentType,
        this.allowAsOrigin,
        this.allowAsDestination});

  Docs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shipmentType = json['shipment_type'].cast<String>();
    allowAsOrigin = json['allow_as_origin'];
    allowAsDestination = json['allow_as_destination'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['shipment_type'] = this.shipmentType;
    data['allow_as_origin'] = this.allowAsOrigin;
    data['allow_as_destination'] = this.allowAsDestination;
    return data;
  }
}