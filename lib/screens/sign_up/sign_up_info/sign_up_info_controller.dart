import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:get/get.dart';

class SignUpInfoController extends IOController {
  final titleText = 'Хувийн мэдээлэл';
  final surname = IOTextfieldModel(
    label: 'Таны овог',
    placeholder: 'Таны овог',
    validators: [ValidatorType.notEmpty],
  );
  final name = IOTextfieldModel(
    label: 'Таны нэр',
    placeholder: 'Таны нэр',
    validators: [ValidatorType.notEmpty],
  );
  final nextButton = IOButtonModel(
    label: 'Үргэлжлүүлэх',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
    isEnabled: false,
  ).obs;

  final SignUpModel model;
  SignUpInfoController({required this.model});

  @override
  void onInit() {
    super.onInit();
    surname.status.addListener(checkValidation);
    name.status.addListener(checkValidation);
  }

  void checkValidation() {
    nextButton.update((val) {
      val?.isEnabled = surname.isValid && name.isValid;
    });
  }

  void onTapNext() {
    model.lastName = surname.value;
    model.firstName = name.value;
    AuthRoute.toSignUpTerms(model);
  }
}
