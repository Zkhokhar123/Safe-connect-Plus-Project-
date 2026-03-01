import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/wishlist_provider.dart';


import '../models/product_model.dart';
import '../core/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import '../screens/product_details_screen.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(product: product),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Container
          AspectRatio(
            aspectRatio: 1.0,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF3F3F3), // Neutral grey background from Figma
                borderRadius: BorderRadius.circular(24),
              ),
              child: Stack(
                children: [
                  // Product Image
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: product.imageUrl.startsWith('assets/')
                          ? Image.asset(
                              product.imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.image_not_supported, color: Colors.grey),
                            )
                          : CachedNetworkImage(
                              imageUrl: product.imageUrl,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.image_not_supported, color: Colors.grey),
                            ),
                    ),
                  ),
                  // Favorite Button (Top Right - Heart)
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Consumer<WishlistProvider>(
                      builder: (context, wishlist, child) {
                        final isFavorite = wishlist.isFavorite(product.id);
                        return GestureDetector(
                          onTap: () {
                            wishlist.toggleWishlist(product);
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(isFavorite ? 'Removed from Wishlist' : 'Added to Wishlist'),
                                duration: const Duration(seconds: 1),
                                backgroundColor: isFavorite ? Colors.grey : AppColors.primary,
                              ),
                            );
                          },
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            size: 24,
                            color: AppColors.primary,
                          ),
                        );
                      },
                    ),
                  ),
                  // Cart Button (Bottom Right - Circular Black)
                  Positioned(
                    bottom: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.local_mall_outlined,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Product Info
          Text(
            product.name.toUpperCase(),
            style: GoogleFonts.bebasNeue(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black,
              letterSpacing: 0.5,
              height: 1.1,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            '\$${product.price.toStringAsFixed(2)}',
            style: GoogleFonts.bebasNeue(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: AppColors.primary, // Orange Color
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

