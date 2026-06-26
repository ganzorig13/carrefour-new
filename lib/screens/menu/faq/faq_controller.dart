import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:get/get.dart';

class FaqController extends IOController {
  final items = <FaqModel>[].obs;
  @override
  void onReady() {
    super.onReady();
    getData();
  }

  Future getData() async {
    isInitialLoading.value = true;
    final response = await InfoApi().getFaq();
    isInitialLoading.value = false;

    if (response.success) {
      items.value =
          response.data.listValue.map((e) => FaqModel.fromJson(e)).toList();
    } else {
      Get.back();
      showError(text: response.msg);
    }
  }
}
