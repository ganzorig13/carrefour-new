import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:g_json/g_json.dart';
import 'package:get/get.dart';

class SignUpTermsController extends IOController {
  final titleText = ' Үйлчилгээний нөхцөл';
  final acceptText = 'Үйлчилгээний нөхцөл зөвшөөрөх';
  final terms = SignUpTermsModel.fromJson(JSON.nil).obs;
  final nextButton = IOButtonModel(
    label: 'Үргэлжлүүлэх',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
    isEnabled: false,
  ).obs;

  final isChecked = false.obs;
  final SignUpModel model;
  SignUpTermsController({required this.model});

  @override
  void onInit() {
    super.onInit();
    ever(isChecked, (value) {
      nextButton.update((val) {
        val?.isEnabled = value;
      });
    });
    getTerms();
  }

  void onTapNext() {
    AuthRoute.toSignUpPin(model);
  }

  Future getTerms() async {
    isInitialLoading.value = true;
    final response = await InfoApi().getTerms();
    isInitialLoading.value = false;

    if (response.isSuccess) {
      final items = response.data.listValue;
      if (items.isNotEmpty) {
        terms.value = SignUpTermsModel.fromJson(items.first);
      } else {
        Get.back();
        showError(text: 'Үйлчилгээний нөхцөл олдсонгүй');
      }
    } else {
      Get.back();
      showError(text: response.msg);
    }
  }
}
