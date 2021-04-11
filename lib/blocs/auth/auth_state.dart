part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {
  // final User user;
  // final MyUser myUser;
  final ApiUser apiUser;
  AuthSuccessState({
    @required this.apiUser,
    // @required this.user,
    // @required this.myUser,
  });
}

class AuthFailureState extends AuthState {
  final String error;

  AuthFailureState({@required this.error});
}
