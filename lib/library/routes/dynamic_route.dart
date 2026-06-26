import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/home/home.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:g_json/g_json.dart';
import 'package:get/get.dart';

class DynamicRoute {
  static bool shouldShowDialog(JSON data) {
    return data['jump_feedback'].booleanValue;
  }

  static onNotification(NotificationResponse detail) {
    final data = JSON.parse(detail.payload ?? '');
    handleAction(data);
  }

  static onForegroundNotifcation(JSON data) {
    final action = data['action_type'].stringValue;
    final id = data['action_id'].integerValue;
    final jumpToFeedback = data['jump_feedback'].booleanValue;
    if (action == 'gift_card') {
      if (Get.isBottomSheetOpen ?? false) {
        Get.back();
      }
      return IOAlert(
        type: IOAlertType.success,
        titleText: data['title'].stringValue,
        bodyText: data['body'].stringValue,
        icon: 'assets/icons/gift-pop-up.svg',
        acceptText: 'Хаах',
      ).show();
    }
    if (jumpToFeedback) {
      if (action == 'purchase') {
        AppRoute.toRatingPoint(id: id);
      }
      if (action == 'mission') {
        IOAlert(
          type: IOAlertType.success,
          titleText: data['title'].stringValue,
          bodyText: data['body'].stringValue,
          icon: 'assets/icons/alert.gift.svg',
          acceptText: 'Хаах',
        ).show();
      }
    }
  }

  static handleAction(JSON data) {
    final action = data['action_type'].stringValue;
    final id = data['action_id'].integerValue;
    final url = data['url'].stringValue;

    switch (action) {
      case 'catalog':
        AppRoute.toCatalogInfo(catalogId: id);
        break;
      case 'banner':
        final bannerList = Get.find<HomeController>().promoBannerItems;
        int index = bannerList.indexWhere((e) => e.id == id);
        if (index == -1) {
          index = 0;
        }
        AppRoute.toPromoBanner(items: bannerList, index: index);
        break;
      case 'mission':
        break;
      case 'purchase':
        final jumpToFeedback = data['jump_feedback'].booleanValue;
        if (jumpToFeedback) {
          AppRoute.toRatingPoint(id: id);
        } else {
          MenuRoute.toPurchaseHistory();
        }
        break;
      case 'url':
        MenuRoute.toWebview(
          title: data['title'].stringValue,
          url: url,
        );
        break;
      default:
        break;
    }
  }
}
