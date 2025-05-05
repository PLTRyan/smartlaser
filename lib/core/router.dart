import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_laser/features/auth/login_screen.dart';
import 'package:smart_laser/features/dashboard/dashboard_screen.dart';
import 'package:smart_laser/features/company/company_screen.dart';
import 'package:smart_laser/features/tickets/tickets_screen.dart';
import 'package:smart_laser/features/machines/machines_screen.dart';
import 'package:smart_laser/features/notifications/notifications_screen.dart';

// Router provider using GoRouter
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardScreen(),
        routes: [
          GoRoute(
            path: 'company',
            builder: (context, state) => const CompanyScreen(),
          ),
          GoRoute(
            path: 'tickets',
            builder: (context, state) => const TicketsScreen(),
          ),
          GoRoute(
            path: 'machines',
            builder: (context, state) => const MachinesScreen(),
          ),
          GoRoute(
            path: 'notifications',
            builder: (context, state) => const NotificationsScreen(),
          ),
        ],
      ),
    ],
    // Redirect to login if not authenticated
    redirect: (context, state) {
      // Here we could check for authentication status
      // and redirect accordingly
      return null;
    },
  );
}); 