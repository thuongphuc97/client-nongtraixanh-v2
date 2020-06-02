import 'package:flutter_travel_ui/models/auth_model.dart';
import '../networking/api_provider.dart';
import 'dart:async';

class AuthenticateRepository {
  ApiProvider _provider = ApiProvider();
  
  Future<Auth> signIn(String email, String password) async {
    Map<String, dynamic> authData = {"email": email, "password": password};
    final response = await _provider.post("api/signin", authData);
    return Auth.fromJson(response);
  }
}
