import 'package:catalog/models/product_model.dart';
import 'package:flutter/material.dart';

final cartStateNotifier = CartState();
final wishlistStateNotifier = WishlistState();

class WishlistState extends ChangeNotifier {
  final List<ProductModel> _wishListProducts = [];

  List<ProductModel> get wishlistProducts => _wishListProducts.toList();

  void addToWishList(ProductModel product) {
    _wishListProducts.add(product);
    notifyListeners();
  }

  void removeFromWishList(ProductModel product) {
    _wishListProducts.remove(product);
    notifyListeners();
  }

  int get wishListLength => _wishListProducts.length;
}

class CartState extends ChangeNotifier {
  final List<ProductModel> _cartProducts = [];

  List<ProductModel> get cartProducts => _cartProducts.toList();
  double get cartPrice => totalPrice();
  double totalPrice(){
    double total = 0;
    for(int i = 0; i < _cartProducts.length ; i++){
      total = total + (_cartProducts[i].price ?? 0);
    } 
    return total;
  }



  int checkIfPresentViaId(ProductModel product) {
    for (int i = 0; i < _cartProducts.length; i++) {
      if (product.id == _cartProducts[i].id) {
        return i;
      }
    }
    return -1;
  }

  void addToCart(ProductModel product) {
    int toAdd = checkIfPresentViaId(product);
    // print('toAdd: $toAdd');
    if (toAdd == -1) {
      _cartProducts
          .add(product.copyWith(quantity: (product.quantity ?? 0) + 1));
      notifyListeners();
      return;
    }

    final ProductModel productFromStore = _cartProducts[toAdd];
    _cartProducts[toAdd] = productFromStore.copyWith(
        quantity: (productFromStore.quantity ?? 0) + 1);

    notifyListeners();
  }

  void removeFromCart(ProductModel product) {
    int toAdd = checkIfPresentViaId(product);

    if (product.quantity == 0 || product.quantity == null) {
      print('Error: qty should never be zero of supplied prod to remove.');
      return;
    }
    if (toAdd == -1) {
      print('Error: no stuff to remove. Not found in DB');
    } else {
      final ProductModel productFromStore = _cartProducts[toAdd];

      if (productFromStore.quantity == 1) {
        _cartProducts.removeAt(toAdd);
      } else {
        _cartProducts[toAdd] = productFromStore.copyWith(
            quantity: (productFromStore.quantity!) - 1);
      }
    }

    notifyListeners();
  }
}
