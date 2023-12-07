class CartModel {
  final String groupname;
  final String categoryname;
  final String courseId;
  final String courseTitle;
  double price;
  final String categoryid;
  final String groupId;
 String registrationMethod; // New field

  CartModel({
    required this.groupname,
    required this.courseId,
    required this.groupId,
    required this.categoryid,
    required this.courseTitle,
    required this.categoryname,
    required this.price,
    required this.registrationMethod, // New field
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      categoryname: json['categoryname'],
      groupname: json['groupname'] ?? '',
      courseId: json['courseId'] ?? '',
      groupId: json['groupId'] ?? '',
      categoryid: json['categoryid'] ?? '',
      courseTitle: json['courseTitle'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      registrationMethod: json['registrationMethod'] ?? '', // New field
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryname': categoryname,
      'groupname': groupname,
      'courseId': courseId,
      'groupId': groupId,
      'categoryid': categoryid,
      'courseTitle': courseTitle,
      'price': price,
      'registrationMethod': registrationMethod, // New field
    };
  }
}
