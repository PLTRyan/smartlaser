import 'package:smart_laser/data/api_service.dart';
import 'package:smart_laser/data/models/customer_model.dart';

class CustomerRepository {
  final ApiService _apiService;

  CustomerRepository(this._apiService);

  Future<Customer> getCustomerByEmail(String email) async {
    try {
      final jsonData = await _apiService.getCustomerByEmail(email);
      return Customer.fromJson(jsonData);
    } catch (e) {
      throw Exception('Failed to fetch customer: $e');
    }
  }
} 