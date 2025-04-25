class AppSettings {
  static WorkMode workMode = WorkMode.Offline;
  static setLang(String language) {
    _appLanguage = language;
  }

  static String _appLanguage = 'ku';
}

enum WorkMode { Offline, online }

bool isDeviceConnected = false;
