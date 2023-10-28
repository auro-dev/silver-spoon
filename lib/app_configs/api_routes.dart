import 'environment.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
mixin ApiRoutes {
  static const baseUrl = Environment.baseApiUrl;
  static const v1 = 'v1';
  static const upload = '$v1/upload';

  static const String geoCoderApi =
      'https://maps.googleapis.com/maps/api/geocode/json';

  static const String emailVerification = "$v1/verification";
  static const String authenticateEmail = "authentication";
  static const String authentication = "$v1/login/phone-login";
  static const String user = '$v1/user';
  static const String signInWithGoogle = "$v1/google-login";
  static const String signInWithFacebook = '$v1/login/facebook-login';
  static const String signInWithApple = '$v1/login/apple-login';
  static String authenticateJwt = '$v1/authenticate-jwt';
  static const String authenticatePhone = "$v1/authenticate-phone";
  static const String phoneVerification = "$v1/phone-verification";
  static const String city = "$v1/city";
  static const String social_login = "$v1/login/social-login";
  static const String event_budget = "$v1/event-management/event-budget";
  static const String sub_event_budget =
      "$v1/sub-event-management/sub-event-budget";
  static const String feedback = "$v1/feedback";
  static const String support_ticket = "$v1/help-center/support-ticket";
  static const String support_chat = "$v1/chat/chat-message";
  static const String chats = "$v1/chat/chat-message";
  static const String like = "$v1/likes";
  static const String comments = "$v1/comment";
  static const String booking_distribution =
      "$v1/dashboard/admin/booking-distribution";
  static const String statistics = "$v1/dashboard/admin/booking";
  static const String cuisines = "$v1/cuisines";
  static const String tastePreferences = "$v1/taste-preference";
  static const String foodCategories = "$v1/food-categories";
  static const String recommendedRestaurants = "$v1/recommended-restaurants";
  static const String order = "$v1/order";
  static const String transaction = "$v1/transaction";
  static const String restaurantMenuDetails = "$v1/restaurant-menu-details";
  static const String menuCustomisations = "$v1/menu-item-customisations";
}
