import 'package:flutter/material.dart';
import '../core/theme.dart';
import 'order_review_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _selectedAddressIndex = 0;
  int _selectedDeliveryIndex = 0;
  int _selectedPaymentIndex = 0;
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  bool _saveCard = false;

  final List<Map<String, String>> _addresses = [
    {'title': 'Home', 'address': 'Lorem Ipsum Amet Dolor'},
    {'title': 'Office', 'address': 'Lorem Ipsum Amet Dolor'},
  ];

  final List<Map<String, String>> _deliveryMethods = [
    {'title': 'Standard Delivery', 'time': 'Lorem Ipsum Amet Dolor'},
  ];

  final List<Map<String, dynamic>> _paymentMethods = [
    {'title': 'Credit Card', 'type': 'card', 'logos': ['mastercard', 'visa']},
    {'title': 'VISA', 'type': 'visa', 'logos': ['visa']},
    {'title': 'Cash', 'type': 'cash', 'icon': Icons.money},
  ];

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

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
        title: const Text('CART', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, letterSpacing: 1, fontSize: 16)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Progress Indicator (Figma Style - Cart & Checkout highlighted)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                _buildProgressStep('Cart', true, true),
                _buildProgressLine(true),
                _buildProgressStep('Checkout', true, false),
                _buildProgressLine(false),
                _buildProgressStep('Delivery', false, false),
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
                  // Address Section (Figma Style)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Address',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Add New',
                          style: TextStyle(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ..._addresses.asMap().entries.map((entry) {
                    final index = entry.key;
                    final address = entry.value;
                    final isSelected = _selectedAddressIndex == index;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildAddressOption(
                        address['title']!,
                        address['address']!,
                        isSelected,
                        index,
                      ),
                    );
                  }),
                  const SizedBox(height: 24),
                  // Delivery Estimate Section (Figma Style)
                  const Text(
                    'Delievery Estimate',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1),
                  ),
                  const SizedBox(height: 12),
                  _buildDeliveryOption(),
                  const SizedBox(height: 24),
                  // Payment Method Section (Figma Style)
                  const Text(
                    'Payment Method',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1),
                  ),
                  const SizedBox(height: 12),
                  ..._paymentMethods.asMap().entries.map((entry) {
                    final index = entry.key;
                    final method = entry.value;
                    final isSelected = _selectedPaymentIndex == index;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildPaymentOption(method, isSelected, index),
                    );
                  }),
                  // Credit Card Details (if Credit Card selected)
                  if (_selectedPaymentIndex == 0) ...[
                    const SizedBox(height: 16),
                    _buildTextField('Card number', '1234 5678 9101 1121', _cardNumberController),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: _buildTextField('Expiration Date', 'MM/YY', _expiryController)),
                        const SizedBox(width: 12),
                        Expanded(child: _buildTextField('CVV', '123', _cvvController)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Checkbox(
                          value: _saveCard,
                          onChanged: (value) {
                            setState(() {
                              _saveCard = value ?? false;
                            });
                          },
                          activeColor: AppColors.primary,
                        ),
                        const Text(
                          'Save Card Details',
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          // Confirm Shipping Button (Figma Style)
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const OrderReviewScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: const Size(double.infinity, 54),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: const Text(
                  'Confirm Shipping',
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

  Widget _buildAddressOption(String title, String address, bool isSelected, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedAddressIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withValues(alpha: 0.05) : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey.shade200,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Radio(
              value: index,
              groupValue: _selectedAddressIndex,
              onChanged: (value) {
                setState(() {
                  _selectedAddressIndex = value as int;
                });
              },
              activeColor: AppColors.primary,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  Text(
                    address,
                    style: const TextStyle(color: Colors.black54, fontSize: 11),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Edit',
                style: TextStyle(fontSize: 11, color: AppColors.primary, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryOption() {
    final method = _deliveryMethods[_selectedDeliveryIndex];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.primary, width: 2),
      ),
      child: Row(
        children: [
          Radio(
            value: 0,
            groupValue: _selectedDeliveryIndex,
            onChanged: (value) {},
            activeColor: AppColors.primary,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  method['title']!,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                Text(
                  method['time']!,
                  style: const TextStyle(color: Colors.black54, fontSize: 11),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              'Edit',
              style: TextStyle(fontSize: 11, color: AppColors.primary, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(Map<String, dynamic> method, bool isSelected, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPaymentIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withValues(alpha: 0.05) : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey.shade200,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Radio(
              value: index,
              groupValue: _selectedPaymentIndex,
              onChanged: (value) {
                setState(() {
                  _selectedPaymentIndex = value as int;
                });
              },
              activeColor: AppColors.primary,
            ),
            if (method['type'] == 'card' || method['type'] == 'visa')
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade900,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'MC',
                      style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade700,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'VISA',
                      style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
              )
            else if (method['icon'] != null)
              Icon(method['icon'] as IconData, color: Colors.green, size: 24),
            Expanded(
              child: Text(
                method['title'] as String,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black54),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.black26, fontSize: 13),
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }
}
