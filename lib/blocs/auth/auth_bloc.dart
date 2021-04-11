import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teknoloji_kimya_servis/api/post_apis.dart';
import 'package:teknoloji_kimya_servis/helpers/eralp_helper.dart';
import 'package:teknoloji_kimya_servis/models/api_user.dart';
import 'package:teknoloji_kimya_servis/repositories/auth/auth_repository.dart';
import 'package:teknoloji_kimya_servis/utils/locator.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState());
  final AuthRepository _authRepository = locator<AuthRepository>();
  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is GetAuthEvent) {
      yield AuthLoadingState();

      try {
        final _apiUser = await PostApi.login(
          username: event.email,
          password: event.password,
        );
        if (_apiUser != null) {
          _authRepository.apiUser = _apiUser;
          yield AuthSuccessState(apiUser: _apiUser);
          final _serpireferensis = await SharedPreferences.getInstance();
          _serpireferensis.setString("username", event.email);
          _serpireferensis.setString("password", event.password);
        } else {
          yield AuthFailureState(error: "Giriş yapılamadı");
        }
      } catch (e) {
        yield AuthFailureState(error: "$e");
        print("there is an error while getting auth, error: $e");
      } finally {
        EralpHelper.stopProgress();
      }
    }
    if (event is SignOutEvent) {
      yield AuthInitialState();
    }
  }
}
