import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductProvider with ChangeNotifier {
  static final List<Product> _initialProducts = [
    Product(
      id: '1',
      name: 'EMF Protection Bracelet',
      description: 'Protect yourself from harmful EMF radiations with style.',
      price: 69.99,
      imageUrl: 'assets/images/4a5c4841b89bcf473297d55cfab5921813fcdd7e.png',
      rating: 4.5,
      reviews: 124,
      category: 'EMF PROTECTION BRACELET',
    ),
    Product(
      id: '2',
      name: 'Safe Connect Card',
      description: 'Portable EMF protection for your daily life.',
      price: 45.0,
      imageUrl: 'assets/images/4072a4fc66fffc695857f11b5d5e4248b8ccd969.png',
      rating: 4.8,
      reviews: 89,
      category: 'DEVICE PROTECTION',
    ),
    Product(
      id: '3',
      name: 'Smart Health Watch',
      description: 'Track your health vital signs 24/7 with EMF shielding.',
      price: 120.0,
      imageUrl: 'assets/images/7400129200bb9ac8a8e57e2c1bda0d596cf56f84.png',
      rating: 4.9,
      reviews: 210,
      category: 'SMART WATCH & FITNESS',
    ),
    Product(
      id: '4',
      name: 'EMF Shield Necklace',
      description: 'Elegant protection for your heart and soul.',
      price: 55.0,
      imageUrl: 'assets/images/6ceb8d45a173dd80e3ab2296ac9207fb2a971b22.png',
      rating: 4.7,
      reviews: 56,
      category: 'EMF PROTECTION NECKLACES & PENDANTS',
    ),
    Product(
      id: '5',
      name: 'Safe Connect Laser',
      description: 'Advanced technology for localized protection.',
      price: 85.0,
      imageUrl: 'assets/images/9d8dedc1bc686b97f9477829f3102ba2166dd308.png',
      rating: 4.6,
      reviews: 78,
      category: 'DEVICE PROTECTION',
    ),
  ];

  static final List<Category> _initialCategories = [
    Category(
      id: '1', 
      name: 'DEVICE PROTECTION', 
      iconUrl: 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?q=80&w=2080&auto=format&fit=crop',
    ),
    Category(
      id: '2', 
      name: 'EMF PROTECTION BRACELET', 
      iconUrl: 'https://images.unsplash.com/photo-1611591437281-460bfbe1220a?q=80&w=2070&auto=format&fit=crop',
    ),
    Category(
      id: '3', 
      name: 'EMF PROTECTION NECKLACES & PENDANTS', 
      iconUrl: 'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?q=80&w=2070&auto=format&fit=crop',
    ),
    Category(
      id: '4', 
      name: 'HEALTH PRODUCTS', 
      iconUrl: 'https://images.unsplash.com/photo-1506126613408-eca07ce68773?q=80&w=2070&auto=format&fit=crop',
    ),
    Category(
      id: '5', 
      name: 'SMART WATCH & FITNESS', 
      iconUrl: 'https://images.unsplash.com/photo-1557438159-51eec7a6c9e8?q=80&w=2070&auto=format&fit=crop',
    ),
    Category(
      id: '6', 
      name: 'KIDS & PETS', 
      iconUrl: 'https://images.unsplash.com/photo-1601758228041-f3b2795255f1?q=80&w=2070&auto=format&fit=crop',
    ),
  ];

  List<Product> _allProducts = [];
  List<Category> _categories = [];
  String _selectedCategory = 'All';
  String _searchQuery = '';
  List<Product> _filteredProducts = [];

  ProductProvider() {
    _allProducts = List.from(_initialProducts);
    _categories = List.from(_initialCategories);
    _filterProducts();
  }

  void _filterProducts() {
    List<Product> filtered = List.from(_allProducts);
    
    if (_selectedCategory != 'All') {
      filtered = filtered.where((p) => p.category == _selectedCategory).toList();
    }
    
    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      filtered = filtered.where((p) => 
        p.name.toLowerCase().contains(query) ||
        p.description.toLowerCase().contains(query) ||
        p.category.toLowerCase().contains(query)
      ).toList();
    }
    _filteredProducts = filtered;
  }

  List<Product> get products => _filteredProducts;
  List<Category> get categories => _categories;
  String get selectedCategory => _selectedCategory;

  void setCategory(String category) {
    if (_selectedCategory != category) {
      _selectedCategory = category;
      _filterProducts();
      notifyListeners();
    }
  }

  void setSearchQuery(String query) {
    if (_searchQuery != query) {
      _searchQuery = query;
      _filterProducts();
      notifyListeners();
    }
  }

  Future<void> fetchProducts() async {
    // Simulating API fetch
    _filterProducts();
    notifyListeners();
  }

  void addProduct(Product product) {
    _allProducts.insert(0, product);
    _filterProducts();
    notifyListeners();
  }

  void updateProduct(Product product) {
    final index = _allProducts.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      _allProducts[index] = product;
      _filterProducts();
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    _allProducts.removeWhere((p) => p.id == id);
    _filterProducts();
    notifyListeners();
  }
}


