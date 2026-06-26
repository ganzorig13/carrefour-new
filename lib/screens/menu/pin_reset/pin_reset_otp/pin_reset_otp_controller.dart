import 'package:carrefour/library/library.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class PinResetOtpController extends IOController {
  final phone = HelperManager.user.phone;

  PinResetOtpController();

  final titleText = 'Нууц үг сэргээх';
  final otpText =
      'Таны утасны дугаарт ирсэн 6 оронтой кодыг оруулан нууц үгээ сэргээнэ үү. ';
  final otpField = IOOtpModel(size: 44);
  final otpTimer = IOOtpTimerModel().obs;
  final nextButton = IOButtonModel(
    label: 'Үргэлжлүүлэх',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
    isEnabled: false,
    isExpanded: true,
  ).obs;

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
    nextButton.update((val) {
      val?.isEnabled = otpField.isValid;
    });
  }

  void onTapNext() {
    checkOtp();
  }

  void onTapGetOtp() {
    sendOtp(false);
  }

  Future sendOtp(bool isInitial) async {
    if (isInitial) isInitialLoading.value = true;
    isLoading.value = true;
    nextButton.update((val) {
      val?.isEnabled = true;
    });

    final token = await showValidationTokenDialog();
    if (token == null || token.isEmpty) {
      if (isInitial) isInitialLoading.value = false;
      isLoading.value = false;
      nextButton.update((val) {
        val?.isEnabled = false;
      });
      return;
    }

    var response = await CustomerApi().sendOtp(
      phone: phone,
      type: 'password',
      validationToken: token.isNotEmpty ? token : null,
    );
    response = await retryWithCaptchaIfRequired(
      response,
      (t) => CustomerApi().sendOtp(
        phone: phone,
        type: 'password',
        validationToken: t,
      ),
    );

    if (isInitial) isInitialLoading.value = false;
    isLoading.value = false;
    nextButton.update((val) {
      val?.isEnabled = false;
    });

    if (response.isSuccess) {
      otpTimer.value.dispose();
      otpTimer.value = IOOtpTimerModel(
        duration: response.json['expire_time'].integerValue,
      );
      otpTimer.value.startTimer();
      otpField.controller.clear();
      otpField.focus.requestFocus();
    } else {
      Get.back();
      showError(text: response.msg);
    }
  }

  Future checkOtp() async {
    isLoading.value = true;
    nextButton.update((val) {
      val?.isEnabled = true;
    });

    final token = await showValidationTokenDialog();
    if (token == null || token.isEmpty) {
      isLoading.value = false;
      nextButton.update((val) {
        val?.isEnabled = false;
      });
      return;
    }
    var response = await CustomerApi().checkOtp(
      phone: phone,
      type: 'password',
      otp: otpField.value,
      validationToken: token,
    );
    response = await retryWithCaptchaIfRequired(
      response,
      (t) => CustomerApi().checkOtp(
        phone: phone,
        type: 'password',
        otp: otpField.value,
        validationToken: t,
      ),
    );

    isLoading.value = false;
    nextButton.update((val) {
      val?.isEnabled = false;
    });

    if (response.isSuccess) {
      final token = response.json['token'].stringValue;
      MenuRoute.toPinResetNew(phone: phone, token: token);
    } else {
      showError(text: response.msg);
    }
  }
}
