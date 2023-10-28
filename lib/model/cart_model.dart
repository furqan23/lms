class CartModel {
  final String courseId;
  final String courseTitle;
  final double price;
  final String categoryid;
  final String groupId;
  CartModel({
    required this.courseId,
    required this.groupId,
    required this.categoryid,
    required this.courseTitle,
    required this.price,
  });
}
