import 'package:get/get.dart';
import 'feature/home/view/home_screen.dart';

class AppRoutes {

  static const String homeScreen = '/home_screen';
  static String initialRoute = homeScreen;

  static List<GetPage> pages = [
    GetPage(
      name: homeScreen,
      page: () => const HomeScreen(),
    ),
  ];
}