import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/cart_item.dart';

class CartProvider extends ChangeNotifier {
  final Map<String, CartItem> _items = {};

  // Getters
  Map<String, CartItem> get items => {..._items};
  int get itemCount => _items.values.fold(0, (sum, i) => sum + i.quantity);
  double get totalPrice => _items.values.fold(0, (sum, i) => sum + i.subtotal);

  // Agregar producto
  void addProduct(Product product, {int quantity = 1}) {
    if (_items.containsKey(product.id)) {
      _items[product.id]!.quantity += quantity;
    } else {
      _items[product.id] = CartItem(product: product, quantity: quantity);
    }
    notifyListeners();
  }

  // Quitar una unidad
  void removeOne(String productId) {
    if (!_items.containsKey(productId)) return;
    if (_items[productId]!.quantity > 1) {
      _items[productId]!.quantity--;
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  // Eliminar producto completo
  void removeProduct(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  // Vaciar carrito
  void clear() {
    _items.clear();
    notifyListeners();
  }

  // Verificar si un producto está en el carrito
  bool contains(String productId) => _items.containsKey(productId);
}
