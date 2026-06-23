import '../models/product.dart';

final List<Product> kProducts = [
  Product(
    id: '1',
    name: 'Sofá Modular Tela Beige 3 Cuerpos',
    description:
        'Elegante sofá modular tapizado en tela antimanchas color beige. Incluye 3 módulos independientes que puedes acomodar en L, recto o isla. Perfecto para salas modernas y acogedoras.',
    price: 2499000,
    imageUrl:
        'https://images.pexels.com/photos/7160605/pexels-photo-7160605.jpeg',
    category: 'Sala',
    rating: 4.9,
    reviewCount: 312,
    isFeatured: true,
  ),
  Product(
    id: '2',
    name: 'Mesa de Centro Madera Maciza Roble',
    description:
        'Imponente mesa de centro fabricada en madera de roble macizo con acabado mate. Diseño nórdico con un amplio cajón oculto para control remoto y revistas. Medidas: 120x60x45 cm.',
    price: 879000,
    imageUrl:
        'https://mobel.store/cdn/shop/files/VLAC1858_mesa_de_centro_madera_maciza_roble_victoria_NS722MS.jpg?v=1773862477&width=900',
    category: 'Sala',
    rating: 4.7,
    reviewCount: 189,
    isFeatured: true,
  ),
  Product(
    id: '3',
    name: 'Lámpara de Pie Arco Minimalista',
    description:
        'Lámpara de pie con diseño de arco en acero cromado y pantalla de tela blanca. Aporta iluminación ambiental y un toque escultórico a cualquier rincón de tu sala o habitación.',
    price: 459000,
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_4R3ALJWPJx9aAqzE6c5rjP3yhPPOw9QIwSL5o-8NTZNmbg4wYU3ZG3Y&s=10',
    category: 'Iluminación',
    rating: 4.5,
    reviewCount: 94,
    isFeatured: true,
  ),
  Product(
    id: '4',
    name: 'Cama Queen Cabecera Tapizada en Lino',
    description:
        'Cama tamaño Queen con estructura robusta y cabecera tapizada en tela de lino natural. Incluye base de madera con patas de acero inoxidable. Ideal para un dormitorio cálido y elegante.',
    price: 3199000,
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAhrjJrvSFT8KQ6ot95EcSgrwJ7Y8GeJeryvXVeI39VxbZIFmbaJGpwh1X&s=10',
    category: 'Dormitorio',
    rating: 4.8,
    reviewCount: 256,
    isFeatured: true,
  ),
  Product(
    id: '5',
    name: 'Armario Ropero 4 Puertas Corredizas',
    description:
        'Ropero amplio con 4 puertas corredizas de vidrio esmerilado y marco en aluminio. Incluye 5 entrepaños, 2 barras colgadores y 3 cajones internos. Capacidad total de 2.10m de ancho.',
    price: 3899000,
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZz_ozWo3s71e-b1skVvuak752TEZoTw80PVJYzGgsH9oFJFI81PPqsaQg&s=10',
    category: 'Dormitorio',
    rating: 4.6,
    reviewCount: 173,
    isFeatured: true,
  ),
  Product(
    id: '6',
    name: 'Mesa Comedor Extensible 6 Puestos',
    description:
        'Mesa de comedor fabricada en MDF con revestimiento melamínico imitación mármol. Se extiende de 1.40m a 2.10m para recibir hasta 6 comensales. Patas en madera de pino sólido.',
    price: 1599000,
    imageUrl:
        'https://select.com.co/cdn/shop/files/mesa-5-2_1024x1024@2x.png?v=1760713646',
    category: 'Comedor',
    rating: 4.4,
    reviewCount: 145,
    isFeatured: true,
  ),
  Product(
    id: '7',
    name: 'Silla de Comedor Nórdica (Pack x 2)',
    description:
        'Pack de 2 sillas de comedor con asiento en madera curvada natural y estructura metálica en polvo color negro mate. Diseño escandinavo minimalista que combina con cualquier mesa.',
    price: 499000,
    imageUrl:
        'https://media.falabella.com/falabellaCO/154879823_01/w=1200,h=1200,fit=pad',
    category: 'Comedor',
    rating: 4.7,
    reviewCount: 208,
    isFeatured: true,
  ),
  Product(
    id: '8',
    name: 'Escritorio Ejecutivo con Cajonera',
    description:
        'Escritorio de oficina estilo ejecutivo en acabado nogal. Incluye cajonera lateral con 3 cajones (2 pequeños y 1 para archivo colgante). Superficie amplia de 1.40m.',
    price: 1499000,
    imageUrl: 'https://i.ebayimg.com/images/g/fKoAAeSw-~RqGBCK/s-l1200.webp',
    category: 'Oficina',
    rating: 4.3,
    reviewCount: 87,
    isFeatured: true,
  ),
  Product(
    id: '9',
    name: 'Estante Flotante Orgánico (Set 3 piezas)',
    description:
        'Set de 3 repisas flotantes de madera de teca con formas orgánicas irregulares. Perfectas para exhibir plantas, libros o fotografías, creando una pared con carácter y calidez.',
    price: 359000,
    imageUrl:
        'https://media.falabella.com/sodimacCO/3000836/w=1036,h=832,f=webp,fit=contain,q=85',
    category: 'Decoración',
    rating: 4.9,
    reviewCount: 367,
    isFeatured: true,
  ),
  Product(
    id: '10',
    name: 'Espejo de Cuerpo Entero Marco Madera',
    description:
        'Impresionante espejo de piso de 170x60 cm con marco en madera reciclada de pino con acabado envejecido. Ideal para entryways o habitaciones, da amplitud y luz al espacio.',
    price: 689000,
    imageUrl:
        'https://media.falabella.com/sodimacCO/695762/w=1036,h=832,f=webp,fit=contain,q=85',
    category: 'Decoración',
    rating: 4.8,
    reviewCount: 214,
    isFeatured: true,
  ),
  Product(
    id: '11',
    name: 'Cojines Decorativos Textura Tejida (Pack x 4)',
    description:
        'Pack de 4 cojines de 45x45 cm con funda en tela de algodón con textura tejida a mano y relleno hipoalergénico. Colores neutros (beige, gris, arena y blanco roto) para renovar tu sala.',
    price: 259000,
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSVWxWtod0VDya13cZUqGuUkavGpIJCw0IDl_clXaVskvoodpUn_IV8SJDs&s=10',
    category: 'Decoración',
    rating: 4.6,
    reviewCount: 431,
    isFeatured: true,
  ),
];

// Categorías únicas de tus productos
List<String> get kCategories => [
  'Todos',
  ...{...kProducts.map((p) => p.category)},
];
