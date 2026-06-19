import 'package:go_router/go_router.dart';
import '../screens/login_screen.dart';
import '../screens/home_screen.dart';
import '../screens/product_detail_screen.dart';
import '../screens/cart_screen.dart';
import '../data/products_data.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/product/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        final product = kProducts.firstWhere(
          (p) => p.id == id,
          orElse: () => throw Exception('Producto no encontrado'),
        );
        return ProductDetailScreen(product: product);
      },
    ),
    GoRoute(path: '/cart', builder: (context, state) => const CartScreen()),
  ],
);
