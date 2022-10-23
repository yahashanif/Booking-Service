import 'dart:convert';

import 'package:booking_services_riverpod/provider/current_user_provider.dart';
import 'package:booking_services_riverpod/provider/dio_provider.dart';
import 'package:booking_services_riverpod/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/constant.dart';
import '../../model/user_model.dart';
import '../../repository/base_repository.dart';
final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>(
    (ref) => LoginNotifier(ref: ref));

class LoginNotifier extends StateNotifier<LoginState> {
  final Ref ref;
  LoginNotifier({required this.ref}) : super(LoginStateInit());

  void login({required String username, required String password}) async {
    state = LoginStateLoading();
    try {
      final resp = await AuthRepository(dio: ref.read(dioProvider))
          .login(username: username, password: password);

      state = LoginStateDone(resp);

      final shared = await SharedPreferences.getInstance();
      final token = jsonEncode({
        "date": DateTime.now().toString(),
        "model": resp.model,
        "token": resp.token
      });
      await shared.setString(Constant.bearerName, token);
      ref.read(currentUserProvider.notifier).state = resp;
    } catch (e) {
      if (e is BaseRepositoryException) {
        state = LoginStateError(e.message);
      } else {
        state = LoginStateError(e.toString());
      }
    }
  }

  void Logout() async {
    try {
      final shared = await SharedPreferences.getInstance();
      shared.remove(Constant.bearerName);
      ref.read(currentUserProvider.notifier).state = null;
    } catch (e) {
      if (e is BaseRepositoryException) {
        state = LoginStateError(e.message);
      } else {
        state = LoginStateError(e.toString());
      }
    }
  }
}

abstract class LoginState extends Equatable {
  final DateTime date;
  const LoginState(this.date);
  @override
  List<Object?> get props => [date];
}

class LoginStateInit extends LoginState {
  LoginStateInit() : super(DateTime.now());
}

class LoginStateLoading extends LoginState {
  LoginStateLoading() : super(DateTime.now());
}

class LoginStateError extends LoginState {
  final String message;
  LoginStateError(this.message) : super(DateTime.now());
}

class LoginStateDone extends LoginState {
  final AuthModel model;
  LoginStateDone(this.model) : super(DateTime.now());
}
