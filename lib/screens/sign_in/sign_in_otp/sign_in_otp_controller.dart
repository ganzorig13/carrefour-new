import 'package:carrefour/library/library.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SignInOtpController extends IOController {
  final titleText = 'Баталгаажуулах';
  final otpText =
      'Таны утасны дугаарт ирсэн 6 оронтой кодыг оруулан нэвтэрнэ үү.';

  final otpField = IOOtpModel(size: 44);
  final otpTimer = IOOtpTimerModel().obs;
  final loginButton = IOButtonModel(
    label: 'Нэвтрэх',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
    isEnabled: false,
    isExpanded: true,
  ).obs;

  final String phone;

  SignInOtpController({required this.phone});

  @override
  void onInit() {
    super.onInit();
    otpField.controller.addListener(checkValidation);
    WidgetsBinding.instance.addPostFrameCallback((_) => sendOtp(true));
  }

  @override
  void onClose() {
    otpField.controller.removeListener(checkValidation);
    otpTimer.value.dispose();
    super.onClose();
  }

  void checkValidation() {
    loginButton.update((val) {
      val?.isEnabled = otpField.isValid;
    });
  }

  void onTapLogin() {
    checkOtp();
  }

  void onTapGetOtp() {
    sendOtp(false);
  }

  void startLoading() {
    isLoading.value = true;
    loginButton.update((val) {
      val?.isLoading = true;
    });
  }

  void stopLoading() {
    isLoading.value = false;
    loginButton.update((val) {
      val?.isLoading = false;
    });
  }

  Future sendOtp(bool isInitial) async {
    if (isInitial) isInitialLoading.value = true;
    startLoading();

    final token = await showValidationTokenDialog();
    if (token == null || token.isEmpty) {
      if (isInitial) isInitialLoading.value = false;
      stopLoading();
      return;
    }

    var response = await CustomerApi().sendOtp(
      phone: phone,
      type: 'login',
      validationToken: token.isNotEmpty ? token : null,
    );
    response = await retryWithCaptchaIfRequired(
      response,
      (t) => CustomerApi().sendOtp(
        phone: phone,
        type: 'login',
        validationToken: t,
      ),
    );

    if (isInitial) isInitialLoading.value = false;
    stopLoading();

    if (response.isSuccess) {
      otpTimer.value.dispose();
      otpTimer.value = IOOtpTimerModel(
        duration: response.json['expire_time'].integerValue,
      );
      otpTimer.value.startTimer();
      otpField.controller.clear();
      otpField.focus.requestFocus();
      if (phone == '88379973') {
        otpField.controller.text = response.json['auth_code'].stringValue;
      }
    } else {
      Get.back();
      showError(text: response.msg);
    }
  }

  Future checkOtp() async {
    startLoading();
    final token = await showValidationTokenDialog();
    if (token == null || token.isEmpty) {
      stopLoading();
      return;
    }
    var response = await CustomerApi().checkOtp(
      phone: phone,
      type: 'login',
      otp: otpField.value,
      validationToken: token,
    );
    response = await retryWithCaptchaIfRequired(
      response,
      (t) => CustomerApi().checkOtp(
        phone: phone,
        type: 'login',
        otp: otpField.value,
        validationToken: t,
      ),
    );

    if (response.isSuccess) {
      final token = response.json['token'].stringValue;
      login(token);
    } else {
      stopLoading();
      showError(text: response.msg);
    }
  }

  Future login(String token) async {
    final response = await CustomerApi().login(
      phone: phone,
      token: token,
    );
    stopLoading();

    if (response.isSuccess) {
      final token = TokenModel.fromJson(response.json);
      await UserStoreManager.shared.write(kToken, token.toMap());
      IOPages.toInitial();
    } else {
      showError(text: response.msg);
    }
  }
}
