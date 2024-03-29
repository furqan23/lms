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
  String? refId;
  String? userId;
  String? createdBy;
  String? status;
  String? createdAt;
  String? createFromPlace;
  String? updatedAt;
  String? uploadedReceipt;
  String? uploadedReceiptDate;
  String? invoiceAmount;
  String? otherCharges;
  String? otherChargesDesc;
  String? discount;
  String? invoiceTotalAmount;
  User? user;
  List<InvoiceDetil>? invoiceDetil;

  Data(
      {this.id,
        this.refId,
        this.userId,
        this.createdBy,
        this.status,
        this.createdAt,
        this.createFromPlace,
        this.updatedAt,
        this.uploadedReceipt,
        this.uploadedReceiptDate,
        this.invoiceAmount,
        this.otherCharges,
        this.otherChargesDesc,
        this.discount,
        this.invoiceTotalAmount,
        this.user,
        this.invoiceDetil});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id']??"empty";
    refId = json['ref_id']??"empty";
    userId = json['user_id']??"empty";
    createdBy = json['created_by']??"empty";
    status = json['status']??"empty";
    createdAt = json['created_at']??"empty";
    createFromPlace = json['create_from_place']??"empty";
    updatedAt = json['updated_at']??"empty";
    uploadedReceipt = json['uploaded_receipt']??"empty";
    uploadedReceiptDate = json['uploaded_receipt_date']??"empty";
    invoiceAmount = json['invoice_amount']??"empty";
    otherCharges = json['other_charges']??"empty";
    otherChargesDesc = json['other_charges_desc']??"empty";
    discount = json['discount']??"empty";
    invoiceTotalAmount = json['invoice_total_amount']??"empty";
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
    data['ref_id'] = this.refId;
    data['user_id'] = this.userId;
    data['created_by'] = this.createdBy;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['create_from_place'] = this.createFromPlace;
    data['updated_at'] = this.updatedAt;
    data['uploaded_receipt'] = this.uploadedReceipt;
    data['uploaded_receipt_date'] = this.uploadedReceiptDate;
    data['invoice_amount'] = this.invoiceAmount;
    data['other_charges'] = this.otherCharges;
    data['other_charges_desc'] = this.otherChargesDesc;
    data['discount'] = this.discount;
    data['invoice_total_amount'] = this.invoiceTotalAmount;
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
  var regNo;
var retriveUniqCode;
  var cardExpireAt;
  String? contactNo;
  String? commission;
  String? deviceImei;
  var biography;
  var image;

  User(
      {this.id,
        this.firstName,
        this.email,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.regNo,
        this.retriveUniqCode,
        this.cardExpireAt,
        this.contactNo,
        this.commission,
        this.deviceImei,
        this.biography,
        this.image});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id']??"empty";
    firstName = json['first_name']??"empty";
    email = json['email']??"empty";
    isActive = json['is_active']??"empty";
    createdAt = json['created_at']??"empty";
    updatedAt = json['updated_at']??"empty";
    regNo = json['reg_no']??"empty";
    retriveUniqCode = json['retrive_uniq_code']??"empty";
    cardExpireAt = json['card_expire_at']??"empty";
    contactNo = json['contact_no']??"empty";
    commission = json['commission']??"empty";
    deviceImei = json['device_imei']??"empty";
    biography = json['biography']??"empty";
    image = json['image']??"empty";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['email'] = this.email;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['reg_no'] = this.regNo;
    data['retrive_uniq_code'] = this.retriveUniqCode;
    data['card_expire_at'] = this.cardExpireAt;
    data['contact_no'] = this.contactNo;
    data['commission'] = this.commission;
    data['device_imei'] = this.deviceImei;
    data['biography'] = this.biography;
    data['image'] = this.image;
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
  String? discount;
  String? feeType;
  var createdAt;
 var updatedAt;
  Category? category;

  InvoiceDetil(
      {this.id,
        this.invoiceId,
        this.groupId,
        this.categoryId,
        this.courseId,
        this.qty,
        this.price,
        this.discount,
        this.feeType,
        this.createdAt,
        this.updatedAt,
        this.category});

  InvoiceDetil.fromJson(Map<String, dynamic> json) {
    id = json['id']??"empty";
    invoiceId = json['invoice_id']??"empty";
    groupId = json['group_id']??"empty";
    categoryId = json['category_id']??"empty";
    courseId = json['course_id']??"empty";
    qty = json['qty']??"empty";
    price = json['price']??"empty";
    discount = json['discount']??"empty";
    feeType = json['fee_type']??"empty";
    createdAt = json['created_at']??"empty";
    updatedAt = json['updated_at']??"empty";
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
    data['discount'] = this.discount;
    data['fee_type'] = this.feeType;
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
  var iconClass;
  String? isActive;
  var createdAt;
  var updatedAt;
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
    id = json['id']??"empty";
    masterCategoryId = json['master_category_id']??"empty";
    groupId = json['group_id']??"empty";
    name = json['name']??"empty";
    slug = json['slug']??"empty";
    iconClass = json['icon_class']??"empty";
    isActive = json['is_active']??"empty";
    createdAt = json['created_at']??"empty";
    updatedAt = json['updated_at']??"empty";
    masterCategory = json['master_category'] != null
        ?   MasterCategory.fromJson(json['master_category'])
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
  var image;

  MasterCategory(
      {this.id,
        this.name,
        this.slug,
        this.iconClass,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.image});

  MasterCategory.fromJson(Map<String, dynamic> json) {
    id = json['id']??"empty";
    name = json['name']??"empty";
    slug = json['slug']??"empty";
    iconClass = json['icon_class']??"empty";
    isActive = json['is_active']??"empty";
    createdAt = json['created_at']??"empty";
    updatedAt = json['updated_at']??"empty";
    image = json['image']??"empty";
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
    data['image'] = this.image;
    return data;
  }
}