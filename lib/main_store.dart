import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mobx/mobx.dart';

part 'main_store.g.dart';

class MainStore = _MainStore with _$MainStore;

abstract class _MainStore with Store {
  @observable
  Locale? currentLocale = AppLocalizations.supportedLocales[0];

  @action
  void setCurrentLocale(String languageCode) {
    AppLocalizations.supportedLocales.forEach((element) {
      if (element.languageCode == languageCode) currentLocale = element;
    });
  }
}
