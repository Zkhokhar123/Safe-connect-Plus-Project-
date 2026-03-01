import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Framing Circle behind illustration (Figma measured: 480x480 at -140, -100)
          Positioned(
            top: -150,
            left: -120,
            child: Container(
              width: 480,
              height: 480,
              decoration: BoxDecoration(
                color: AppColors.accentSoft.withValues(alpha: 0.8),
                shape: BoxShape.circle,
              ),
            ),
          ),
          
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  // Shopping Illustration (Figma measured height: 259)
                  Center(
                    child: Image.asset(
                      'assets/images/shopping_illustration.png',
                      height: 259,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // WELCOME Gradient Text (Figma measured box 649x649 area)
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Color(0xFFF26522), Color(0xFFFBB03B)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ).createShader(bounds),
                    child: Text(
                      'WELCOME',
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.0,
                        height: 0.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Choose Your account to get started!',
                    style: GoogleFonts.outfit(
                      color: AppColors.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  
                  // Figma Gap: 80px above cards
                  const SizedBox(height: 30),
                  
                  // Account Selection Cards (Figma measured: 169x205 each)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildAccountCard(
                          context,
                          'Continue as Customer',
                          'Browse & buy\nat regular prices!',
                          'assets/images/customer_icon.png',
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginScreen()),
                            );
                          },
                        ),
                        const SizedBox(width: 16),
                        _buildAccountCard(
                          context,
                          'Login as Wholesaler',
                          'Access bulk pricing &\nexclusive discounts',
                          'assets/images/wholesaler_icon.png',
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginScreen()),
                            );
                          },
                          isWholesaler: true,
                        ),
                      ],
                    ),
                  ),
                  
                  // Figma Gap: 48px below cards
                  const SizedBox(height: 20),
                  
                  // Footer Link
                  const _FooterLinks(),
                  
                  // Measured spacing for disclaimer
                  const SizedBox(height: 6),
                  Text(
                    'You can switch later from settings.',
                    style: GoogleFonts.outfit(
                      color: Colors.black45,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 150),
                ],
              ),
            ),
          ),
          
          // Background soft shape (Bottom Right)
          Positioned(
            bottom: -250,
            right: -200,
            child: Container(
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                color: AppColors.accentSoft.withValues(alpha: 0.5),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountCard(
    BuildContext context,
    String buttonText,
    String subtitle,
    String assetPath,
    VoidCallback onTap, {
    bool isWholesaler = false,
  }) {
    return Container(
      width: 169,
      height: 205,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.6), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  const SizedBox(height: 4),
                  // Illustration Area (Approx 113x113 in Figma)
                  Expanded(
                    child: Center(
                      child: Image.asset(
                        assetPath,
                        fit: BoxFit.contain,
                        errorBuilder: (c, e, s) => Icon(
                          isWholesaler ? Icons.inventory_2 : Icons.shopping_bag,
                          color: AppColors.primary,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: GoogleFonts.outfit(
                      fontSize: 11,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      height: 1.15,
                    ),
                  ),
                  const SizedBox(height: 14),
                  // Solid Orange Button
                  InkWell(
                    onTap: onTap,
                    child: Container(
                      width: double.infinity,
                      height: 38,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          buttonText,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (isWholesaler)
              Positioned(
                top: 15,
                right: -28,
                child: Transform.rotate(
                  angle: 0.785, // 45 degrees
                  child: Container(
                    width: 100,
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                    ),
                    child: Center(
                      child: Text(
                        'Members Only',
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontSize: 7.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _FooterLinks extends StatelessWidget {
  const _FooterLinks();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Not A Wholesaler? ',
          style: GoogleFonts.outfit(
            color: Colors.black87,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Text(
            'Apply Now!',
            style: GoogleFonts.outfit(
              color: AppColors.primary,
              fontWeight: FontWeight.w800,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}
