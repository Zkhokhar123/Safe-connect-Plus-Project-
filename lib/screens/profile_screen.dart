import 'package:flutter/material.dart';
import '../core/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'orders_screen.dart';
import 'edit_profile_screen.dart';
import 'wishlist_screen.dart';
import 'main_navigation.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () {},
        ),
        title: Text(
          'ACCOUNT',
          style: GoogleFonts.bebasNeue(
            color: Colors.black,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
            fontSize: 32,
          ),
        ),
        centerTitle: true,
        actions: [
          Transform.scale(
            scale: 0.7,
            child: Switch(
              value: _isDarkMode,
              onChanged: (val) {
                setState(() => _isDarkMode = val);
              },
              activeColor: AppColors.primary,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Profile Info Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage('https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?q=80&w=1887&auto=format&fit=crop'),
                    backgroundColor: Color(0xFFEEEEEE),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ellie Alexander',
                        style: GoogleFonts.outfit(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '@alexander32',
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          color: Colors.black45,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // My Order & Wishlist Dual Button (Figma Style)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.1), width: 1.5),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildPillButton(
                        icon: Icons.lock_outline,
                        label: 'My Order',
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const OrdersScreen()));
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildPillButton(
                        icon: Icons.favorite_border,
                        label: 'Wishlist',
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const WishlistScreen()));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Menu Items List
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildMenuItem('Account Setting', Icons.person_outline, () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfileScreen()));
                  }),
                  _buildMenuItem('Notification', Icons.notifications_none_outlined, () {}),
                  _buildMenuItem('Payment Information', Icons.credit_card_outlined, () {}),
                  _buildMenuItem('Privacy Setting', Icons.privacy_tip_outlined, () {}),
                  _buildMenuItem('General Setting', Icons.settings_outlined, () {}),
                  _buildMenuItem('Language', Icons.language_outlined, () {}),
                  _buildMenuItem('Change Account', Icons.compare_arrows_outlined, () {}),
                  _buildMenuItem('Sign Out', Icons.logout_outlined, () {}, isDestructive: true),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildPillButton({required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: Colors.black),
            const SizedBox(width: 8),
            Text(label, style: GoogleFonts.outfit(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black)),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(String title, IconData icon, VoidCallback onTap, {bool isDestructive = false}) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: isDestructive ? Colors.orange : Colors.grey.shade700, size: 24),
      title: Text(
        title,
        style: GoogleFonts.outfit(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: isDestructive ? Colors.orange : Colors.black87,
        ),
      ),
      trailing: isDestructive ? null : const Icon(Icons.chevron_right, color: Colors.black26, size: 20),
    );
  }
}
