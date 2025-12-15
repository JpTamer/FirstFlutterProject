import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class TreeApiService {
  // Fetch all trees with their diseases
  static Future<List<Map<String, dynamic>>> fetchTreeMedicines() async {
    try {
      final response = await http
          .get(
            Uri.parse(ApiConfig.treesEndpoint),
            headers: {'Content-Type': 'application/json'},
          )
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () {
              throw Exception(
                'Request timeout. Please check your backend server.',
              );
            },
          );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        if (jsonData['success'] == true && jsonData['data'] != null) {
          final List<dynamic> data = jsonData['data'];
          return data.map((item) => item as Map<String, dynamic>).toList();
        } else {
          throw Exception('Invalid response format from server');
        }
      } else {
        throw Exception('Failed to load trees. Status: ${response.statusCode}');
      }
    } catch (e) {
      if (e.toString().contains('SocketException')) {
        throw Exception(
          'Cannot connect to server. Please ensure:\n'
          '1. Backend server is running on ${ApiConfig.baseUrl}\n'
          '2. You have internet connection\n'
          '3. Check ApiConfig.baseUrl in lib/config/api_config.dart',
        );
      }
      rethrow;
    }
  }

  // Fetch a specific tree by name
  static Future<Map<String, dynamic>> fetchTreeByName(String treeName) async {
    try {
      final response = await http
          .get(
            Uri.parse('${ApiConfig.treesEndpoint}/$treeName'),
            headers: {'Content-Type': 'application/json'},
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        if (jsonData['success'] == true && jsonData['data'] != null) {
          return jsonData['data'];
        } else {
          throw Exception('Invalid response format from server');
        }
      } else if (response.statusCode == 404) {
        throw Exception('Tree not found');
      } else {
        throw Exception('Failed to load tree. Status: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Search trees by query
  static Future<List<Map<String, dynamic>>> searchTrees(String query) async {
    try {
      final response = await http
          .get(
            Uri.parse('${ApiConfig.treesEndpoint}/search/$query'),
            headers: {'Content-Type': 'application/json'},
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        if (jsonData['success'] == true && jsonData['data'] != null) {
          final List<dynamic> data = jsonData['data'];
          return data.map((item) => item as Map<String, dynamic>).toList();
        } else {
          throw Exception('Invalid response format from server');
        }
      } else {
        throw Exception(
          'Failed to search trees. Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  // Test API connection
  static Future<bool> testConnection() async {
    try {
      final response = await http
          .get(Uri.parse('${ApiConfig.baseUrl}/health'))
          .timeout(const Duration(seconds: 5));

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
