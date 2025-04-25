import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_app/core/constans.dart';

// important

class Localization {
  static final Localization _instance = Localization._internal();
  static AppLocalizations? _current;
  static AppLocalizations get tr => _current!;

  Localization._internal();

  factory Localization() => _instance;

  static Future<AppLocalizations> loadCurrent() async {
    if (_current == null) {
      final parts = Intl.getCurrentLocale().split('_');
      final locale = Locale(parts.first, parts.last);
      _current = await AppLocalizations.delegate.load(locale);
    }
    return Future.value(_current);
  }

  static Future<AppLocalizations> setCurrent(Locale loc) async {
    _current = await AppLocalizations.delegate.load(loc);
    return Future.value(_current);
  }

  void invalidate() {
    _current = null;
  }
}

class LocaleState extends StateNotifier<Locale> {
  LocaleState(String lang, String country) : super(Locale(lang, country));

  void setLocale(Locale loc) {
    state = loc;
    Localization.setCurrent(loc);
    //Intl.defaultLocale = loc.languageCode;
    AppSettings.setLang(loc.languageCode);
  }
}

final localeStateProvider = StateNotifierProvider<LocaleState, Locale>((ref) {
  return LocaleState(inf.languageCode, inf.countryCode);
});

// class LocaleNotifier extends ChangeNotifier {
//   final Ref _ref;

//   LocaleNotifier(this._ref) {
//     _ref.listen<Locale>(
//       localeStateProvider,
//       (_, __) => notifyListeners(),
//     );
//   }
// }
