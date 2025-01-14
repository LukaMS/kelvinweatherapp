import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static late SharedPreferences _preferences;

  static const _keyUnit = 'unit';

  static Future init() async => 
      _preferences = await SharedPreferences.getInstance();

  static Future setUnit(String unit) async => 
      await _preferences.setString(_keyUnit, unit);

  static String getUnit() => 
      _preferences.getString(_keyUnit) ?? 'Kelvin';

}