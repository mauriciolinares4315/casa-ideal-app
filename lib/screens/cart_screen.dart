import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../models/product.dart';
import '../models/cart_item.dart';
import '../config/theme.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Consumer<CartProvider>(
        builder: (context, cart, _) {
          
          if (cart.items.isEmpty) {
            return _buildEmptyCart(context);
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    
                    final cartItem = cart.items[index];
                    return Dismissible(
                      
                      key: Key(cartItem.product.id.toString()),
                      direction: DismissDirection.endToStart,
                      background: _buildDismissibleBackground(),
                      onDismissed: (_) {
                        final product = cartItem.product;
                        final quantity = cartItem.quantity;
                        
                        cart.removeItem(product.id.toString());
                        _showUndoSnackBar(context, product, quantity, cart);
                      },
                      child: CartItemTile(cartItem: cartItem),
                    );
                  },
                ),
              ),
              _buildCheckoutSection(context, cart),
            ],
          );
        },
      ),
    );
  }

  // ---------- APP BAR ----------
  AppBar _buildAppBar(BuildContext context) {
  return AppBar(
    title: const Text('Mi Carrito'),
    backgroundColor: AppTheme.primaryColor,
    foregroundColor: Colors.white,
    elevation: 0,
    actions: [
      // ⭐ NUEVO: Botón para ir a la tienda
      IconButton(
        icon: const Icon(Icons.storefront_outlined),
        onPressed: () => context.go('/home'),
        tooltip: 'Seguir comprando',
      ),
      // Botón para vaciar carrito
      IconButton(
        icon: const Icon(Icons.delete_outline),
        onPressed: () {
          final cart = context.read<CartProvider>();
          if (cart.items.isNotEmpty) {
            _showClearCartDialog(context, cart);
          }
        },
      ),
    ],
  );
}

  // ---------- CARRITO VACÍO ----------
  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'Tu carrito está vacío',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Explora nuestros productos y agrega lo que te guste',
            style: TextStyle(color: Colors.grey[500]),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => context.go('/home'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.white,
            ),
            child: const Text('Ir a la tienda'),
          ),
        ],
      ),
    );
  }

  // ---------- FONDO DEL DISMISSIBLE ----------
  Widget _buildDismissibleBackground() {
    return Container(
      color: Colors.red,
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20),
      child: const Icon(Icons.delete, color: Colors.white, size: 32),
    );
  }

  // ---------- SNACKBAR CON DESHACER ----------
  void _showUndoSnackBar(
    BuildContext context,
    Product product,
    int quantity,
    CartProvider cart,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} eliminado'),
        action: SnackBarAction(
          label: 'Deshacer',
          onPressed: () {
            cart.addItem(product, quantity);
          },
        ),
      ),
    );
  }

  // ---------- DIÁLOGO PARA VACIAR EL CARRITO ----------
  void _showClearCartDialog(BuildContext context, CartProvider cart) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Vaciar carrito'),
        content: const Text(
          '¿Estás seguro de que quieres eliminar todos los productos?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              cart.clear();
              Navigator.pop(context);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Carrito vaciado')));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Vaciar'),
          ),
        ],
      ),
    );
  }

  // ---------- SECCIÓN DE RESUMEN Y CHECKOUT ----------
  Widget _buildCheckoutSection(BuildContext context, CartProvider cart) {
    final subtotal = cart.items.fold(
      0.0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );
    final shipping = (subtotal >= 500000) ? 0.0 : 5000.0;
    final total = subtotal + shipping;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildPriceRow('Subtotal', subtotal),
          const SizedBox(height: 4),
          _buildPriceRow('Envío', shipping),
          const Divider(height: 24, thickness: 1),
          _buildPriceRow('TOTAL', total, isTotal: true),
          const SizedBox(height: 16),

// ⭐ Dos botones: "Seguir comprando" y "Finalizar compra"
Row(
  children: [
    // Botón "Seguir comprando"
    Expanded(
      child: OutlinedButton(
        onPressed: () => context.go('/home'),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppTheme.primaryColor,
          side: const BorderSide(color: AppTheme.primaryColor),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        child: const Text('Seguir comprando'),
      ),
    ),
    const SizedBox(width: 12),
    // Botón "Finalizar compra"
    Expanded(
      child: ElevatedButton(
        onPressed: () => _onCheckout(context, cart, total),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        child: const Text('Finalizar compra'),
      ),
    ),
  ],
),
        ],
      ),
    );
  }

  // ---------- FILA DE PRECIO ----------
  Widget _buildPriceRow(String label, double value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          '\$${value.toStringAsFixed(0)}',
          style: TextStyle(
            fontSize: isTotal ? 20 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? AppTheme.primaryColor : null,
          ),
        ),
      ],
    );
  }

  // ---------- DIÁLOGO DE CONFIRMACIÓN DE COMPRA ----------
  void _onCheckout(BuildContext context, CartProvider cart, double total) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Confirmar pedido'),
        content: Text(
          '¿Confirmas tu pedido por '
          '\$${total.toStringAsFixed(0)}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              cart.clear();
              Navigator.pop(context);
              context.go('/home');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('¡Pedido confirmado! 🎉'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.white,
            ),
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// WIDGET: ITEM DEL CARRITO
// ============================================================
class CartItemTile extends StatelessWidget {
  final CartItem cartItem;

  const CartItemTile({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final product = cartItem.product;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Imagen del producto
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                product.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey[200],
                  child: const Icon(Icons.image_not_supported),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Información del producto
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${product.price.toStringAsFixed(0)}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  // Botones de cantidad
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: () {
                          final provider = context.read<CartProvider>();
                          final currentQty = cartItem.quantity;
                          // ✅ CORREGIDO: reducir cantidad o eliminar
                          if (currentQty > 1) {
                            provider.updateQuantity(
                              product.id.toString(),
                              currentQty - 1,
                            );
                          } else {
                            provider.removeItem(product.id.toString());
                          }
                        },
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.zero,
                        iconSize: 28,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${cartItem.quantity}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline),
                        onPressed: () {
                          // ✅ CORREGIDO: añadir 1 unidad
                          context.read<CartProvider>().addItem(product, 1);
                        },
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.zero,
                        iconSize: 28,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Precio total del item
            Text(
              '\$${(product.price * cartItem.quantity).toStringAsFixed(0)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppTheme.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
