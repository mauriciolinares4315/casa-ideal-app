import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/product.dart';
import '../models/cart_item.dart';

class CartProvider extends ChangeNotifier {
  List<CartItem> _items = [];

  List<CartItem> get items => _items;

  int get totalItems => _items.fold(0, (sum, item) => sum + item.quantity);

  int get totalPrice => _items.fold(
        0,
        (sum, item) => sum+(item.product.price * item.quantity),
      );

  // 👇 Cargar carrito al iniciar
  Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final String? cartJson = prefs.getString('cart');

    if (cartJson != null) {
      final List<dynamic> decoded = jsonDecode(cartJson);
      _items = decoded.map((item) {
        return CartItem.fromJson(item as Map<String, dynamic>);
      }).toList();
      notifyListeners();
    }
  }

  // 👇 Guardar carrito cada vez que cambia
  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final String cartJson = jsonEncode(_items.map((item) => item.toJson()).toList());
    await prefs.setString('cart', cartJson);
  }

  void addItem(Product product, int quantity) {
    final existingIndex = _items.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (existingIndex != -1) {
      _items[existingIndex] = CartItem(
        product: product,
        quantity: _items[existingIndex].quantity + quantity,
      );
    } else {
      _items.add(CartItem(product: product, quantity: quantity));
    }
    notifyListeners();
    _saveCart(); // ← Guardar después de cambiar
  }

  void removeItem(String productId) {
    _items.removeWhere((item) => item.product.id == productId);
    notifyListeners();
    _saveCart(); // ← Guardar después de cambiar
  }

  void updateQuantity(String productId, int newQuantity) {
    final index = _items.indexWhere((item) => item.product.id == productId);
    if (index != -1) {
      if (newQuantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index] = CartItem(
          product: _items[index].product,
          quantity: newQuantity,
        );
      }
      notifyListeners();
      _saveCart(); // ← Guardar después de cambiar
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
    _saveCart(); // ← Guardar después de cambiar
  }
}