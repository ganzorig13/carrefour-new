import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SignUpOtpController extends IOController {
  final titleText = 'Баталгаажуулах';
  final otpText =
      'Таны утасны дугаарт ирсэн 6 оронтой кодыг оруулан бүртгүүлнэ үү. ';
  final otpField = IOOtpModel(size: 44);
  final otpTimer = IOOtpTimerModel().obs;
  final nextButton = IOButtonModel(
    label: 'Үргэлжлүүлэх',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
    isEnabled: false,
    isExpanded: true,
  ).obs;

  final SignUpModel model;
  SignUpOtpController({required this.model});

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
      phone: model.phone,
      type: 'register',
      validationToken: token.isNotEmpty ? token : null,
    );
    response = await retryWithCaptchaIfRequired(
      response,
      (t) => CustomerApi().sendOtp(
        phone: model.phone,
        type: 'register',
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
      phone: model.phone,
      type: 'register',
      otp: otpField.value,
      validationToken: token,
    );
    response = await retryWithCaptchaIfRequired(
      response,
      (t) => CustomerApi().checkOtp(
        phone: model.phone,
        type: 'register',
        otp: otpField.value,
        validationToken: t,
      ),
    );

    isLoading.value = false;
    nextButton.update((val) {
      val?.isEnabled = false;
    });

    if (response.isSuccess) {
      model.otpToken = response.json['token'].stringValue;
      AuthRoute.toSignUpInfo(model);
    } else {
      showError(text: response.msg);
    }
  }
}
