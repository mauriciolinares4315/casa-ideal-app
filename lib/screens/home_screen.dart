import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/product_card.dart';
import '../widgets/banner_carousel.dart';
import '../data/products_data.dart';
import '../models/product.dart';
import '../config/theme.dart';
  

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Estado de búsqueda y filtr
  String _searchQuery = '';
  String _selectedCategory = 'Todos';

  // Contador del carrito (demo)
  final _cartCount = 0; // En una app real, vendría de un provider

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
      backgroundColor:AppTheme.primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
      actions: [
        // Ícono de perfil (nuevo)
      IconButton(
        icon: const Icon(Icons.person_outline),
        onPressed: () => context.go('/profile'),
      ),
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
  return RefreshIndicator(
    onRefresh: () async {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        _searchQuery = '';
        _selectedCategory = 'Todos';
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Productos actualizados'),
            duration: Duration(seconds: 1),
          ),
        );
      }
    },
    child: SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(), // Obligatorio para RefreshIndicator
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchField(),
          const SizedBox(height: 16),
          _buildBannerCarousel(),
          const SizedBox(height: 16),
          _buildCategoryFilter(),
          const SizedBox(height: 16),
          _buildProductGrid(),
        ],
      ),
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
  return const BannerCarousel(); // ← Usa el widget reutilizable
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
            selectedColor:AppTheme.primaryColor.withOpacity(0.2),
            labelStyle: TextStyle(
              color: isSelected ? AppTheme.primaryColor : Colors.black87,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: isSelected
                    ? AppTheme.primaryColor
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 60, color: Colors.grey),
          SizedBox(height: 12),
          Text(
            'Sin resultados para tu búsqueda',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          SizedBox(height: 8),
          Text(
            'Prueba con otras palabras',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
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
