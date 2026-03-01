import 'package:flutter/material.dart';
import '../core/theme.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
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
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'PROFILE',
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
            // Profile Info Header (Same as Account)
            const Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage('https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?q=80&w=1887&auto=format&fit=crop'),
                    backgroundColor: Color(0xFFEEEEEE),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Ellie Alexander',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    '@alexander32',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black45,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            // Details List
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  _buildProfileRow('Name', 'Ellie'),
                  _buildProfileRow('Date of birth', 'Aug 21, 2003'),
                  _buildProfileRow('Phone Number', '(314) 429-0122'),
                  _buildProfileRow('Gender', 'Female'),
                  _buildProfileRow('Email', 'e@example.com'),
                  _buildProfileRow('Region', 'United States'),
                  _buildProfileRow('Password', 'Change Password', isAction: true),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileRow(String label, String value, {bool isAction = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.1), width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 16,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.outfit(
              fontSize: 16,
              color: isAction ? Colors.orange : Colors.black,
              fontWeight: isAction ? FontWeight.w700 : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
