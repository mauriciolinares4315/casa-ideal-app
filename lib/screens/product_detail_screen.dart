import 'package:flutter/material.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart'; // Asumiendo que usas ChangeNotifier
import 'package:provider/provider.dart'; // Si usas Provider

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        backgroundColor: const Color(0xFF795548),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ------------------ IMAGEN CON STACK Y HERO ------------------
            Stack(
              children: [
                // Hero para transición suave desde la Home
                Hero(
                  tag: 'product_${product.id}',
                  child: Image.network(
                    product.imageUrl,
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                // Badge de "Nuevo" o "Oferta" usando Positioned
                Positioned(
                  top: 16,
                  right: 16,
                  child: Chip(
                    label: const Text('NUEVO'),
                    backgroundColor: Colors.green,
                    labelStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),

            // ------------------ CONTENIDO DE TEXTO ------------------
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nombre
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Categoría
                  Chip(
                    label: Text(product.category),
                    backgroundColor: const Color(0xFF795548).withOpacity(0.1),
                    labelStyle: const TextStyle(color: Color(0xFF795548)),
                  ),
                  const SizedBox(height: 12),

                  // Precio formateado
                  Text(
                    '\$${product.price.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}',
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF795548),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Rating con estrellas
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        product.rating.toString(),
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '(${product.reviewCount} reseñas)',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Divisor
                  const Divider(thickness: 1, color: Colors.grey),

                  // Descripción
                  const SizedBox(height: 16),
                  const Text(
                    'Descripción del producto',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: const TextStyle(fontSize: 15, height: 1.5),
                  ),
                  const SizedBox(height: 24),

                  // ------------------ SELECTOR DE CANTIDAD ------------------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: _quantity > 1
                            ? () => setState(() => _quantity--)
                            : null,
                        icon: const Icon(Icons.remove_circle_outline),
                        color: const Color(0xFF795548),
                        iconSize: 32,
                      ),
                      Text(
                        '$_quantity',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () => setState(() => _quantity++),
                        icon: const Icon(Icons.add_circle_outline),
                        color: const Color(0xFF795548),
                        iconSize: 32,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // ------------------ BOTÓN AGREGAR AL CARRITO ------------------
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Agregar al carrito usando el provider
                        final cartProvider = Provider.of<CartProvider>(
                          context,
                          listen: false,
                        );
                        cartProvider.addItem(product, _quantity);

                        // Mostrar feedback
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Producto agregado al carrito'),
                            backgroundColor: Colors.green,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF795548),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(fontSize: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Agregar al carrito'),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // ------------------ INFORMACIÓN ADICIONAL ------------------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildInfoChip(Icons.local_shipping, 'Envío gratis'),
                      _buildInfoChip(Icons.verified, 'Garantía 1 año'),
                      _buildInfoChip(Icons.credit_card, 'Pago seguro'),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget auxiliar para los chips de información
  Widget _buildInfoChip(IconData icon, String label) {
    return Chip(
      avatar: Icon(icon, size: 16, color: const Color(0xFF795548)),
      label: Text(label, style: const TextStyle(fontSize: 12)),
      backgroundColor: Colors.grey[100],
      padding: const EdgeInsets.symmetric(horizontal: 4),
    );
  }
}
