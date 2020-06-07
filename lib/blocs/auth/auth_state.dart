part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthSuccess extends AuthState {
   final Auth auth;

  AuthSuccess(this.auth);


  @override
  List<Auth> get props => [auth];

  @override
  String toString() => 'Authenticated { email: ${auth.uid} }';
}

class AuthFailure extends AuthState {}
