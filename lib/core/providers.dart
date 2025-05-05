import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_laser/data/api_service.dart';
import 'package:smart_laser/data/models/customer_model.dart';
import 'package:smart_laser/data/repositories/customer_repository.dart';

// API Service Provider
final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

// Customer Repository Provider
final customerRepositoryProvider = Provider<CustomerRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return CustomerRepository(apiService);
});

// Current Customer Provider
final currentCustomerProvider = StateProvider<Customer?>((ref) => null);

// Email Input Provider
final emailInputProvider = StateProvider<String>((ref) => '');

// Customer Fetch Status Provider
final customerFetchStatusProvider = StateProvider<AsyncValue<Customer>>((ref) {
  return const AsyncValue.loading();
});

// Customer Fetch Provider
final customerFetchProvider = FutureProvider.family<Customer, String>((ref, email) async {
  final repository = ref.watch(customerRepositoryProvider);
  return repository.getCustomerByEmail(email);
}); 