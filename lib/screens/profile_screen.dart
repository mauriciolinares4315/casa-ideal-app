import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/cart_provider.dart';
import '../providers/theme_provider.dart'; // 👈 Importar
import '../config/theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notificaciones = true;
  bool _ofertas = false;

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>(); // 👈 Escuchar cambios

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi perfil'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        children: [
          // ... avatar, email, etc ...
          const Divider(),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 0, 0),
            child: Text(
              'PREFERENCIAS',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
          SwitchListTile(
            title: const Text('Notificaciones'),
            subtitle: const Text('Recibir alertas de pedidos'),
            value: _notificaciones,
            onChanged: (v) => setState(() => _notificaciones = v),
          ),
          SwitchListTile(
            title: const Text('Ofertas y promociones'),
            value: _ofertas,
            onChanged: (v) => setState(() => _ofertas = v),
          ),
          // ⭐ Switch de modo oscuro conectado
          SwitchListTile(
            title: const Text('Modo oscuro'),
            subtitle: const Text('Cambiar tema de la app'),
            value: themeProvider.isDarkMode,
            onChanged: (_) => themeProvider.toggleTheme(),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              'Cerrar sesión',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              context.read<CartProvider>().clear();
              context.go('/login');
            },
          ),
        ],
      ),
    );
  }
}