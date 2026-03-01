import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme.dart';
import 'main_navigation.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _agreeToTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Stack(
          children: [
             // Background soft shapes - Top Left
            Positioned(
              top: -180,
              left: -150,
              child: Container(
                width: 300,
                height: 300,
                decoration: const BoxDecoration(
                  color: AppColors.accentSoft,
                  shape: BoxShape.circle,
                ),
              ),
            ),
             // Background soft shapes - Bottom Right
            Positioned(
              bottom: -60,
              right: -60,
              child: Container(
                width: 250,
                height: 250,
                decoration: const BoxDecoration(
                  color: AppColors.accentSoft,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    Text(
                      'CREATE YOUR ACCOUNT',
                      style: GoogleFonts.outfit(
                        fontSize: 20, // Adjusted size to fit in one line
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(child: _buildTextField('First name')),
                        const SizedBox(width: 16),
                        Expanded(child: _buildTextField('Last name')),
                      ],
                    ),
                    const SizedBox(height: 15),
                    _buildTextField('Email', hintText: 'bill.sanders@example.com', showCheck: true),
                    const SizedBox(height: 15),
                    // Phone Number with Country Code and Divider
                    Container(
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey.shade300, width: 1.5)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(bottom: 12, top: 4),
                            child: Row(
                              children: [
                                const Text(
                                  '+1',
                                  style: TextStyle(color: Colors.black54, fontSize: 16),
                                ),
                                const SizedBox(width: 16),
                                Container(
                                  height: 15,
                                  width: 1,
                                  color: Colors.grey.shade300,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              decoration: const InputDecoration(
                                hintText: 'Phone Number',
                                hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(bottom: 12, top: 4),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    _buildTextField('Password', isPassword: true),
                    const SizedBox(height: 15),
                    _buildTextField('Confirm Password', isPassword: true),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        SizedBox(
                          width: 15,
                          height: 15,
                          child: Checkbox(
                            value: _agreeToTerms,
                            onChanged: (val) => setState(() => _agreeToTerms = val!),
                            activeColor: AppColors.primary,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'I agree with Terms & Conditions',
                            style: TextStyle(fontSize: 13, color: Colors.black54),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 48),
                    ElevatedButton(
                      onPressed: () {
                         Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const MainNavigationContainer()),
                          (route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        minimumSize: const Size(double.infinity, 56),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 4,
                        shadowColor: AppColors.primary.withValues(alpha: 0.4),
                      ),
                      child: const Text(
                        'REGISTER NOW',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                      ),
                    ),
                    const SizedBox(height: 305),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, {String? hintText, bool isPassword = false, bool showCheck = false}) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        suffixIcon: showCheck 
          ? const Icon(Icons.check, color: AppColors.primary, size: 18) 
          : (isPassword ? const Icon(Icons.visibility_off_outlined, color: Colors.grey, size: 22) : null),
        labelStyle: const TextStyle(color: Colors.black54, fontSize: 13, fontWeight: FontWeight.w500),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
    );
  }
}
