import 'package:platemate_user/data_models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static const ACCESS_TOKEN_KEY = 'accessToken';
  static const USER_KEY = 'user';
  static const CITY_KEY = 'city';
  static const SEARCH_HISTORY_KEY = 'search-history';

  static SharedPreferences? preferences;

  static void storeAccessToken(String? token) {
    if (token != null) {
      preferences?.setString(ACCESS_TOKEN_KEY, token);
    }
  }

  static String? get accessToken => preferences?.getString(ACCESS_TOKEN_KEY);

  static void clear() {
    preferences?.clear();
  }

  static void logout() {
    preferences?.remove(ACCESS_TOKEN_KEY);
    preferences?.remove(USER_KEY);
  }

  static void storeCity(String location) {
    preferences?.setString(CITY_KEY, location);
  }

  static String get city => preferences?.getString(CITY_KEY) ?? '';

  //
  // static void storeLocation(List<double> coordinates) {
  //   preferences?.setString(LOCATION_KEY,
  //       json.encode(List<dynamic>.from(coordinates.map((x) => x))));
  // }
  //
  // static List<double> get location =>
  //     preferences?.getString(LOCATION_KEY)?.isEmpty ?? true
  //         ? []
  //         : List<double>.from(
  //                 json.decode(preferences?.getString(LOCATION_KEY) ?? ''))
  //             .map((x) => x)
  //             .toList();

  static void storeUser({UserResponse? user, String? response}) {
    if (user != null)
      preferences?.setString(USER_KEY, userResponseToJson(user));
    else {
      if (response == null || response.isEmpty)
        throw 'No value to store. Either a User object or a String response is required to store in preference.';
      else
        preferences?.setString(USER_KEY, response);
    }
  }

  static UserResponse? get user => preferences?.getString(USER_KEY) == null
      ? null
      : userResponseFromJson(preferences?.getString(USER_KEY) ?? '');

  /// SEARCH HISTORY ______________________________________________

  static void storeSearchItemsList(List<String> searchItems) {
    preferences?.setStringList(SEARCH_HISTORY_KEY, searchItems);
  }

  static List<String> storeSearchHistoryItem(String item) {
    List<String> items = (preferences?.getStringList(SEARCH_HISTORY_KEY) == null
        ? []
        : preferences?.getStringList(SEARCH_HISTORY_KEY))!;
    if (items.contains(item)) {
      items.remove(item);
    }
    items.insert(0, item);
    preferences?.setStringList(SEARCH_HISTORY_KEY, items);
    return items;
  }

  static List<String> removeSearchHistoryItem(String item) {
    List<String> items = (preferences?.getStringList(SEARCH_HISTORY_KEY) == null
        ? []
        : preferences?.getStringList(SEARCH_HISTORY_KEY))!;
    if (items.contains(item)) {
      items.remove(item);
    }
    preferences?.setStringList(SEARCH_HISTORY_KEY, items);
    return items;
  }

  static void clearSearchHistory() {
    preferences?.remove(SEARCH_HISTORY_KEY);
  }

  static List<String> get searchHistoryItems =>
      preferences?.getStringList(SEARCH_HISTORY_KEY) == null
          ? []
          : preferences?.getStringList(SEARCH_HISTORY_KEY) ?? [];
}
