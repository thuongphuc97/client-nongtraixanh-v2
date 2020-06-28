import 'package:flutter_travel_ui/models/user_model.dart';

import '../networking/api_provider.dart';
import 'dart:async';

class UserRepository {
  ApiProvider _provider = ApiProvider();
  
  Future<User> getUserProfile(String uid) async {
    final response = await _provider.get("api/profile/$uid");
    return User.fromJson(response);
  }
  Future<void> updateProfile(String uid, String firstName, String lastName) async {
       Map<String, dynamic> profile = {
      "firstname": firstName,
      "lastname": lastName
    };
      await _provider.put('api/profile/update-profile/'+uid, profile);
  }
}
