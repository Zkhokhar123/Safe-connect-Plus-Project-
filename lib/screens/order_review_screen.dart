import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../core/theme.dart';
import 'order_success_screen.dart';

class OrderReviewScreen extends StatefulWidget {
  const OrderReviewScreen({super.key});

  @override
  State<OrderReviewScreen> createState() => _OrderReviewScreenState();
}

class _OrderReviewScreenState extends State<OrderReviewScreen> {
  bool _itemsExpanded = false;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final subtotal = cart.totalAmount;
    const shipping = 0.00;
    const discount = 0.00;
    const tax = 0.00;
    final total = subtotal + shipping + discount + tax;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('CART', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, letterSpacing: 1, fontSize: 16)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Progress Indicator (Figma Style - All 3 steps highlighted)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                _buildProgressStep('Cart', true, true),
                _buildProgressLine(true),
                _buildProgressStep('Checkout', true, true),
                _buildProgressLine(true),
                _buildProgressStep('Delivery', true, false),
              ],
            ),
          ),
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Review Section (Figma Style)
                  const Text(
                    'Review',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1),
                  ),
                  const SizedBox(height: 12),
                  _buildReviewCard('Ship To', 'Home', 'Lorem ipsum amet dolro consectetur', Icons.location_on_outlined),
                  const SizedBox(height: 12),
                  _buildReviewCard('Delivery', 'Standard Delivery', '1-2 days', Icons.local_shipping_outlined),
                  const SizedBox(height: 12),
                  _buildReviewCard('Payment', 'Credit Card', '09/2028', Icons.credit_card_outlined),
                  const SizedBox(height: 24),
                  // Items Section (Collapsible - Figma Style)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _itemsExpanded = !_itemsExpanded;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Items (${cart.items.length})',
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                          ),
                          Icon(
                            _itemsExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_itemsExpanded) ...[
                    ...cart.items.map((item) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${item.quantity}x ${item.product.name}',
                                style: const TextStyle(fontSize: 12, color: Colors.black54),
                              ),
                              Text(
                                '\$${(item.product.price * item.quantity).toStringAsFixed(2)}',
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        )),
                    const SizedBox(height: 12),
                  ],
                  const Divider(height: 1),
                  const SizedBox(height: 16),
                  // Subtotal Breakdown (Figma Style)
                  _buildSummaryRow('Subtotal', '\$${subtotal.toStringAsFixed(2)}'),
                  const SizedBox(height: 8),
                  _buildSummaryRow('Shipping', '\$${shipping.toStringAsFixed(2)}'),
                  const SizedBox(height: 8),
                  _buildSummaryRow('Discount', '\$${discount.toStringAsFixed(2)}'),
                  const SizedBox(height: 8),
                  _buildSummaryRow('Tax', '\$${tax.toStringAsFixed(2)}'),
                  const SizedBox(height: 16),
                  // Total (Figma Style)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.black87),
                      ),
                      Text(
                        '\$${total.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          // Place Order Button (Figma Style)
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: ElevatedButton(
                onPressed: () {
                  Provider.of<CartProvider>(context, listen: false).clearCart();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const OrderSuccessScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: const Size(double.infinity, 54),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: const Text(
                  'Place Order',
                  style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1, fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressStep(String label, bool isActive, bool isCompleted) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive || isCompleted ? AppColors.primary : Colors.grey.shade300,
            ),
            child: isCompleted
                ? const Icon(Icons.check, color: Colors.white, size: 18)
                : Center(
                    child: Text(
                      label == 'Cart' ? '1' : label == 'Checkout' ? '2' : '3',
                      style: TextStyle(
                        color: isActive ? Colors.white : Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.normal,
              color: isActive ? AppColors.primary : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressLine(bool isCompleted) {
    return Container(
      width: 40,
      height: 2,
      margin: const EdgeInsets.only(bottom: 16),
      color: isCompleted ? AppColors.primary : Colors.grey.shade300,
    );
  }

  Widget _buildReviewCard(String title, String mainText, String subText, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 10, color: Colors.black54, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  mainText,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.black87),
                ),
                Text(
                  subText,
                  style: const TextStyle(fontSize: 11, color: Colors.black54),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, color: Colors.black26, size: 16),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 13, color: Colors.black54),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.black87),
        ),
      ],
    );
  }
}
