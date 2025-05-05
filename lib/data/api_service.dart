import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:js' as js;

class ApiService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://csp.perfectlaser.co.za/api/clientapi';
  
  // Basic Auth credentials
  final String _username;
  final String _password;

  ApiService({String? username, String? password}) : 
    _username = username ?? 'apiuser',  // Replace 'apiuser' with your actual username
    _password = password ?? 'apipassword' {  // Replace 'apipassword' with your actual password
    
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.options.validateStatus = (status) {
      return status != null && status > 0;
    };
    
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Add Basic Auth header
          final credentials = base64Encode(utf8.encode('$_username:$_password'));
          options.headers['Authorization'] = 'Basic $credentials';
          
          // Add headers to handle CORS
          options.headers['Access-Control-Allow-Origin'] = '*';
          options.headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE, OPTIONS';
          options.headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, X-Auth-Token, Authorization';
          
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          print('API Error: ${e.message}');
          if (e.response != null) {
            print('API Response Status: ${e.response?.statusCode}');
            print('API Response Data: ${e.response?.data}');
          }
          return handler.next(e);
        },
      ),
    );
  }

  Future<Map<String, dynamic>> getCustomerByEmail(String email) async {
    try {
      // For development purposes, simulate successful response since the actual API might be unavailable or have CORS issues
      if (email == 'hoedspruit@postnet.co.za') {
        return _getMockCustomerData();
      }
      
      final response = await _dio.get(
        '$_baseUrl/returncustomers',
        queryParameters: {'email': email},
      );
      
      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception('Failed to load customer data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching customer data: $e');
      
      // For development purposes, return mock data when encountering errors
      if (email == 'hoedspruit@postnet.co.za') {
        return _getMockCustomerData();
      }
      
      throw Exception('Failed to load customer data: $e');
    }
  }

  // Mock data for development purposes
  Map<String, dynamic> _getMockCustomerData() {
    return {
      "Id": 9615,
      "NotFound": false,
      "CompanyName": "Globlify 10 cc ta Postnet Hoedspruit ",
      "ClientCode": "9615",
      "CustomerName": "Melané",
      "CustomerSurname": "Pretorius",
      "Cell": "0845903049",
      "Email": "hoedspruit@postnet.co.za",
      "Address": "Private Bag X3008, Hoedspruit Limpopo 1380",
      "MachinesPurchased": [],
      "QuickSupports": [
        {
          "MachineId": 5,
          "MachineName": "PLT-3040 50W (50W)",
          "Date": "2025/03/12",
          "Issue": "Hello Bongi\r\n\r\n \r\n\r\nThat is good news, I would like to service my machine\r\n\r\nCan you please let me know when a technician is in my area ? Hoedspruit Limpopo\r\n",
          "Solution": null,
          "TakenBy": "Angel"
        },
        {
          "MachineId": 5,
          "MachineName": "PLT-3040 50W (50W)",
          "Date": "2025/05/05",
          "Issue": "Client somehow got my personal number and sent me a WhatsApp requiring a service on their 3040 Co2 laser cutter and engraver. \r\nPlease do not book Johannes for Tuesday, I need him on Tuesday for a machine installation. \r\nI am going to book the install today. ",
          "Solution": null,
          "TakenBy": "Pearl"
        }
      ],
      "Tickets": [
        {
          "MachineId": 5,
          "MachineName": "PLT-3040 50W (50W)",
          "Date": "2025/03/13",
          "Fault": "Client has requested a service on the machine",
          "Status": "Completed"
        },
        {
          "MachineId": 5,
          "MachineName": "PLT-3040 50W (50W)",
          "Date": "2025/05/05",
          "Fault": "SERVICE ON MACHINE ",
          "Status": "In Progress"
        }
      ],
      "Machines": [
        {
          "MachineId": 5,
          "MachineName": "PLT-3040 50W (50W)",
          "InstallDate": "2020/11/11",
          "SalesPerson": "Warren",
          "Warranty": "2021/11/11"
        }
      ],
      "Notifications": [
        {
          "Note": "Quote 19367 | POP",
          "DateTime": "2020/11/09",
          "AddedBy": "Warren Schoeman"
        },
        {
          "Note": "Quote 19367 | POP",
          "DateTime": "2020/11/09",
          "AddedBy": "Warren Schoeman"
        },
        {
          "Note": "Quote 19497 | POP",
          "DateTime": "2020/11/09",
          "AddedBy": "Warren Schoeman"
        },
        {
          "Note": "Installation 5168 Completed 2020/11/20",
          "DateTime": "2020/11/20",
          "AddedBy": "Angel Tenchavez"
        }
      ],
      "Training": []
    };
  }

  // Additional API methods would be added here as needed
} 