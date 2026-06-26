import 'package:carrefour/screens/screens.dart';
import 'package:get/get.dart';
import 'package:carrefour/library/library.dart';

class IOPages {
  static String get initial => HelperManager.isWalkthroughShowed
      ? HelperManager.isLogged
          ? TabBarScreen.routeName
          : SignInMainScreen.routeName
      : WalkthroughScreen.routeName;

  static final pages = [
    GetPage(
      name: WalkthroughScreen.routeName,
      page: () => const WalkthroughScreen(),
      binding: WalkthroughBinding(),
    ),
    GetPage(
      name: SignInMainScreen.routeName,
      page: () => const SignInMainScreen(),
      binding: SignInMainBinding(),
    ),
    GetPage(
      name: TabBarScreen.routeName,
      page: () => const TabBarScreen(),
      binding: TabBarBinding(),
    ),
  ];

  static toInitial() {
    Get.offAllNamed(initial);
  }

  static toSignIn() {
    // Get.offAllNamed(SignInScreen.routeName);
  }
}
