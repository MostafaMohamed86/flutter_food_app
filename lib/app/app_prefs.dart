import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/app/constants.dart';
import 'package:shopping_app/presentation/resources/language_manager.dart';

const String PREFS_KEY_LANG = "PRESFS_KEY_LANG";
class AppPreferences{
  final SharedPreferences _sharedPreferences;
  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async{
    String? language = _sharedPreferences.getString(PREFS_KEY_LANG);
    if(language != null && language.isNotEmpty){
      return language;
    }else{
      return LanguageType.ENGLISH.getValue();
    }
  }
}