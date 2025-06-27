import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');
  String _currencySymbol = '\$';

  Locale get locale => _locale;
  String get currencySymbol => _currencySymbol;

  void setLocale(String langCode) {
    _locale = Locale(langCode);
    notifyListeners();
  }

  void setCurrencySymbol(String symbol) {
    _currencySymbol = symbol;
    notifyListeners();
  }
}
