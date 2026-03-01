import 'package:flutter/material.dart';
import '../core/theme.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About App', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.shopping_bag_rounded, size: 80, color: AppColors.primary),
              ),
              const SizedBox(height: 24),
              const Text(
                'E-Shop Premium',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Developed by Good Luck Software House',
                style: TextStyle(color: AppColors.textGrey, fontSize: 16),
              ),

              const SizedBox(height: 48),
              const Text(
                'This app is designed to provide the best e-commerce experience with a premium look and feel. Built with Flutter for smooth performance across all devices.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textGrey, fontSize: 14, height: 1.5),
              ),
              const Spacer(),
              const Text(
                '© 2026 E-Shop Inc. All rights reserved.',
                style: TextStyle(color: AppColors.textGrey, fontSize: 12),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
