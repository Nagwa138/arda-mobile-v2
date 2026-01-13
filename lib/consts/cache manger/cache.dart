import 'package:shared_preferences/shared_preferences.dart';

class CacheManger {
  static SharedPreferences? sharedPreferences;
  static Map? userData;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> saveData(String key, dynamic value) async {
    await sharedPreferences?.setString(key, value.toString());
  }

  static Future<String?> getData(String key) async {
    return await sharedPreferences?.getString(key);
  }

  static Future<void> removeData(String key) async {
    await sharedPreferences?.remove(key);
  }

  static Future<void> clearData() async {
    await sharedPreferences?.clear();
  }

  static Future<Map<String, dynamic>> loadAllData() async {
    Map<String, dynamic> data = {};
    Set? keys = sharedPreferences?.getKeys();
    if (keys != null) {
      for (String key in keys) {
        String? value = await sharedPreferences?.getString(key);
        if (value != null) {
          data[key] = value;
        }
      }
    }
    userData = data;

    return data;
  }

  // Check if this is the first time the app is launched
  static Future<bool> isFirstLaunch() async {
    String? onboardingCompleted = await getData('onboarding_completed');
    return onboardingCompleted == null || onboardingCompleted != 'true';
  }

  // Mark onboarding as completed
  static Future<void> setOnboardingCompleted() async {
    await saveData('onboarding_completed', 'true');
  }
}
