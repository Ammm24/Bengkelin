// lib/config/endpoint.dart

import 'package:flutter_dotenv/flutter_dotenv.dart';

class Endpoint {
  // Ambil base URL dari .env
  static final String baseUrl = dotenv.env['BASEURL_STAGING_CLIENT']!;

  // Auth & User Management
  static const String authLoginUrl = '/api/login';
  static const String authRegisterUrl =
      '/api/auth/register'; // Pastikan ini adalah endpoint registrasi yang benar

  // Service Endpoints
  static const String kecamatanUrl = '/api/service/kecamatan';
  static const String kelurahanUrl = '/api/service/kelurahan';

  // Tambahkan endpoint lain di sini jika ada
  // static const String someOtherEndpoint = '/api/some/resource';
}
