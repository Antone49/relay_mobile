import 'package:get/get.dart';
import 'package:relay_mobile/feature/home/view/settings_screen.dart';
import 'feature/home/view/home_screen.dart';

class AppRoutes {

  static const String homeScreen = '/home_screen';
  static const String settingsScreen = '/settings_screen';
  static String initialRoute = homeScreen;

  static List<GetPage> pages = [
    GetPage(
      name: homeScreen,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: settingsScreen,
      page: () => const SettingsScreen(),
    ),
  ];
}