import 'dart:developer';

import 'package:get/get.dart';

import '../model/cart_model.dart';

class CartController extends GetxController {


  RxList<CartModel> cartList = <CartModel>[].obs;

  void setCartItems(List<CartModel> items) {
    cartList.value.assignAll(items);
  }


  RxInt quantity = 1.obs;
  RxInt totalBalance =0.obs;
   // Assuming a default price for items, you can change this according to your needs

  // Function to increment the quantity and update the total price
  void incrementQuantity( int price  ) {
    quantity.value++;  update();
    totalBalance.value =  price  * quantity.value;
    log(quantity.value.toString());
    update();
  }

  // Function to decrement the quantity and update the total price
  void decrementQuantity( int  price ) {
    if (quantity.value > 1) {
      quantity.value--;
      totalBalance.value = price * quantity.value;
      update();
    }
  }
}
