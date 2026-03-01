import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../providers/wishlist_provider.dart';
import '../models/product_model.dart';
import '../core/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;
  const ProductDetailsScreen({super.key, required this.product});

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
        actions: [
          Consumer<WishlistProvider>(
            builder: (context, wishlist, child) {
              final isFav = wishlist.isFavorite(product.id);
              return IconButton(
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: isFav ? AppColors.primary : Colors.black,
                ),
                onPressed: () {
                  wishlist.toggleWishlist(product);
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(isFav ? 'Removed from Wishlist' : 'Added to Wishlist'),
                      duration: const Duration(seconds: 1),
                      backgroundColor: isFav ? Colors.grey : AppColors.primary,
                    ),
                  );
                },
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                Hero(
                  tag: 'product-${product.id}',
                  child: Stack(
                    children: [
                      Container(
                        height: 350,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: product.imageUrl.startsWith('assets/') 
                                ? AssetImage(product.imageUrl) as ImageProvider
                                : NetworkImage(product.imageUrl) as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Pagination Dots (Figma Style)
                      Positioned(
                        bottom: 20,
                        right: 24,
                        child: Row(
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.5),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.5),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Product Title & Rating
                Row(
                  children: [
                    ...List.generate(5, (index) => Icon(
                      Icons.star,
                      color: index < 4 ? Colors.amber : Colors.grey.shade300,
                      size: 20,
                    )),
                    const SizedBox(width: 8),
                    Text(
                      '(${product.rating})',
                      style: GoogleFonts.outfit(
                        color: Colors.black54,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        product.name.toUpperCase(),
                        style: GoogleFonts.bebasNeue(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                          height: 1.1,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: GoogleFonts.bebasNeue(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    ...List.generate(5, (index) => Icon(
                      Icons.star,
                      color: index < 4 ? Colors.amber : Colors.grey.shade300,
                      size: 16,
                    )),
                    const SizedBox(width: 8),
                    Text(
                      '${product.rating} (${product.reviews} Reviews)',
                      style: const TextStyle(color: Colors.black38, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'DESCRIPTIONS',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  product.description,
                  style: GoogleFonts.outfit(
                    color: Colors.black54,
                    fontSize: 14,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 24),
                // Specifications Section (Figma Style)
                const SizedBox(height: 24),
                Text(
                  'SPECIFICATIONS',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSpecItem('AVAILABILITY', 'In stock'),
                    _buildSpecItem('SKU', 'BD-BR-2009'),
                    _buildSpecItem('BRAND', 'Safe Connect Plus+'),
                  ],
                ),
                const SizedBox(height: 32),
                Text(
                  '1 REVIEWS FOR ${product.name.toUpperCase()}',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 16),
                _buildReviewCard('Theresa Webb', 'Jan 1, 2025', 'Cursus sit amet dictum sit amet justo donec enim. Commodo ullamcorper a lacus.'),
                const SizedBox(height: 24),
                // Add Review Section (Figma Style)
                const SizedBox(height: 32),
                Text(
                  'ADD A REVIEW',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildReviewField('Your Review *', maxLines: 4),
                    const SizedBox(height: 16),
                    _buildReviewField('Name *'),
                    const SizedBox(height: 16),
                    _buildReviewField('Email *'),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Text(
                          'Your Rating *',
                          style: GoogleFonts.outfit(fontSize: 14, color: Colors.black54),
                        ),
                        const SizedBox(width: 12),
                        ...List.generate(5, (index) => const Icon(
                          Icons.star_border,
                          color: AppColors.primary,
                          size: 20,
                        )),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: Checkbox(
                            value: false,
                            onChanged: (val) {},
                            side: const BorderSide(color: Colors.grey),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Save my name, email, and website in this browser for the next time I comment.',
                            style: TextStyle(fontSize: 11, color: Colors.black54),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(120, 48),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        side: const BorderSide(color: Colors.grey, width: 0.5),
                      ),
                      child: Text(
                        'SUBMIT',
                        style: GoogleFonts.bebasNeue(
                          color: Colors.black87,
                          fontSize: 18,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Related Products Section Header
                Row(
                  children: [
                    Container(
                      width: 4,
                      height: 30,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'RELATED PRODUCT',
                      style: GoogleFonts.bebasNeue(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const SizedBox(height: 16),
                SizedBox(
                  height: 280, // Increased height
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3, // Mocking 3 related items
                    itemBuilder: (context, index) {
                      return IntrinsicHeight(
                        child: Container(
                          width: 200,
                          margin: const EdgeInsets.only(right: 16, bottom: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Image with Heart Icon
                              Expanded(
                                flex: 3,
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                                      child: product.imageUrl.startsWith('assets/')
                                          ? Image.asset(
                                              product.imageUrl,
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                              height: double.infinity,
                                            )
                                          : CachedNetworkImage(
                                              imageUrl: product.imageUrl,
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                              height: double.infinity,
                                              errorWidget: (c, e, s) => const Icon(Icons.image_not_supported),
                                            ),
                                    ),
                                    Positioned(
                                      top: 12,
                                      right: 12,
                                      child: Icon(
                                        Icons.favorite,
                                        color: AppColors.primary,
                                        size: 24,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Product Info area
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            product.name.toUpperCase(),
                                            style: GoogleFonts.bebasNeue(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w900,
                                              color: Colors.black,
                                              height: 1.1,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            '\$${product.price.toStringAsFixed(2)}',
                                            style: GoogleFonts.bebasNeue(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w900,
                                              color: AppColors.primary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: const BoxDecoration(
                                        color: Colors.black,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.shopping_basket_outlined,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // Sticky Bottom Buttons (Buy Now + Cart)
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: Row(
              children: [
                // Cart Button
                GestureDetector(
                  onTap: () {
                    Provider.of<CartProvider>(context, listen: false).addToCart(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${product.name} added to cart'),
                        backgroundColor: AppColors.primary,
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.shopping_cart_outlined, color: Colors.white, size: 28),
                  ),
                ),
                const SizedBox(width: 12),
                // Buy Now Button
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Action for Buy Now
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF26522), // Matching the orange in screenshot
                      minimumSize: const Size(double.infinity, 60),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 0,
                    ),
                    child: Text(
                      'Buy Now',
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildSpecItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          const Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
          Text(
            '$label: ',
            style: GoogleFonts.outfit(fontWeight: FontWeight.w800, fontSize: 13, color: Colors.black87),
          ),
          Text(
            value,
            style: GoogleFonts.outfit(fontSize: 13, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewField(String label, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.outfit(fontSize: 14, color: Colors.black54),
        ),
        TextField(
          maxLines: maxLines,
          decoration: const InputDecoration(
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 0.5)),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.primary)),
          ),
        ),
      ],
    );
  }

  Widget _buildReviewCard(String name, String date, String review) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey.shade200,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ...List.generate(5, (index) => const Icon(
                    Icons.star,
                    color: AppColors.primary,
                    size: 14,
                  )),
                ],
              ),
              const SizedBox(height: 4),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '$name  —  ',
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    TextSpan(
                      text: date,
                      style: GoogleFonts.outfit(
                        fontSize: 12,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                review,
                style: GoogleFonts.outfit(
                  fontSize: 13,
                  color: Colors.black54,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

