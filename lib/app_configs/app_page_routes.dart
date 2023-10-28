import 'package:platemate_user/pages/authenticaton/onboarding/avatar_selection_page.dart';
import 'package:platemate_user/pages/authenticaton/login/login_page.dart';
import 'package:platemate_user/pages/authenticaton/onboarding/preferences_first_page.dart';
import 'package:platemate_user/pages/authenticaton/onboarding/preferences_second_page.dart';
import 'package:platemate_user/pages/authenticaton/signup/signup_page.dart';
import 'package:platemate_user/pages/checkout/checkout_page.dart';
import 'package:platemate_user/pages/dashboard/dashboard_page.dart';
import 'package:platemate_user/pages/demo/create_footprint_page.dart';
import 'package:platemate_user/pages/orders/order_details_page.dart';
import 'package:platemate_user/pages/orders/orders_page.dart';
import 'package:platemate_user/pages/qr_scanner/qr_scanner_page.dart';
import 'package:platemate_user/pages/restaurant_details/restaurant_details_page.dart';
import 'package:platemate_user/pages/restaurant_menu/restaurant_menu_page.dart';
import 'package:platemate_user/pages/splash/splash_screen.dart';
import 'package:platemate_user/pages/web_view/web_view_page.dart';
import 'package:get/get.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class AppPages {
  /// NOT TO BE USE NOW
  static final pages = [
    GetPage(name: SplashPage.routeName, page: () => SplashPage()),
    GetPage(name: LoginPage.routeName, page: () => LoginPage()),
    GetPage(name: SignupPage.routeName, page: () => SignupPage()),
    GetPage(
        name: PreferencesFirstPage.routeName,
        page: () => PreferencesFirstPage()),
    GetPage(
        name: PreferencesSecondPage.routeName,
        page: () => PreferencesSecondPage()),
    GetPage(
      name: AvatarSelectionPage.routeName,
      page: () => AvatarSelectionPage(),
    ),
    GetPage(
      name: WebViewPage.routeName,
      page: () => WebViewPage(),
    ),
    GetPage(
      name: CreateFootPrintsPage.routeName,
      page: () => CreateFootPrintsPage(),
    ),
    GetPage(
      name: RestaurantDetailsPage.routeName,
      page: () => RestaurantDetailsPage(),
    ),
    GetPage(
      name: DashboardPage.routeName,
      page: () => DashboardPage(),
      children: [],
    ),
    GetPage(
      name: QRSScannerPage.routeName,
      page: () => QRSScannerPage(),
    ),
    GetPage(
      name: CheckOutPage.routeName,
      page: () => CheckOutPage(),
    ),
    GetPage(
      name: RestaurantMenuPage.routeName,
      page: () => RestaurantMenuPage(),
    ),
    GetPage(
      name: OrdersPage.routeName,
      page: () => OrdersPage(),
    ),
    GetPage(
      name: OrderDetailsPage.routeName,
      page: () => OrderDetailsPage(),
    ),
  ];
}
