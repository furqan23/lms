class InvoiceModel {
  bool? success;
  String? message;
  Data? data;

  InvoiceModel({this.success, this.message, this.data});

  InvoiceModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = success;
    data['message'] = message;
    data['data'] = this.data != null ? this.data!.toJson() : null;
    return data;
  }
}

class Data {
  Map<String, dynamic>? inv;
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
    data['inv'] = inv;
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

  PMethods({
    this.id,
    this.paymentTitle,
    this.payMethod,
    this.uniqueCode,
    this.status,
    this.payDetailsDeletion,
    this.description,
    this.slabCharges,
  });

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
    data['id'] = id;
    data['payment_title'] = paymentTitle;
    data['pay_method'] = payMethod;
    data['unique_code'] = uniqueCode;
    data['status'] = status;
    data['pay_details_deletion'] = payDetailsDeletion;
    data['description'] = description;
    data['slab_charges'] = slabCharges;
    return data;
  }
}
