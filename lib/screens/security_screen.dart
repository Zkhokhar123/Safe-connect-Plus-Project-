import 'package:flutter/material.dart';
import '../core/theme.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  bool _faceId = true;
  bool _twoFactor = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Security Center', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

          _buildHeroCard(),
          const SizedBox(height: 32),
          const Text(
            'Login & Authenticity',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildSecurityOption(
            context,
            'Change Password',
            'Last changed 3 months ago',
            Icons.lock_reset_rounded,
            onTap: () => _showPasswordDialog(context),
          ),
          _buildSecurityOption(
            context,
            'Two-Factor Authentication',
            'Add an extra layer of security',
            Icons.vibration_rounded,
            trailing: Switch(
              value: _twoFactor,
              onChanged: (v) => setState(() => _twoFactor = v),
              activeThumbColor: AppColors.primary,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Biometrics',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildSecurityOption(
            context,
            'Face ID / Fingerprint',
            'Use biometrics to login faster',
            Icons.fingerprint_rounded,
            trailing: Switch(
              value: _faceId,
              onChanged: (v) => setState(() => _faceId = v),
              activeThumbColor: AppColors.primary,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Device Activity',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildSecurityOption(
            context,
            'Manage Devices',
            '2 devices currently active',
            Icons.devices_other_rounded,
          ),
        ],
      ),
    ),
  );
}


  Widget _buildHeroCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primary.withValues(alpha: 0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: const Row(
        children: [
          Icon(Icons.shield_rounded, color: Colors.white, size: 48),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your account is secure',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'We recommend enabling 2FA for maximum protection.',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityOption(
    BuildContext context, 
    String title, 
    String subtitle, 
    IconData icon, 
    {Widget? trailing, VoidCallback? onTap}
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.backgroundDark,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, color: AppColors.primary, size: 22),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Text(subtitle, style: const TextStyle(color: AppColors.textGrey, fontSize: 12)),
        trailing: trailing ?? const Icon(Icons.chevron_right_rounded, color: AppColors.textGrey),
      ),
    );
  }

  void _showPasswordDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.backgroundDark,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
      builder: (context) => Padding(
        padding: EdgeInsets.fromLTRB(24, 24, 24, MediaQuery.of(context).viewInsets.bottom + 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Change Password', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            _buildDialogField('Current Password', true),
            const SizedBox(height: 16),
            _buildDialogField('New Password', true),
            const SizedBox(height: 16),
            _buildDialogField('Confirm New Password', true),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Update Password'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDialogField(String label, bool isPassword) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.textGrey),
        filled: true,
        fillColor: AppColors.cardDark,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
      ),
    );
  }
}
