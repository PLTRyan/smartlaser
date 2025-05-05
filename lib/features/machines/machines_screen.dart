import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_laser/core/providers.dart';
import 'package:smart_laser/data/models/customer_model.dart';

class MachinesScreen extends ConsumerWidget {
  const MachinesScreen({super.key});

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

    final machines = customer.machines;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Machines'),
      ),
      body: machines.isEmpty
          ? const Center(
              child: Text('No machines available'),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: machines.length,
              itemBuilder: (context, index) {
                final machine = machines[index];
                final isInWarranty = _isInWarranty(machine.warranty);
                
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                machine.machineName,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Chip(
                              label: Text(
                                isInWarranty ? 'In Warranty' : 'Out of Warranty',
                                style: TextStyle(
                                  color: isInWarranty ? Colors.green : Colors.red,
                                ),
                              ),
                              backgroundColor: isInWarranty
                                  ? Colors.green.withOpacity(0.1)
                                  : Colors.red.withOpacity(0.1),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildDetailRow('Machine ID', machine.machineId.toString()),
                        _buildDetailRow('Installation Date', machine.installDate ?? 'N/A'),
                        _buildDetailRow('Warranty Until', machine.warranty ?? 'N/A'),
                        _buildDetailRow('Sales Person', machine.salesPerson ?? 'N/A'),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OutlinedButton.icon(
                              onPressed: () {
                                // Would show the service history
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Service history feature coming soon'),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.history),
                              label: const Text('Service History'),
                            ),
                            const SizedBox(width: 8),
                            FilledButton.icon(
                              onPressed: () {
                                // Would allow requesting service
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Request service feature coming soon'),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.build),
                              label: const Text('Request Service'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  bool _isInWarranty(String? warrantyDate) {
    if (warrantyDate == null) return false;
    
    try {
      final parts = warrantyDate.split('/');
      if (parts.length != 3) return false;
      
      final warranty = DateTime(
        int.parse(parts[0]),
        int.parse(parts[1]),
        int.parse(parts[2]),
      );
      
      return warranty.isAfter(DateTime.now());
    } catch (e) {
      return false;
    }
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
} 