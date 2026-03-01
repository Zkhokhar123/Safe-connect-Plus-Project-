import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme.dart';
import '../providers/product_provider.dart';
import '../widgets/product_card.dart';

class ProductListingScreen extends StatefulWidget {
  final String? categoryName;
  const ProductListingScreen({super.key, this.categoryName});

  @override
  State<ProductListingScreen> createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  String _selectedFilter = 'All Product';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.categoryName?.toUpperCase() ?? 'PRODUCTS',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w900,
            letterSpacing: 1,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, _) {
          // Set category if provided
          if (widget.categoryName != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              productProvider.setCategory(widget.categoryName!);
            });
          }

          final products = productProvider.products;

          return Column(
            children: [
              // Filter Dropdown (Figma Style)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'All Product',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      PopupMenuButton<String>(
                        icon: const Icon(Icons.arrow_drop_down, color: Colors.black87),
                        onSelected: (value) {
                          setState(() {
                            _selectedFilter = value;
                          });
                          // Apply filter logic here if needed
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(value: 'All Product', child: Text('All Product')),
                          const PopupMenuItem(value: 'Price: Low to High', child: Text('Price: Low to High')),
                          const PopupMenuItem(value: 'Price: High to Low', child: Text('Price: High to Low')),
                          const PopupMenuItem(value: 'Rating', child: Text('Rating')),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Products Grid
              Expanded(
                child: products.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.inventory_2_outlined, size: 80, color: Colors.grey),
                            SizedBox(height: 16),
                            Text(
                              'No products found',
                              style: TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                          ],
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          return ProductCard(product: products[index]);
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
