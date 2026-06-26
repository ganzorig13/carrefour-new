import 'package:carrefour/library/library.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class SignInPinController extends IOController {
  final titleText = 'Гүйлгээний нууц үг үүсгэх';
  final pinText = 'Та гүйлгээний нууц үгээ үүсгэнэ үү';
  final confirm = 'Гүйлгээний нууц үгээ давтан оруулна уу';
  final pinField = IOOtpModel(length: 4, isSecure: true);
  final confirmField = IOOtpModel(length: 4, isSecure: true);
  final nextButton = IOButtonModel(
    label: 'Үүсгэх',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
    isExpanded: true,
  ).obs;

  @override
  void onInit() {
    super.onInit();
    pinField.controller.addListener(() {
      checkValidation();
    });
    confirmField.controller.addListener(() {
      checkValidation();
    });
  }

  void checkValidation() {
    nextButton.update((val) {
      val?.isEnabled = pinField.isValid && confirmField.isValid;
    });
  }

  void onTapNext() {
    if (pinField.value != confirmField.value) {
      showError(text: 'Давтсан нууц үг таарахгүй байна');
      return;
    }
    createPin();
  }

  Future createPin() async {
    isLoading.value = true;
    nextButton.update((val) {
      val?.isLoading = true;
    });
    final response = await CustomerApi().createPin(pin: pinField.value);
    isLoading.value = false;
    nextButton.update((val) {
      val?.isLoading = false;
    });

    if (response.isSuccess) {
      Get.back();
      ClientManager.getUserInfo();
      showBiometric();
      IOToast(
        text: 'Гүйлгээний нууц үг амжилттай үүслээ',
        backgroundColor: IOColors.successPrimary,
        gravity: ToastGravity.TOP,
        time: 2,
      ).show();
    } else {
      showError(text: response.msg);
    }
  }

  Future showBiometric() async {
    if (await BiometricManager.shared.isAvailable) {
      AppRoute.toBiometricEnable();
    }
  }
}
