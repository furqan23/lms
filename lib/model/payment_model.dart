class PaymentModel {
  bool? success;
  String? message;
  List<Data>? data;

  PaymentModel({this.success, this.message, this.data});

  PaymentModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? userId;
  String? createdBy;
  String? status;
  String? createdAt;
  String? createFromPlace;
  String? updatedAt;
  String? uploadedReceipt;
  String? uploadedReceiptDate;
  User? user;
  List<InvoiceDetil>? invoiceDetil;

  Data(
      {this.id,
        this.userId,
        this.createdBy,
        this.status,
        this.createdAt,
        this.createFromPlace,
        this.updatedAt,
        this.uploadedReceipt,
        this.uploadedReceiptDate,
        this.user,
        this.invoiceDetil});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    createdBy = json['created_by'];
    status = json['status'];
    createdAt = json['created_at'];
    createFromPlace = json['create_from_place'];
    updatedAt = json['updated_at'];
    uploadedReceipt = json['uploaded_receipt'];
    uploadedReceiptDate = json['uploaded_receipt_date'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['invoice_detil'] != null) {
      invoiceDetil = <InvoiceDetil>[];
      json['invoice_detil'].forEach((v) {
        invoiceDetil!.add(new InvoiceDetil.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['created_by'] = this.createdBy;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['create_from_place'] = this.createFromPlace;
    data['updated_at'] = this.updatedAt;
    data['uploaded_receipt'] = this.uploadedReceipt;
    data['uploaded_receipt_date'] = this.uploadedReceiptDate;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.invoiceDetil != null) {
      data['invoice_detil'] =
          this.invoiceDetil!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  int? id;
  String? firstName;
  String? email;
  String? isActive;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
        this.firstName,
        this.email,
        this.isActive,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    email = json['email'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['email'] = this.email;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class InvoiceDetil {
  int? id;
  String? invoiceId;
  String? groupId;
  String? categoryId;
  String? courseId;
  String? qty;
  String? price;
  Null? createdAt;
  Null? updatedAt;
  Category? category;

  InvoiceDetil(
      {this.id,
        this.invoiceId,
        this.groupId,
        this.categoryId,
        this.courseId,
        this.qty,
        this.price,
        this.createdAt,
        this.updatedAt,
        this.category});

  InvoiceDetil.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    invoiceId = json['invoice_id'];
    groupId = json['group_id'];
    categoryId = json['category_id'];
    courseId = json['course_id'];
    qty = json['qty'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['invoice_id'] = this.invoiceId;
    data['group_id'] = this.groupId;
    data['category_id'] = this.categoryId;
    data['course_id'] = this.courseId;
    data['qty'] = this.qty;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    return data;
  }
}

class Category {
  int? id;
  String? masterCategoryId;
  String? groupId;
  String? name;
  String? slug;
  Null? iconClass;
  String? isActive;
  Null? createdAt;
  Null? updatedAt;
  MasterCategory? masterCategory;

  Category(
      {this.id,
        this.masterCategoryId,
        this.groupId,
        this.name,
        this.slug,
        this.iconClass,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.masterCategory});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    masterCategoryId = json['master_category_id'];
    groupId = json['group_id'];
    name = json['name'];
    slug = json['slug'];
    iconClass = json['icon_class'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    masterCategory = json['master_category'] != null
        ? new MasterCategory.fromJson(json['master_category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['master_category_id'] = this.masterCategoryId;
    data['group_id'] = this.groupId;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['icon_class'] = this.iconClass;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.masterCategory != null) {
      data['master_category'] = this.masterCategory!.toJson();
    }
    return data;
  }
}

class MasterCategory {
  int? id;
  String? name;
  String? slug;
  String? iconClass;
  String? isActive;
  String? createdAt;
  String? updatedAt;

  MasterCategory(
      {this.id,
        this.name,
        this.slug,
        this.iconClass,
        this.isActive,
        this.createdAt,
        this.updatedAt});

  MasterCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    iconClass = json['icon_class'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['icon_class'] = this.iconClass;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}