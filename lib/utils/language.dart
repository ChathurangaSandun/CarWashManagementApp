import 'package:listar_flutter/configs/config.dart';

class UtilLanguage {
  ///Get Language Global Language Name
  static String getGlobalLanguageName(String code) {
    switch (code) {
      case "vi":
        return "Vietnamses";
      case "en":
        return "English";
      case "ar":
        return "Arabic";
      case "zh":
        return "Chinese";
      case "ko":
        return "Korean";
      case "ja":
        return "Japanese";
      default:
        return "Country code not found";
    }
  }

  static bool isRTL() {
    switch (AppLanguage.defaultLanguage.languageCode) {
      case "ar":
        return true;
      default:
        return false;
    }
  }

  ///Singleton factory
  static final UtilLanguage _instance = UtilLanguage._internal();

  factory UtilLanguage() {
    return _instance;
  }

  UtilLanguage._internal();
}
