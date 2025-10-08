import 'package:flutter/foundation.dart';

@immutable
class VendorPhotoResource {
  const VendorPhotoResource(this.url);

  final String url;
}

@immutable
class VendorMenuItem {
  const VendorMenuItem({
    required this.name,
    required this.description,
    required this.price,
    this.tag,
    this.imageUrl,
  });

  final String name;
  final String description;
  final String price;
  final String? tag;
  final String? imageUrl;
}

@immutable
class VendorMenuCategory {
  const VendorMenuCategory({
    required this.title,
    required this.items,
  });

  final String title;
  final List<VendorMenuItem> items;
}

const vendorPhotoGallery = <VendorPhotoResource>[
  VendorPhotoResource(
    'https://images.unsplash.com/photo-1504753793650-d4a2b783c15e'
    '?auto=format&fit=crop&w=1200&q=80',
  ),
  VendorPhotoResource(
    'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4'
    '?auto=format&fit=crop&w=1200&q=80',
  ),
  VendorPhotoResource(
    'https://images.unsplash.com/photo-1466978913421-dad2ebd01d17'
    '?auto=format&fit=crop&w=1200&q=80',
  ),
  VendorPhotoResource(
    'https://images.unsplash.com/photo-1504674900247-0877df9cc836'
    '?auto=format&fit=crop&w=1200&q=80',
  ),
  VendorPhotoResource(
    'https://images.unsplash.com/photo-1525610553991-2bede1a236e2'
    '?auto=format&fit=crop&w=1200&q=80',
  ),
  VendorPhotoResource(
    'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe'
    '?auto=format&fit=crop&w=1200&q=80',
  ),
];

const vendorMenuCategories = <VendorMenuCategory>[
  VendorMenuCategory(
    title: 'Starters',
    items: [
      VendorMenuItem(
        name: 'Garlic Prawns',
        description:
            'Sautéed prawns with garlic butter, chili, and toasted sourdough.',
        price: '£8.50',
        tag: 'Popular',
        imageUrl:
            'https://images.unsplash.com/photo-1504753793650-d4a2b783c15e'
            '?auto=format&fit=crop&w=800&q=80',
      ),
      VendorMenuItem(
        name: 'Truffle Arancini',
        description:
            'Crispy risotto balls filled with smoked mozzarella and '
            'truffle aioli.',
        price: '£7.20',
        imageUrl:
            'https://images.unsplash.com/photo-1525610553991-2bede1a236e2'
            '?auto=format&fit=crop&w=800&q=80',
      ),
      VendorMenuItem(
        name: 'Seasonal Soup',
        description:
            'Chef-selected vegetables simmered with herbs and finished '
            'with cream.',
        price: '£5.90',
      ),
    ],
  ),
  VendorMenuCategory(
    title: 'Mains',
    items: [
      VendorMenuItem(
        name: 'Seared Sea Bass',
        description:
            'Pan-seared sea bass with fennel salad, citrus beurre blanc, '
            'and charred lemon.',
        price: '£16.40',
        imageUrl:
            'https://images.unsplash.com/photo-1504674900247-0877df9cc836'
            '?auto=format&fit=crop&w=800&q=80',
      ),
      VendorMenuItem(
        name: 'Charred Ribeye',
        description:
            '12oz ribeye grilled to order, served with chimichurri and '
            'rosemary potatoes.',
        price: '£21.00',
        tag: "Chef's special",
        imageUrl:
            'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4'
            '?auto=format&fit=crop&w=800&q=80',
      ),
      VendorMenuItem(
        name: 'Wild Mushroom Risotto',
        description:
            'Creamy arborio rice with porcini, pecorino, and crispy sage.',
        price: '£14.30',
      ),
    ],
  ),
  VendorMenuCategory(
    title: 'Desserts',
    items: [
      VendorMenuItem(
        name: 'Lemon Tart',
        description:
            'Bright lemon curd in a buttery crust with vanilla bean cream.',
        price: '£6.50',
        imageUrl:
            'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe'
            '?auto=format&fit=crop&w=800&q=80',
      ),
      VendorMenuItem(
        name: 'Chocolate Fondant',
        description:
            'Warm dark chocolate cake with molten center and salted '
            'caramel ice cream.',
        price: '£6.90',
      ),
      VendorMenuItem(
        name: 'Vanilla Bean Cheesecake',
        description:
            'Baked cheesecake layered with berry compote and almond crumble.',
        price: '£6.20',
        tag: 'New',
      ),
    ],
  ),
  VendorMenuCategory(
    title: 'Drinks',
    items: [
      VendorMenuItem(
        name: 'House Lemonade',
        description: 'Fresh lemons, agave, and mint over crushed ice.',
        price: '£3.80',
      ),
      VendorMenuItem(
        name: 'Berry Spritz',
        description:
            'Sparkling hibiscus, seasonal berries, and citrus bitters.',
        price: '£4.50',
      ),
      VendorMenuItem(
        name: 'Cold Brew Coffee',
        description: '24-hour steeped beans over clear ice with orange zest.',
        price: '£3.60',
      ),
    ],
  ),
];
