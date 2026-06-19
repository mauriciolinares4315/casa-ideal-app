import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/product_card.dart';
import '../data/products_data.dart';
import '../models/product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Estado de búsqueda y filtro
  String _searchQuery = '';
  String _selectedCategory = 'Todos';

  // Contador del carrito (demo)
  int _cartCount = 0; // En una app real, vendría de un provider

  // Getter que filtra productos por búsqueda y categoría
  List<Product> get _filteredProducts {
    return kProducts.where((p) {
      final matchesSearch = p.name.toLowerCase().contains(
        _searchQuery.toLowerCase(),
      );
      final matchesCategory =
          _selectedCategory == 'Todos' || p.category == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
  }

  // ----------------------- APP BAR -----------------------
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text('casaIdeal'),
      backgroundColor: const Color(0xFF795548),
      foregroundColor: Colors.white,
      elevation: 0,
      actions: [
        // Icono del carrito con badge
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.shopping_cart_outlined),
              onPressed: () => context.go('/cart'),
            ),
            if (_cartCount > 0)
              Positioned(
                right: 6,
                top: 6,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$_cartCount',
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  // ----------------------- BODY PRINCIPAL -----------------------
  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Campo de búsqueda
          _buildSearchField(),

          const SizedBox(height: 16),

          // 2. Banner destacado (PageView)
          _buildBannerCarousel(),

          const SizedBox(height: 16),

          // 3. Filtros de categoría (Chips)
          _buildCategoryFilter(),

          const SizedBox(height: 16),

          // 4. Grid de productos
          _buildProductGrid(),
        ],
      ),
    );
  }

  // ----------------------- CAMPO DE BÚSQUEDA -----------------------
  Widget _buildSearchField() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Buscar productos...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.grey[100],
      ),
      onChanged: (value) {
        setState(() {
          _searchQuery = value;
        });
      },
    );
  }

  // ----------------------- BANNER CON PAGEVIEW -----------------------
  Widget _buildBannerCarousel() {
    // Lista de imágenes de banner (puedes poner URLs reales)
    final List<String> bannerImages = [
      'https://picsum.photos/seed/banner1/800/300',
      'https://picsum.photos/seed/banner2/800/300',
      'https://picsum.photos/seed/banner3/800/300',
    ];

    return SizedBox(
      height: 150,
      child: PageView.builder(
        itemCount: bannerImages.length,
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              bannerImages[index],
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          );
        },
      ),
    );
  }

  // ----------------------- FILTROS (CHIPS) -----------------------
  Widget _buildCategoryFilter() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: kCategories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final cat = kCategories[index];
          final isSelected = cat == _selectedCategory;
          return FilterChip(
            label: Text(cat),
            selected: isSelected,
            onSelected: (_) {
              setState(() {
                _selectedCategory = cat;
              });
            },
            backgroundColor: Colors.grey[200],
            selectedColor: const Color(0xFF795548).withOpacity(0.2),
            labelStyle: TextStyle(
              color: isSelected ? const Color(0xFF795548) : Colors.black87,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: isSelected
                    ? const Color(0xFF795548)
                    : Colors.transparent,
              ),
            ),
          );
        },
      ),
    );
  }

  // ----------------------- GRID DE PRODUCTOS -----------------------
  Widget _buildProductGrid() {
    if (_filteredProducts.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(40),
          child: Text('No se encontraron productos'),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics:
          const NeverScrollableScrollPhysics(), // Para que no haya scroll interno
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: _filteredProducts.length,
      itemBuilder: (context, index) {
        final product = _filteredProducts[index];
        return ProductCard(
          product: product,
          onTap: () => context.go('/product/${product.id}'),
        );
      },
    );
  }
}
