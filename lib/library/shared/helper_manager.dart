import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:carrefour/library/library.dart';

class HelperManager {
  static bool get isWalkthroughShowed =>
      DeviceStoreManager.shared.data<bool>(kWalkthroughShowed) ?? false;
  static bool get isLogged => UserStoreManager.shared.hasData(kToken);

  static String get appToken =>
      DeviceStoreManager.shared.data<String>(kAppToken) ?? '';

  static bool get isEnabledBiometricPin =>
      UserStoreManager.shared.data<bool>(kBiometricEnabledPin) ?? false;

  static TokenModel get token {
    final json = UserStoreManager.shared.jsonData(kToken);
    return TokenModel.fromJson(json);
  }

  static String get fcmToken {
    return DeviceStoreManager.shared.data<String>(kFcmToken) ?? 'NOTOKEN';
  }

  static UserModel get user {
    final json = UserStoreManager.shared.jsonData(kUser);
    return UserModel.fromJson(json);
  }

  static int get notifCount {
    return UserStoreManager.shared.data<int>(kNotificationCount) ?? 0;
  }

  static final deviceInfoPlugin = DeviceInfoPlugin();

  static String get os {
    return switch (defaultTargetPlatform) {
      TargetPlatform.android => 'android',
      TargetPlatform.iOS => 'ios',
      _ => '',
    };
  }

  static Future<String> get deviceModel async {
    return switch (defaultTargetPlatform) {
      TargetPlatform.android => (await deviceInfoPlugin.androidInfo).device,
      TargetPlatform.iOS => (await deviceInfoPlugin.iosInfo).model,
      _ => '',
    };
  }

  static Future<String> get version async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  static Future<String> get appVersion async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String build = packageInfo.buildNumber;
    return '$version-$build';
  }
}
