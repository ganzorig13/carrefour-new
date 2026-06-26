import 'dart:io';
import 'dart:math';

import 'package:carrefour/library/components/main/io_pop_up.dart';
import 'package:carrefour/library/library.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart'
    show HtmlWidget;
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class MainController extends IOController {
  final point = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    checkAppVersion();
    getFcmToken();
  }

  Future checkAppVersion() async {
    final response = await CustomerApi().appVersionCheck();

    if (response.isSuccess) {
      final needsUpdate = response.data['needs_update'].booleanValue;

      if (needsUpdate) {
        IOPopup(
          marginPadding: 40,
          children: [
            SvgPicture.asset(
              'assets/icons/alert.warning.svg',
              width: 146,
              height: 132,
            ),
            const SizedBox(height: 16),
            Text(
              'Шинэ хувилбар татах',
              style: IOStyles.body1Bold,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: HtmlWidget(
                '''
              <p style="text-align: center;">
                Илүү хурдан ажиллагаа, сайжруулсан хэрэглэгчийн туршлага, шинэ боломжуудтай танилцаарай.
              </p>
              ''',
              ),
            ),
            IOButtonWidget(
              model: IOButtonModel(
                size: IOButtonSize.large,
                type: IOButtonType.primary,
                label: 'Шинэчлэх',
              ),
              onPressed: () {
                final url = Uri.parse(
                  Platform.isAndroid
                      ? "https://play.google.com/store/apps/details?id=mn.io.carrefour"
                      : "https://apps.apple.com/app/id6504396133",
                );
                launchUrl(url, mode: LaunchMode.externalApplication);
              },
            )
          ],
        ).show();
      }
    }
  }

  Future<bool> shouldUpdate(String version) async {
    final appVersion = await HelperManager.appVersion;

    List<int> remoteVersion = version
        .split('.')
        .map((subString) => int.tryParse(subString) ?? 0)
        .toList();

    List<int> myVersion = appVersion
        .split('.')
        .map((subString) => int.tryParse(subString) ?? 0)
        .toList();

    for (int i = 0; i < min(remoteVersion.length, myVersion.length); i++) {
      if (remoteVersion[i] > myVersion[i]) {
        return true;
      } else if (remoteVersion[i] < myVersion[i]) {
        return false;
      }
    }
    return false;
  }

  getFcmToken() async {
    final token = await FirebaseMessaging.instance.getToken();

    Log.warning(token ?? 'NOTOKEN', 'FCM Token');
    DeviceStoreManager.shared.write(kFcmToken, token ?? 'NOTOKEN');
  }
  //
}
