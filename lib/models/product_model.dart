class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final double rating;
  final int reviews;
  final String category;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.reviews,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'rating': rating,
      'reviews': reviews,
      'category': category,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map, String id) {
    return Product(
      id: id,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: (map['price'] ?? 0.0).toDouble(),
      imageUrl: map['imageUrl'] ?? '',
      rating: (map['rating'] ?? 0.0).toDouble(),
      reviews: map['reviews'] ?? 0,
      category: map['category'] ?? '',
    );
  }
}

class Category {
  final String id;
  final String name;
  final String iconUrl;

  Category({
    required this.id,
    required this.name,
    required this.iconUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'iconUrl': iconUrl,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map, String id) {
    return Category(
      id: id,
      name: map['name'] ?? '',
      iconUrl: map['iconUrl'] ?? '',
    );
  }
}

final List<Category> mockCategories = [
  Category(id: '1', name: 'Device Protection', iconUrl: 'assets/icons/device.png'),
  Category(id: '2', name: 'EMF Protection Bracelets', iconUrl: 'assets/icons/bracelet.png'),
  Category(id: '3', name: 'EMF Protection Necklaces & Pendants', iconUrl: 'assets/icons/necklace.png'),
  Category(id: '4', name: 'Health Products', iconUrl: 'assets/icons/health.png'),
  Category(id: '5', name: 'Smart Watch & Fitness', iconUrl: 'assets/icons/watch.png'),
];

final List<Product> mockProducts = [
  Product(
    id: '1',
    name: 'EMF Protection Bracelet',
    description: 'Protect yourself from harmful EMF radiations with style.',
    price: 69.99,
    imageUrl: 'assets/images/4a5c4841b89bcf473297d55cfab5921813fcdd7e.png',
    rating: 4.5,
    reviews: 124,
    category: 'EMF Protection Bracelets',
  ),
  Product(
    id: '2',
    name: 'Safe Connect Card',
    description: 'Portable EMF protection for your daily life.',
    price: 45.0,
    imageUrl: 'assets/images/4072a4fc66fffc695857f11b5d5e4248b8ccd969.png',
    rating: 4.8,
    reviews: 89,
    category: 'Device Protection',
  ),
  Product(
    id: '3',
    name: 'Smart Health Watch',
    description: 'Track your health vital signs 24/7 with EMF shielding.',
    price: 120.0,
    imageUrl: 'assets/images/7400129200bb9ac8a8e57e2c1bda0d596cf56f84.png',
    rating: 4.9,
    reviews: 210,
    category: 'Smart Watch & Fitness',
  ),
  Product(
    id: '4',
    name: 'EMF Shield Necklace',
    description: 'Elegant protection for your heart and soul.',
    price: 55.0,
    imageUrl: 'assets/images/6ceb8d45a173dd80e3ab2296ac9207fb2a971b22.png',
    rating: 4.7,
    reviews: 56,
    category: 'EMF Protection Necklaces & Pendants',
  ),
  Product(
    id: '5',
    name: 'Safe Connect Laser',
    description: 'Advanced technology for localized protection.',
    price: 85.0,
    imageUrl: 'assets/images/9d8dedc1bc686b97f9477829f3102ba2166dd308.png',
    rating: 4.6,
    reviews: 78,
    category: 'Device Protection',
  ),
];
