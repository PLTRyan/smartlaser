import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_laser/core/providers.dart';
import 'package:smart_laser/data/models/customer_model.dart';

class TicketsScreen extends ConsumerWidget {
  const TicketsScreen({super.key});

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

    final tickets = customer.tickets;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Support Tickets'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // This would show a form to create a new ticket
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Create ticket functionality will be implemented in a future update'),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: tickets.isEmpty
          ? const Center(
              child: Text('No tickets available'),
            )
          : ListView.builder(
              itemCount: tickets.length,
              itemBuilder: (context, index) {
                final ticket = tickets[index];
                final statusColor = ticket.status == 'Completed'
                    ? Colors.green
                    : ticket.status == 'In Progress'
                        ? Colors.orange
                        : Colors.blue;

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 3,
                  child: ListTile(
                    title: Text(
                      ticket.fault,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text('Machine: ${ticket.machineName}'),
                        Text('Date: ${ticket.date}'),
                      ],
                    ),
                    trailing: Chip(
                      label: Text(ticket.status),
                      backgroundColor: statusColor.withOpacity(0.2),
                      labelStyle: TextStyle(color: statusColor),
                    ),
                    isThreeLine: true,
                    onTap: () {
                      _showTicketDetails(context, ticket);
                    },
                  ),
                );
              },
            ),
    );
  }

  void _showTicketDetails(BuildContext context, Ticket ticket) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ticket Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Machine', ticket.machineName),
            _buildDetailRow('Date', ticket.date),
            _buildDetailRow('Fault', ticket.fault),
            _buildDetailRow('Status', ticket.status),
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