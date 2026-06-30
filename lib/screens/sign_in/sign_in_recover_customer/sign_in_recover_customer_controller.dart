import 'package:carrefour/library/library.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SignInRecoverCustomerController extends IOController {
  final titleText = 'Утсаны дугаар солих';

  final emailField = IOTextfieldModel(
    label: 'И-мэйл хаяг',
    placeholder: 'И-мэйл хаяг',
    validators: [ValidatorType.email],
    keyboardType: TextInputType.emailAddress,
    maxLength: 50,
  );

  final newPhoneField = IOTextfieldModel(
    label: 'Шинэ утасны дугаар',
    placeholder: 'Утасны дугаар',
    validators: [ValidatorType.phone],
    keyboardType: TextInputType.phone,
    maxLength: 8,
  );

  final requestButton = IOButtonModel(
    label: 'Код хүсэх',
    type: IOButtonType.primary,
    size: IOButtonSize.large,
    isEnabled: false,
  ).obs;

  final msgCodeField = IOTextfieldModel(
    label: 'SMS код',
    placeholder: '6 оронтой код',
    validators: [ValidatorType.pin],
    keyboardType: TextInputType.number,
    maxLength: 6,
  );

  final emailCodeField = IOTextfieldModel(
    label: 'И-мэйл код',
    placeholder: '6 оронтой код',
    validators: [ValidatorType.pin],
    keyboardType: TextInputType.number,
    maxLength: 6,
  );

  final validateButton = IOButtonModel(
    label: 'Баталгаажуулах',
    type: IOButtonType.primary,
    size: IOButtonSize.large,
    isEnabled: false,
  ).obs;

  final authId = RxnInt();
  final showValidateStep = false.obs;

  @override
  void onInit() {
    super.onInit();

    emailField.status.addListener(_updateRequestButton);
    newPhoneField.status.addListener(_updateRequestButton);

    msgCodeField.status.addListener(_updateValidateButton);
    emailCodeField.status.addListener(_updateValidateButton);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateRequestButton();
    });
  }

  @override
  void onClose() {
    emailField.focusNode.dispose();
    newPhoneField.focusNode.dispose();
    msgCodeField.focusNode.dispose();
    emailCodeField.focusNode.dispose();
    super.onClose();
  }

  void _updateRequestButton() {
    requestButton.update((val) {
      val?.isEnabled =
          emailField.isValid && newPhoneField.isValid && !isLoading.value;
    });
  }

  void _updateValidateButton() {
    validateButton.update((val) {
      val?.isEnabled = msgCodeField.isValid &&
          emailCodeField.isValid &&
          authId.value != null &&
          !isLoading.value;
    });
  }

  void startLoading() {
    isLoading.value = true;
    requestButton.update((val) {
      val?.isLoading = true;
    });
    validateButton.update((val) {
      val?.isLoading = true;
    });
  }

  void stopLoading() {
    isLoading.value = false;
    requestButton.update((val) {
      val?.isLoading = false;
    });
    validateButton.update((val) {
      val?.isLoading = false;
    });
  }

  Future onTapRequestRecover() async {
    Get.focusScope?.unfocus();

    if (!emailField.isValid || !newPhoneField.isValid) {
      showError(text: 'Мэдээллээ зөв оруулна уу');
      return;
    }

    startLoading();

    // If this flow is protected by captcha in backend, reuse the existing dialog.
    final validationToken = await showValidationTokenDialog();
    if (validationToken == null || validationToken.isEmpty) {
      stopLoading();
      return;
    }

    final response = await CustomerApi().recover(
      email: emailField.value,
      newPhone: newPhoneField.value,
      validationToken: validationToken,
    );

    stopLoading();

    if (response.isSuccess) {
      authId.value = response.json['data']['auth_id'].integerValue;
      showValidateStep.value = true;
      _updateValidateButton();

      // Optional: clear entered codes if user came back.
      msgCodeField.controller.clear();
      emailCodeField.controller.clear();
    } else {
      showError(text: response.msg);
    }
  }

  Future onTapValidate() async {
    Get.focusScope?.unfocus();

    final id = authId.value;
    if (id == null) {
      showError(text: 'Нэгдүгээр алхмаа хийгээгүй байна');
      return;
    }

    // Ensure we recompute validate button state when user types codes.
    _updateValidateButton();

    if (!msgCodeField.isValid || !emailCodeField.isValid) {
      showError(text: 'Кодуудаа зөв оруулна уу');
      return;
    }

    startLoading();

    final validationToken = await showValidationTokenDialog();
    if (validationToken == null || validationToken.isEmpty) {
      stopLoading();
      return;
    }

    final response = await CustomerApi().recoverValidate(
      authId: id,
      msgCode: msgCodeField.value,
      emailCode: emailCodeField.value,
      validationToken: validationToken,
    );

    stopLoading();

    if (response.isSuccess) {
      final token = response.json['token'].stringValue;
      if (token.isNotEmpty) {
        await UserStoreManager.shared
            .write(kToken, TokenModel.fromJson(response.json).toMap());
      }
      IOPages.toInitial();
    } else {
      showError(text: response.msg);
    }
  }
}
