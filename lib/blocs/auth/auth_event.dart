part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}
class AuthStarted extends AuthEvent {}

class AuthLoggedIn extends AuthEvent {
  final Auth _auth;

  AuthLoggedIn(this._auth);


  @override
  List<Object> get props => [_auth];

  @override
  String toString() => 'Authenticated { email: ${_auth.uid} }';
}

class AuthLoggedOut extends AuthEvent {}
