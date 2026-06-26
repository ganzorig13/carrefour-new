import 'package:carrefour/library/library.dart';

class ClientManager {
  static Future getUserInfo() async {
    final response = await CustomerApi().getUserInfo();
    if (response.success) {
      final user = UserModel.fromJson(response.data);
      await UserStoreManager.shared.write(kUser, user.toMap());
    }
  }

  static Future getNotificationCount() async {
    final response = await CustomerApi().getNotificationCount();
    if (response.success) {
      final count = response.json['notif_count'].integerValue;
      await UserStoreManager.shared.write(
        kNotificationCount,
        count,
      );
    }
  }
}
