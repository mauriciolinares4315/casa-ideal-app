import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/router.dart';
import 'config/theme.dart';
import 'providers/cart_provider.dart';

void main() => runApp(const casaIdeal());

class casaIdeal extends StatelessWidget {
  const casaIdeal({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: MaterialApp.router(
        title: 'Casa Ideal',           
        theme: AppTheme.theme,
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}