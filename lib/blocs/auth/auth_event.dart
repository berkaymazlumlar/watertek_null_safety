part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class GetAuthEvent extends AuthEvent {
  final String email;
  final String password;

  GetAuthEvent({
    @required this.email,
    @required this.password,
  });
}

class SignOutEvent extends AuthEvent {}
