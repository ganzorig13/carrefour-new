import 'package:carrefour/library/library.dart';
import 'package:get/get.dart';

class TermsController extends IOController {
  final titleText = ' Үйлчилгээний нөхцөл';
  final htmlString = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future getData() async {
    isInitialLoading.value = true;
    final response = await InfoApi().getTerms();
    isInitialLoading.value = false;

    if (response.isSuccess) {
      final items = response.data.listValue;
      if (items.isNotEmpty) {
        htmlString.value = items.first['description'].stringValue;
      } else {
        Get.back();
        showError(text: 'Нууцлалын бодлого олдсонгүй');
      }
    } else {
      Get.back();
      showError(text: response.msg);
    }
  }
}
