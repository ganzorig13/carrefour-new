import 'package:carrefour/screens/screens.dart';
import 'package:get/get.dart';

class AuthRoute {
  static toSignInOtp({required String phone}) {
    return Get.to(
      () => const SignInOtpScreen(),
      binding: SignInOtpBinding(phone: phone),
    );
  }

  static toSignInPin() {
    return Get.to(
      () => const SignInPinScreen(),
      binding: SignInPinBinding(),
    );
  }

  static toSignUpPhone() {
    return Get.to(
      () => const SignUpPhoneScreen(),
      binding: SignUpPhoneBinding(),
    );
  }

  static toSignUpOtp(SignUpModel model) {
    return Get.to(
      () => const SignUpOtpScreen(),
      binding: SignUpOtpBinding(model: model),
    );
  }

  static toSignUpInfo(SignUpModel model) {
    return Get.to(
      () => const SignUpInfoScreen(),
      binding: SignUpInfoBinding(model: model),
    );
  }

  static toSignUpTerms(SignUpModel model) {
    return Get.to(
      () => const SignUpTermsScreen(),
      binding: SignUpTermsBinding(model: model),
    );
  }

  static toSignUpPin(SignUpModel model) {
    return Get.to(
      () => const SignUpPinScreen(),
      binding: SignUpPinBinding(model: model),
    );
  }
}
