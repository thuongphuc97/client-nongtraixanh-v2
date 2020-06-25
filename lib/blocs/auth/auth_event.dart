part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}
class AuthStarted extends AuthEvent {}

class AuthLoggedIn extends AuthEvent {
  final Auth auth;

  AuthLoggedIn(this.auth);


  @override
  List<Auth> get props => [auth];

  @override
  String toString() => 'Authenticated { uid: ${auth.uid} }';
}

class AuthLoggedOut extends AuthEvent {}
