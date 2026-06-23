import 'package:flutter/material.dart';

class BannerCarousel extends StatefulWidget {
  const BannerCarousel({super.key});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  // Controlador para el PageView
  final PageController _controller = PageController();

  // Índice del banner actual
  int _current = 0;

  // Lista de URLs de los banners
  final List<String> _banners = const [
    'https://images.pexels.com/photos/12277201/pexels-photo-12277201.jpeg',
    'https://images.pexels.com/photos/12277021/pexels-photo-12277021.jpeg',
    'https://images.pexels.com/photos/6480707/pexels-photo-6480707.jpeg',
  ];

  @override
  void initState() {
    super.initState();
    // Auto-play cada 4 segundos
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 4));
      if (!mounted) return false;
      if (_controller.hasClients) {
        final next = (_current + 1) % _banners.length;
        _controller.animateToPage(
          next,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
      return true;
    });
  }

  @override
  void dispose() {
    // Liberar el controlador para evitar fugas de memoria
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Carrusel de imágenes
        SizedBox(
          height: 160,
          child: PageView.builder(
            controller: _controller,
            itemCount: _banners.length,
            onPageChanged: (i) => setState(() => _current = i),
            itemBuilder: (_, i) => ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                _banners[i],
                fit: BoxFit.cover,
                alignment: Alignment.bottomCenter,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.broken_image, size: 40),
                  );
                },
              ),
            ),
          ),
        ),
        // Indicadores de página (puntitos animados)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _banners.length,
            (i) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              width: _current == i ? 20 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: _current == i
                    ? const Color(0xFF795548) // Color primario
                    : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
