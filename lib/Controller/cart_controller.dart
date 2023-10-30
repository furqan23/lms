import 'package:get/get.dart';

class CartController extends GetxController {
  var quantity = 1.obs;
  var totalBalance = 0.0.obs;

  // Function to increment the quantity and update the total price
  void incrementQuantity(double price) {
    quantity++;
    totalBalance.value = price * quantity.value;
  }

  // Function to decrement the quantity and update the total price
  void decrementQuantity(double price) {
    if (quantity.value > 1) {
      quantity--;
      totalBalance.value = price * quantity.value;
    }
  }
}
