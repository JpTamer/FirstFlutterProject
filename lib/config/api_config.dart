class ApiConfig {
  // Change this to your backend URL
  // For local development on Android emulator: 'http://10.0.2.2:3000'
  // For local development on iOS simulator: 'http://localhost:3000'
  // For local development on physical device: 'http://YOUR_IP_ADDRESS:3000'
  // For production: 'https://your-backend-url.com'

  static const String baseUrl =
      'http://localhost:3000'; // Change this to your backend URL
  static const String apiVersion = '/api';

  static String get treesEndpoint => '$baseUrl$apiVersion/trees';
}
