import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_travel_ui/models/auth_model.dart';
import 'package:flutter_travel_ui/repository/auth_repository.dart';

import '../networking/response.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class AuthService with ChangeNotifier {
  AuthRepository _authRepository;
  StreamController _authDataController;
  Auth _auth;

  Status _status = Status.Uninitialized;
  AuthService();
  Future<bool> signIn(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      _auth = await _authRepository.signIn(email, password);

      return true;
    } catch (e) {
      print("err: " + e.toString());
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future signOut() async {
    _auth = await _authRepository.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  void _onSignInErr(String code, Function(String) onRegisterError) {
    print(code);
    switch (code) {
      case "ERROR_INVALID_EMAIL":
      case "ERROR_INVALID_CREDENTIAL":
        onRegisterError("Định dạng email không đúng!");
        break;
      case "ERROR_WRONG_PASSWORD":
        onRegisterError("Sai mật khẩu");
        break;

      case "ERROR_API_NOT_AVAILABLE":
        onRegisterError("Yêu cầu thiết bị cần có Google Play Serivce!");
        break;
      case "ERROR_NETWORK_REQUEST_FAILED":
        onRegisterError("Lỗi mạng, vui lòng kiểm tra kết nối mạng!");
        break;
      case "ERROR_USER_NOT_FOUND":
        onRegisterError('Tài khoản không tồn tại!');
        break;
      default:
        onRegisterError(
            "Có lỗi trong quá trình đăng nhập, vui lòng thử lại sau");
        break;
    }
  }

// /* ------------------------------- Single Tour ------------------------------ */
//   StreamSink<Response<Auth>> get tourDataSink => _authDataController.sink;
//   Stream<Response<Auth>> get tourDataStream => _authDataController.stream;

//   AuthService() {
//     _authDataController = StreamController<Response<Auth>>();
//     _authRepository = AuthRepository();
//   }
//   currentUser() async {
//     // return await s
//   }

// /* --------------------------------- SIGN IN -------------------------------- */
//   signIn(String email, String password) async {
//     tourDataSink.add(Response.loading('Signing!'));
//     try {
//       Auth auth = await _authRepository.signIn(email, password);
//       tourDataSink.add(Response.completed(auth));
//     } catch (e) {
//       tourDataSink.add(Response.error(e.toString()));
//       print(e);
//     }
//   }
// /* -------------------------------------------------------------------------- */

// /* -------------------------------- SIGN OUT -------------------------------- */
//   signOut() async {
//     tourDataSink.add(Response.loading('Log Out!'));
//     try {
//       Auth auth = await _authRepository.signOut();
//       tourDataSink.add(Response.completed(auth));
//     } catch (e) {
//       tourDataSink.add(Response.error(e.toString()));
//       print(e);
//     }
//   }
// /* -------------------------------------------------------------------------- */

//   dispose() {
//     _authDataController?.close();
//   }
}
