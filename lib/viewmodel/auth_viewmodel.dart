// lib/viewmodel/auth_viewmodel.dart

import 'package:flutter/foundation.dart';
import '../config/endpoint.dart';
import '../config/network.dart';
import '../config/model/resp.dart';

class AuthViewmodel extends ChangeNotifier {
  Future<Resp> login({required String email, required String password}) async {
    final Map<String, dynamic> data = {"email": email, "password": password};
    debugPrint('AuthViewmodel - Login request data: $data');
    debugPrint('AuthViewmodel - Login URL: ${Endpoint.authLoginUrl}');
    return await Network.postApi(Endpoint.authLoginUrl, data);
  }

  Future<Resp> register({
    required String name,
    required String username,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
    required String kecamatanId,
    required String kelurahanId,
  }) async {
    final Map<String, dynamic> data = {
      "name": name,
      "username": username,
      "email": email,
      "phone_number": phone,
      "password": password,
      "password_confirmation": confirmPassword,
      "kecamatan_id": kecamatanId,
      "kelurahan_id": kelurahanId,
      "role": "user",
    };

    debugPrint('AuthViewmodel - Register request data: $data');
    debugPrint('AuthViewmodel - Register URL: ${Endpoint.authRegisterUrl}');

    return await Network.postApi(Endpoint.authRegisterUrl, data);
  }
}
