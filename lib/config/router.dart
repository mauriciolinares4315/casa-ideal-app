import 'package:go_router/go_router.dart';
import '../screens/login_screen.dart';
import '../screens/home_screen.dart';
import '../screens/product_detail_screen.dart';
import '../screens/cart_screen.dart';
import '../screens/profile_screen.dart';
import '../data/products_data.dart';

final router = GoRouter(
  routes: [
    // ⭐ Ruta raíz → Login
    GoRoute(path: '/', builder: (_, __) => const LoginScreen()),
    GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
    GoRoute(
      path: '/product/:id',
      builder: (_, state) {
        final id = state.pathParameters['id']!;
        final product = kProducts.firstWhere((p) => p.id.toString() == id);
        return ProductDetailScreen(product: product);
      },
    ),
    GoRoute(path: '/cart', builder: (_, __) => const CartScreen()),
    GoRoute(path: '/profile', builder: (_, __) => const ProfileScreen()),
  ],
);
