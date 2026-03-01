import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/notification_provider.dart';
import '../core/theme.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

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
          'NOTIFICATION',
          style: GoogleFonts.bebasNeue(
            color: Colors.black,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
            fontSize: 32,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.horizontal_rule_rounded, color: Colors.black45, size: 30),
            onPressed: () {
              context.read<NotificationProvider>().clearNotifications();
            },
          ),
        ],
      ),
      body: Consumer<NotificationProvider>(
        builder: (context, provider, child) {
          final notifications = provider.notifications;

          if (notifications.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   const Icon(Icons.notifications_none_rounded, size: 80, color: Colors.black12),
                  const SizedBox(height: 16),
                  Text('NO NOTIFICATIONS YET', style: GoogleFonts.bebasNeue(fontSize: 24, color: Colors.black12)),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            itemCount: notifications.length,
            separatorBuilder: (context, index) => Divider(color: Colors.grey.withOpacity(0.08), height: 32),
            itemBuilder: (context, index) {
              final notification = notifications[notifications.length - 1 - index]; // Newer first
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: index % 2 == 0 ? AppColors.primary : const Color(0xFFF5F5F5),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      index % 2 == 0 ? Icons.notifications_none : Icons.shopping_bag_outlined,
                      color: index % 2 == 0 ? Colors.white : Colors.black45,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: GoogleFonts.outfit(fontSize: 14, color: Colors.black87),
                            children: [
                              TextSpan(
                                text: '${notification.title}: ',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: notification.message),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${10 + index} min ago', // Mocked display time
                          style: GoogleFonts.outfit(fontSize: 12, color: Colors.black26),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
