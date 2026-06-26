import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:g_json/g_json.dart';
import 'package:get/get.dart';

class TabBarController extends IOController {
  final tabItems = [
    TabBarModel(
      icon: 'shop.svg',
      label: 'Нүүр',
      screen: HomeScreen(),
    ),
    TabBarModel(
      icon: 'catalogy.svg',
      label: 'Каталоги',
      screen: CatalogListScreen(),
    ),
    TabBarModel(
      icon: 'qr.svg',
      isFab: true,
      screen: Container(),
    ),
    TabBarModel(
      icon: 'coupon.svg',
      label: 'Урамшуулал',
      screen: PromoPageScreen(),
    ),
    TabBarModel(
      icon: 'menu.svg',
      label: 'Цэс',
      screen: MenuTabScreen(),
    ),
  ];
  final tabIndex = 0.obs;
  final notificationCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    ClientManager.getNotificationCount();
    checkPin();
  }

  @override
  void onReady() {
    super.onReady();
    checkAction();
  }

  void onTapQr() async {
    final qr = await AppRoute.toQrScan();
    if (qr == null) return;
    QrPaySheet(qrString: qr).show();
  }

  void onTabChanged(int index) {
    tabIndex.value = index;
  }

  void checkAction() async {
    final message = await FirebaseMessaging.instance.getInitialMessage();
    if (message == null) return;
    if (HelperManager.isLogged) {
      DynamicRoute.handleAction(JSON(message.data));
    }
  }

  Future checkPin() async {
    await ClientManager.getUserInfo();
    if (HelperManager.user.password.isEmpty) {
      AuthRoute.toSignInPin();
    }
  }
}
