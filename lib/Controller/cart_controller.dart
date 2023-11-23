import 'package:get/get.dart';

import '../model/cart_model.dart';

class CartController extends GetxController {
  RxList<CartModel> cartList = <CartModel>[].obs;

  void setCartItems(List<CartModel> items) {
    cartList.assignAll(items);
  }

  var quantity = 1.obs;
  var totalBalance = 0.0.obs;
  var price =
      10.0; // Assuming a default price for items, you can change this according to your needs

  // Function to increment the quantity and update the total price
  void incrementQuantity() {
    quantity++;
    totalBalance.value = price * quantity.value;
  }

  // Function to decrement the quantity and update the total price
  void decrementQuantity() {
    if (quantity.value > 1) {
      quantity--;
      totalBalance.value = price * quantity.value;
    }
  }
}
