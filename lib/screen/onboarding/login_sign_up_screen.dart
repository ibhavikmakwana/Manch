import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:supabase_playground/screen/onboarding/store/on_boarding_store.dart';
import 'package:supabase_playground/widget/custom_text_field.dart';
import 'package:supabase_playground/widget/indicator_dot.dart';

class LoginSignUpScreen extends StatefulWidget {
  @override
  _LoginSignUpScreenState createState() => _LoginSignUpScreenState();
}

class _LoginSignUpScreenState extends State<LoginSignUpScreen> {
  late final OnBoardingStore _onBoardingStore;

  @override
  void initState() {
    super.initState();
    _onBoardingStore = OnBoardingStore();
  }

  @override
  void dispose() {
    _onBoardingStore.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Observer(
              builder: (_) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(height: 32),
                  FlutterLogo(
                    size: 64,
                    style: FlutterLogoStyle.stacked,
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      CustomOnBoardingTab(
                        onPressed: () {
                          if (!_onBoardingStore.isLogin) {
                            _onBoardingStore.isLogin = true;
                          } else {
                            return;
                          }
                        },
                        title: AppLocalizations.of(context)?.login,
                        isSelected: _onBoardingStore.isLogin,
                      ),
                      CustomOnBoardingTab(
                        onPressed: () {
                          if (_onBoardingStore.isLogin) {
                            _onBoardingStore.isLogin = false;
                          } else {
                            return;
                          }
                        },
                        title: AppLocalizations.of(context)?.signUp,
                        isSelected: !_onBoardingStore.isLogin,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    '${AppLocalizations.of(context)?.email}',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _onBoardingStore.emailController,
                    focusNode: _onBoardingStore.emailFocusNode,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    hintText: AppLocalizations.of(context)?.enterYourEmail,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    '${AppLocalizations.of(context)?.password}',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _onBoardingStore.passwordController,
                    focusNode: _onBoardingStore.passwordFocusNode,
                    textInputAction: _onBoardingStore.isLogin
                        ? TextInputAction.done
                        : TextInputAction.next,
                    obscureText: true,
                    hintText: AppLocalizations.of(context)?.enterYourPassword,
                  ),
                  if (_onBoardingStore.isLogin) ...{
                    const SizedBox(height: 24),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          '${AppLocalizations.of(context)?.forgotPassword}',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    ),
                  } else ...{
                    const SizedBox(height: 24),
                    Text(
                      '${AppLocalizations.of(context)?.confirmPassword}',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: _onBoardingStore.confirmPasswordController,
                      focusNode: _onBoardingStore.confirmPasswordFocusNode,
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      hintText:
                          '${AppLocalizations.of(context)?.confirmPassword}',
                    ),
                  },
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () async {
                      if (_onBoardingStore.isLogin) {
                        _onBoardingStore.login(context);
                      } else {
                        await _onBoardingStore.signUp(context);
                      }
                    },
                    child: Text(_onBoardingStore.isLogin
                        ? '${AppLocalizations.of(context)?.login}'
                        : '${AppLocalizations.of(context)?.signUp}'),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomOnBoardingTab extends StatelessWidget {
  const CustomOnBoardingTab({
    Key? key,
    this.onPressed,
    this.isSelected = false,
    this.title,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final bool? isSelected;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                Text(
                  '$title',
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isSelected ?? false
                            ? Theme.of(context).tabBarTheme.labelColor
                            : Theme.of(context)
                                .tabBarTheme
                                .unselectedLabelColor,
                      ),
                ),
                const SizedBox(height: 8),
                IndicatorDot(isSelected: isSelected),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
