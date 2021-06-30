// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'on_boarding_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$OnBoardingStore on _OnBoardingStore, Store {
  final _$isLoginAtom = Atom(name: '_OnBoardingStore.isLogin');

  @override
  bool get isLogin {
    _$isLoginAtom.reportRead();
    return super.isLogin;
  }

  @override
  set isLogin(bool value) {
    _$isLoginAtom.reportWrite(value, super.isLogin, () {
      super.isLogin = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_OnBoardingStore.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$signUpAsyncAction = AsyncAction('_OnBoardingStore.signUp');

  @override
  Future<void> signUp(BuildContext context) {
    return _$signUpAsyncAction.run(() => super.signUp(context));
  }

  final _$createUserInDBAsyncAction =
      AsyncAction('_OnBoardingStore.createUserInDB');

  @override
  Future<bool> createUserInDB(User? user) {
    return _$createUserInDBAsyncAction.run(() => super.createUserInDB(user));
  }

  final _$loginAsyncAction = AsyncAction('_OnBoardingStore.login');

  @override
  Future<void> login(BuildContext context) {
    return _$loginAsyncAction.run(() => super.login(context));
  }

  @override
  String toString() {
    return '''
isLogin: ${isLogin},
isLoading: ${isLoading}
    ''';
  }
}
