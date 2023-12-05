class InvoiceModel {
  bool? success;
  String? message;
  Data? data;

  InvoiceModel({this.success, this.message, this.data});

  InvoiceModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Null? inv;
  List<PMethods>? pMethods;

  Data({this.inv, this.pMethods});

  Data.fromJson(Map<String, dynamic> json) {
    inv = json['inv'];
    if (json['p_methods'] != null) {
      pMethods = <PMethods>[];
      json['p_methods'].forEach((v) {
        pMethods!.add(new PMethods.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['inv'] = this.inv;
    if (this.pMethods != null) {
      data['p_methods'] = this.pMethods!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PMethods {
  int? id;
  String? paymentTitle;
  String? payMethod;
  String? uniqueCode;
  String? status;
  String? payDetailsDeletion;
  String? description;
  String? slabCharges;

  PMethods(
      {this.id,
        this.paymentTitle,
        this.payMethod,
        this.uniqueCode,
        this.status,
        this.payDetailsDeletion,
        this.description,
        this.slabCharges});

  PMethods.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentTitle = json['payment_title'];
    payMethod = json['pay_method'];
    uniqueCode = json['unique_code'];
    status = json['status'];
    payDetailsDeletion = json['pay_details_deletion'];
    description = json['description'];
    slabCharges = json['slab_charges'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['payment_title'] = this.paymentTitle;
    data['pay_method'] = this.payMethod;
    data['unique_code'] = this.uniqueCode;
    data['status'] = this.status;
    data['pay_details_deletion'] = this.payDetailsDeletion;
    data['description'] = this.description;
    data['slab_charges'] = this.slabCharges;
    return data;
  }
}