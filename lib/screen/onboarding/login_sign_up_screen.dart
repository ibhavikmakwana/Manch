/*
 * BSD 2-Clause License
 *
 * Copyright (c) 2021, Bhavik Makwana
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice, this
 *    list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
import 'package:flutter/material.dart';
import 'package:manch/l10n/app_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:manch/screen/onboarding/store/on_boarding_store.dart';
import 'package:manch/values/assets.dart';
import 'package:manch/values/routes.dart';
import 'package:manch/widget/custom_button.dart';
import 'package:manch/widget/custom_text_field.dart';
import 'package:manch/widget/indicator_dot.dart';

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
      extendBodyBehindAppBar: true,
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
                  SvgPicture.asset(
                    SVGs.icAppIconWithoutBackground,
                    height: 64,
                    width: 64,
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
                        .titleMedium
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
                        .titleMedium
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
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  } else ...{
                    const SizedBox(height: 24),
                    Text(
                      '${AppLocalizations.of(context)?.confirmPassword}',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
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
                  CustomButton(
                    onPressed: () async {
                      if (_onBoardingStore.isLoading) return;
                      if (_onBoardingStore.isLogin) {
                        final bool canNavigate = await _onBoardingStore.login();
                        if (canNavigate) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            Routes.dashboard,
                            (Route<dynamic> route) => false,
                          );
                        }
                      } else {
                        final bool canNavigate =
                            await _onBoardingStore.signUp();
                        if (canNavigate) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            Routes.dashboard,
                            (Route<dynamic> route) => false,
                          );
                        }
                      }
                    },
                    isLoading: _onBoardingStore.isLoading,
                    text: _onBoardingStore.isLogin
                        ? '${AppLocalizations.of(context)?.login}'
                        : '${AppLocalizations.of(context)?.signUp}',
                  ),
                  const SizedBox(height: 32),
                  CustomButton(
                    onPressed: () async {
                      final bool canNavigate =
                          await _onBoardingStore.loginWithGoogle();
                      if (canNavigate) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          Routes.dashboard,
                          (Route<dynamic> route) => false,
                        );
                      }
                    },
                    text: AppLocalizations.of(context)?.loginWithGoogle,
                  )
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
  final bool isSelected;
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
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
