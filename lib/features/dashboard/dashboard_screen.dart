import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_laser/core/providers.dart';
import 'package:smart_laser/data/models/customer_model.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customer = ref.watch(currentCustomerProvider);

    if (customer == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Dashboard')),
        body: const Center(
          child: Text('No customer data available. Please login again.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Clear customer data and go back to login
              ref.read(currentCustomerProvider.notifier).state = null;
              context.go('/login');
            },
          ),
        ],
      ),
      drawer: _buildDrawer(context, customer),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCustomerInfoCard(customer),
            const SizedBox(height: 24),
            _buildSummaryGrid(customer, context),
            const SizedBox(height: 24),
            _buildRecentActivityList(customer),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context, Customer customer) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  customer.companyName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Code: ${customer.clientCode}',
                  style: const TextStyle(color: Colors.white70),
                ),
                Text(
                  customer.email,
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            onTap: () {
              context.go('/dashboard');
              Navigator.pop(context); // Close drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.business),
            title: const Text('Company'),
            onTap: () {
              context.go('/dashboard/company');
              Navigator.pop(context); // Close drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.support),
            title: const Text('Tickets'),
            onTap: () {
              context.go('/dashboard/tickets');
              Navigator.pop(context); // Close drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.precision_manufacturing),
            title: const Text('Machines'),
            onTap: () {
              context.go('/dashboard/machines');
              Navigator.pop(context); // Close drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            onTap: () {
              context.go('/dashboard/notifications');
              Navigator.pop(context); // Close drawer
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerInfoCard(Customer customer) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              customer.companyName,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text('Contact: ${customer.customerName} ${customer.customerSurname}'),
            Text('Phone: ${customer.cell}'),
            Text('Email: ${customer.email}'),
            const SizedBox(height: 8),
            Text('Address: ${customer.address}'),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryGrid(Customer customer, BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        DashboardCard(
          title: 'Machines',
          count: customer.machines.length,
          icon: Icons.precision_manufacturing,
          color: Colors.blue,
          onTap: () => context.go('/dashboard/machines'),
        ),
        DashboardCard(
          title: 'Open Tickets',
          count: customer.tickets.where((t) => t.status == 'In Progress').length,
          icon: Icons.support_agent,
          color: Colors.orange,
          onTap: () => context.go('/dashboard/tickets'),
        ),
        DashboardCard(
          title: 'Support Requests',
          count: customer.quickSupports.length,
          icon: Icons.headset_mic,
          color: Colors.purple,
          onTap: () => context.go('/dashboard/tickets'), // Adjust route if needed
        ),
        DashboardCard(
          title: 'Notifications',
          count: customer.notifications.length,
          icon: Icons.notifications,
          color: Colors.green,
          onTap: () => context.go('/dashboard/notifications'),
        ),
      ],
    );
  }

  Widget _buildRecentActivityList(Customer customer) {
    // Get the 5 most recent tickets or quick supports combined
    final recentActivity = [
      ...customer.tickets.map((t) => {
            'type': 'ticket',
            'date': t.date,
            'title': 'Ticket: ${t.fault}',
            'status': t.status,
            'machine': t.machineName,
          }),
      ...customer.quickSupports.map((q) => {
            'type': 'support',
            'date': q.date,
            'title': 'Support: ${q.issue.length > 50 ? '${q.issue.substring(0, 50)}...' : q.issue}',
            'status': q.solution == null ? 'Pending' : 'Resolved',
            'machine': q.machineName,
          }),
    ];

    // Sort by date (descending)
    recentActivity.sort((a, b) => (b['date'] as String).compareTo(a['date'] as String));

    // Take only the 5 most recent
    final recentItems = recentActivity.take(5).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Activity',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        if (recentItems.isEmpty)
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text('No recent activity'),
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: recentItems.length,
            itemBuilder: (context, index) {
              final item = recentItems[index];
              final isTicket = item['type'] == 'ticket';
              final iconData = isTicket ? Icons.assignment : Icons.headset_mic;
              final statusColor = item['status'] == 'Completed' || item['status'] == 'Resolved'
                  ? Colors.green
                  : item['status'] == 'In Progress'
                      ? Colors.orange
                      : Colors.blue;

              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: Icon(iconData, color: statusColor),
                  title: Text(item['title'] as String),
                  subtitle: Text('${item['machine']} - ${item['date']}'),
                  trailing: Chip(
                    label: Text(item['status'] as String),
                    backgroundColor: statusColor.withOpacity(0.2),
                    labelStyle: TextStyle(color: statusColor),
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}

class DashboardCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final int count;
  final Color color;
  final VoidCallback onTap;

  const DashboardCard({
    super.key,
    required this.icon,
    required this.title,
    required this.count,
    required this.color,
    required this.onTap,
  });

  @override
  State<DashboardCard> createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor.withOpacity(_hovering ? 0.95 : 1.0),
            borderRadius: BorderRadius.circular(16),
            boxShadow: _hovering
                ? [
                    BoxShadow(
                      color: widget.color.withOpacity(0.25),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
            border: Border.all(
              color: _hovering ? widget.color : Colors.transparent,
              width: 1.5,
            ),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.icon, size: 40, color: widget.color),
              const SizedBox(height: 12),
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                widget.count.toString(),
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: widget.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 