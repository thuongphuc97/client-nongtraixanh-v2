import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_travel_ui/models/auth_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Auth _auth;

  AuthBloc(this._auth);

  @override
  AuthState get initialState => AuthInitial();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AuthStarted) {
      if (_auth == null) yield AuthFailure();
      if (_auth.auth) {
        yield AuthSuccess();
      } else {
        yield AuthFailure();
      }
    }

    if (event is AuthLoggedIn) {
      yield AuthSuccess();
    }

    if (event is AuthLoggedOut) {
      await _auth.signOut();
      final storage = new FlutterSecureStorage();
      await storage.delete(key: "token");
      yield AuthFailure();
    }
  }
}
