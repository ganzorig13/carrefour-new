import 'package:carrefour/library/library.dart';
import 'package:get/get.dart';

class BiometricController extends IOController {
  final titleText = 'Та цаашид Face ID ашиглахыг зөвшөөрч байна уу';
  final bodyText =
      'Та Face ID - г идэвхжүүлснээр цаашид гүйлгээний нууц үг хийх шаардлагагүй.';
  final declineButton = IOButtonModel(
    label: 'Татгалзах',
    type: IOButtonType.secondary,
    size: IOButtonSize.medium,
  );

  final acceptButton = IOButtonModel(
    label: 'Зөвшөөрөх',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
  );

  void onTapDecline() {
    Get.back();
  }

  void onTapAccept() async {
    final value = await BiometricManager.shared.checkAuthenticate();

    if (value.success) {
      await BiometricManager.shared.saveBiometric();
      Get.back(result: true);
    } else {
      showError(text: value.errorMessage);
    }
  }
}
