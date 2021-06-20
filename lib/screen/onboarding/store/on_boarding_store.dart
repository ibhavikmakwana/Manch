import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import 'package:supabase_playground/core/supabase/prefrence.dart';
import 'package:supabase_playground/core/supabase/supabase_client.dart';
import 'package:supabase_playground/values/app_constant.dart';
import 'package:supabase_playground/values/routes.dart';

part 'on_boarding_store.g.dart';

class OnBoardingStore = _OnBoardingStore with _$OnBoardingStore;

abstract class _OnBoardingStore with Store {
  _OnBoardingStore() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    confirmPasswordFocusNode = FocusNode();
  }

  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;
  late final FocusNode emailFocusNode;
  late final FocusNode passwordFocusNode;
  late final FocusNode confirmPasswordFocusNode;

  @observable
  bool isLogin = true;

  @action
  Future<void> signUp(BuildContext context) async {
    final email = emailController.text;
    final password = passwordController.text;
    _validateEmailPassword(email, password);
    if (email.isEmpty) {
      return;
    } else if (password.isEmpty) {
      return;
    }
    try {
      final response =
          await SBClient.instance?.client.auth.signUp(email, password);
      if (response?.error != null) {
        debugPrint('${response?.error?.message}');
      } else {
        isLogin = true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @action
  Future<void> login(BuildContext context) async {
    final email = emailController.text;
    final password = passwordController.text;
    _validateEmailPassword(email, password);
    try {
      final response = await SBClient.instance?.client.auth.signIn(
        email: email,
        password: password,
      );
      if (response?.error != null) {
        debugPrint('${response?.error?.message}');
      } else {
        await writeUserToStorage(response.toString());
        Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.home,
          (Route<dynamic> route) => false,
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> writeUserToStorage(String? data) async {
    SharedPreference.instance?.storage.write(
      key: AppConstant.kSession,
      value: data,
    );
  }

  void _validateEmailPassword(String email, String password) {
    if (email.isEmpty) {
      return;
    } else if (password.isEmpty) {
      return;
    }
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
  }
}
