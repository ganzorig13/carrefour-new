import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/menu/menu.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContactController extends IOController {
  final items = <ContactModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    getContact();
  }

  Future getContact() async {
    isInitialLoading.value = true;
    final response = await InfoApi().getContact();
    isInitialLoading.value = false;

    if (response.isSuccess) {
      final itemList = response.data.listValue
          .map(
            (e) => ContactModel.fromJson(e),
          )
          .toList();
      itemList.sort((a, b) => a.orderValue.compareTo(b.orderValue));
      items.value = itemList;
    } else {
      Get.back();
      showError(text: response.msg);
    }
  }

  Future onTapItem(ContactModel item) async {
    switch (item.keyword) {
      case 'phone':
        final url = 'tel:${item.value}';
        await launchUrlString(url);
        break;

      case 'email':
        final url = 'mailto:${item.value}';
        await launchUrlString(url);
        break;

      default:
        await launchUrlString(
          item.value,
          mode: LaunchMode.externalApplication,
        );
        break;
    }
  }
}
