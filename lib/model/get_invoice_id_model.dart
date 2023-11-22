class GetInvoiceByIdModel {
  bool? success;
  String? message;
  Data? data;

  GetInvoiceByIdModel({this.success, this.message, this.data});

  GetInvoiceByIdModel.fromJson(Map<String, dynamic> json) {
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
  Inv? inv;
  List<PMethods>? pMethods;

  Data({this.inv, this.pMethods});

  Data.fromJson(Map<String, dynamic> json) {
    inv = json['inv'] != null ? new Inv.fromJson(json['inv']) : null;
    if (json['p_methods'] != null) {
      pMethods = <PMethods>[];
      json['p_methods'].forEach((v) {
        pMethods!.add(new PMethods.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.inv != null) {
      data['inv'] = this.inv!.toJson();
    }
    if (this.pMethods != null) {
      data['p_methods'] = this.pMethods!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Inv {
  int? id;
  String? userId;
  String? createdBy;
  String? status;
  String? createdAt;
  String? createFromPlace;
  String? updatedAt;
  var uploadedReceipt;
  var uploadedReceiptDate;
  String? invoiceAmount;
  String? otherCharges;
  var otherChargesDesc;
  String? discount;
  String? invoiceTotalAmount;
  User? user;
  List<InvoiceDetil>? invoiceDetil;

  Inv(
      {this.id,
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

  Inv.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    createdBy = json['created_by'];
    status = json['status'];
    createdAt = json['created_at'];
    createFromPlace = json['create_from_place'];
    updatedAt = json['updated_at'];
    uploadedReceipt = json['uploaded_receipt'];
    uploadedReceiptDate = json['uploaded_receipt_date'];
    invoiceAmount = json['invoice_amount'];
    otherCharges = json['other_charges'];
    otherChargesDesc = json['other_charges_desc'];
    discount = json['discount'];
    invoiceTotalAmount = json['invoice_total_amount'];
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
  var contactNo;
  String? commission;
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
        this.image});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    email = json['email'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    regNo = json['reg_no'];
    retriveUniqCode = json['retrive_uniq_code'];
    cardExpireAt = json['card_expire_at'];
    contactNo = json['contact_no'];
    commission = json['commission'];
    image = json['image'];
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
  Groups? groups;
  Course? course;

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
        this.category,
        this.groups,
        this.course});

  InvoiceDetil.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    invoiceId = json['invoice_id'];
    groupId = json['group_id'];
    categoryId = json['category_id'];
    courseId = json['course_id'];
    qty = json['qty'];
    price = json['price'];
    discount = json['discount'];
    feeType = json['fee_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    groups =
    json['groups'] != null ? new Groups.fromJson(json['groups']) : null;
    course =
    json['course'] != null ? new Course.fromJson(json['course']) : null;
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
    if (this.groups != null) {
      data['groups'] = this.groups!.toJson();
    }
    if (this.course != null) {
      data['course'] = this.course!.toJson();
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

class Groups {
  int? id;
  String? name;
  String? registrationMethod;
  var description;
  String? isActive;
  String? totalSeat;
  var expireOn;

  Groups(
      {this.id,
        this.name,
        this.registrationMethod,
        this.description,
        this.isActive,
        this.totalSeat,
        this.expireOn});

  Groups.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    registrationMethod = json['registration_method'];
    description = json['description'];
    isActive = json['is_active'];
    totalSeat = json['total_seat'];
    expireOn = json['expire_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['registration_method'] = this.registrationMethod;
    data['description'] = this.description;
    data['is_active'] = this.isActive;
    data['total_seat'] = this.totalSeat;
    data['expire_on'] = this.expireOn;
    return data;
  }
}

class Course {
  int? id;
  String? instructorId;
  String? categoryId;
  String? masterCourseId;
  var instructionLevelId;
  String? courseTitle;
  String? courseSlug;
  var keywords;
  var overview;
  var courseImage;
  var thumbImage;
  var courseVideo;
  var duration;
  String? price;
  String? classTime;
  var strikeOutPrice;
  String? isActive;
  String? createdAt;
  String? updatedAt;
  MasterCourse? masterCourse;

  Course(
      {this.id,
        this.instructorId,
        this.categoryId,
        this.masterCourseId,
        this.instructionLevelId,
        this.courseTitle,
        this.courseSlug,
        this.keywords,
        this.overview,
        this.courseImage,
        this.thumbImage,
        this.courseVideo,
        this.duration,
        this.price,
        this.classTime,
        this.strikeOutPrice,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.masterCourse});

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instructorId = json['instructor_id'];
    categoryId = json['category_id'];
    masterCourseId = json['master_course_id'];
    instructionLevelId = json['instruction_level_id'];
    courseTitle = json['course_title'];
    courseSlug = json['course_slug'];
    keywords = json['keywords'];
    overview = json['overview'];
    courseImage = json['course_image'];
    thumbImage = json['thumb_image'];
    courseVideo = json['course_video'];
    duration = json['duration'];
    price = json['price'];
    classTime = json['class_time'];
    strikeOutPrice = json['strike_out_price'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    masterCourse = json['master_course'] != null
        ? new MasterCourse.fromJson(json['master_course'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['instructor_id'] = this.instructorId;
    data['category_id'] = this.categoryId;
    data['master_course_id'] = this.masterCourseId;
    data['instruction_level_id'] = this.instructionLevelId;
    data['course_title'] = this.courseTitle;
    data['course_slug'] = this.courseSlug;
    data['keywords'] = this.keywords;
    data['overview'] = this.overview;
    data['course_image'] = this.courseImage;
    data['thumb_image'] = this.thumbImage;
    data['course_video'] = this.courseVideo;
    data['duration'] = this.duration;
    data['price'] = this.price;
    data['class_time'] = this.classTime;
    data['strike_out_price'] = this.strikeOutPrice;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.masterCourse != null) {
      data['master_course'] = this.masterCourse!.toJson();
    }
    return data;
  }
}

class MasterCourse {
  int? id;
  var instructorId;
  var categoryId;
  var instructionLevelId;
  String? courseTitle;
  String? courseSlug;
  var keywords;
  var overview;
  var courseImage;
  var thumbImage;
  var courseVideo;
  var duration;
  var price;
  var strikeOutPrice;
  String? isActive;
  String? createdAt;
  String? updatedAt;

  MasterCourse(
      {this.id,
        this.instructorId,
        this.categoryId,
        this.instructionLevelId,
        this.courseTitle,
        this.courseSlug,
        this.keywords,
        this.overview,
        this.courseImage,
        this.thumbImage,
        this.courseVideo,
        this.duration,
        this.price,
        this.strikeOutPrice,
        this.isActive,
        this.createdAt,
        this.updatedAt});

  MasterCourse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instructorId = json['instructor_id'];
    categoryId = json['category_id'];
    instructionLevelId = json['instruction_level_id'];
    courseTitle = json['course_title'];
    courseSlug = json['course_slug'];
    keywords = json['keywords'];
    overview = json['overview'];
    courseImage = json['course_image'];
    thumbImage = json['thumb_image'];
    courseVideo = json['course_video'];
    duration = json['duration'];
    price = json['price'];
    strikeOutPrice = json['strike_out_price'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['instructor_id'] = this.instructorId;
    data['category_id'] = this.categoryId;
    data['instruction_level_id'] = this.instructionLevelId;
    data['course_title'] = this.courseTitle;
    data['course_slug'] = this.courseSlug;
    data['keywords'] = this.keywords;
    data['overview'] = this.overview;
    data['course_image'] = this.courseImage;
    data['thumb_image'] = this.thumbImage;
    data['course_video'] = this.courseVideo;
    data['duration'] = this.duration;
    data['price'] = this.price;
    data['strike_out_price'] = this.strikeOutPrice;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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
