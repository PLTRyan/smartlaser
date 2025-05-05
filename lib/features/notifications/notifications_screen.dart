import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_laser/core/providers.dart';
import 'package:smart_laser/data/models/customer_model.dart' as models;

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customer = ref.watch(currentCustomerProvider);

    if (customer == null) {
      return const Scaffold(
        body: Center(
          child: Text('No customer data available'),
        ),
      );
    }

    final notifications = customer.notifications;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: notifications.isEmpty
          ? const Center(
              child: Text('No notifications available'),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 2,
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.notifications),
                    ),
                    title: Text(notification.note),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text('Date: ${notification.dateTime}'),
                        Text('Added by: ${notification.addedBy}'),
                      ],
                    ),
                    isThreeLine: true,
                    onTap: () {
                      _showNotificationDetails(context, notification);
                    },
                  ),
                );
              },
            ),
    );
  }

  void _showNotificationDetails(BuildContext context, models.Notification notification) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Notification Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Note', notification.note),
            _buildDetailRow('Date', notification.dateTime),
            _buildDetailRow('Added By', notification.addedBy),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
} 