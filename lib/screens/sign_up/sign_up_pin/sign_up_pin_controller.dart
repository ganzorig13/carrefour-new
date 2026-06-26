import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class SignUpPinController extends IOController {
  final titleText = 'Гүйлгээний нууц үг үүсгэх';
  final pinText = 'Та гүйлгээний нууц үгээ үүсгэнэ үү';
  final confirm = 'Гүйлгээний нууц үгээ давтан оруулна уу';
  final pinField = IOOtpModel(length: 4, isSecure: true);
  final confirmField = IOOtpModel(length: 4, isSecure: true);
  final nextButton = IOButtonModel(
    label: 'Үргэлжлүүлэх',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
    isExpanded: true,
  ).obs;

  final SignUpModel model;
  SignUpPinController({required this.model});

  @override
  void onInit() {
    super.onInit();
    pinField.controller.addListener(() {
      // if (pinField.isValid) {
      //   pinField.focus.unfocus();
      // }
      checkValidation();
    });
    confirmField.controller.addListener(() {
      // if (confirmField.isValid) {
      //   confirmField.focus.unfocus();
      // }
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
    registerUser();
  }

  Future registerUser() async {
    model.password = pinField.value;

    isLoading.value = true;
    nextButton.update((val) {
      val?.isLoading = true;
    });
    final response = await CustomerApi().register(model: model);
    isLoading.value = false;
    nextButton.update((val) {
      val?.isLoading = false;
    });

    if (response.isSuccess) {
      final token = TokenModel.fromJson(response.json);
      await UserStoreManager.shared.write(kToken, token.toMap());
      IOPages.toInitial();

      showBiometric();
      IOToast(
        text: response.msg,
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
