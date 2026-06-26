import 'package:carrefour/library/library.dart';
import 'package:carrefour/main_controller.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:g_json/g_json.dart';
import 'package:get/get.dart';

class PromoDetailController extends IOController {
  final main = Get.find<MainController>();
  final int id;
  final promo = PromoListModel.fromJson(JSON.nil).obs;
  final rewards = <PromoRewardModel>[].obs;
  final mission = <PromoMissionModel>[].obs;

  final pointButton = IOButtonModel(
    label: 'Бэлэг идэвхижүүлэх',
    type: IOButtonType.primary,
    size: IOButtonSize.large,
  ).obs;

  PromoDetailController({required this.id});

  bool get hasPoint => promo.value.progressType == PromoType.point;
  bool get hasPointButton =>
      hasPoint &&
      !promo.value.isCompleted &&
      main.point.value >= promo.value.pointAmount;

  @override
  void onInit() {
    super.onInit();
    getData(true);
  }

  Future getData(bool isInitial) async {
    if (isInitial) isInitialLoading.value = true;
    final response = await CustomerApi().getPromoDetail(id: id);
    if (isInitial) isInitialLoading.value = false;
    if (response.isSuccess) {
      promo.value = PromoListModel.fromJson(response.data);
      rewards.value = response.data['rewards'].listValue
          .map((e) => PromoRewardModel.fromJson(e))
          .toList();
      mission.value = response.data['mission_products'].listValue
          .map((e) => PromoMissionModel.fromJson(e))
          .toList();
    } else {}
  }

  Future onTapReward(PromoRewardModel item) async {
    if (item.status == PromoRewardStatus.active) {
      await PromoQrSheet(model: item).show();
      getData(false);
    }
  }

  Future onTapSetComplete() async {
    final accept = await showWarning(
      text: 'Та бэлэг идэвхижүүлэхдээ итгэлтэй байна уу',
      acceptText: 'Тийм',
      cancelText: 'Үгүй',
    );

    if (accept == null) return;

    isLoading.value = true;
    pointButton.update((val) {
      val?.isLoading = true;
    });

    final response = await CustomerApi().setCompletePromo(
      missionId: promo.value.id,
    );

    isLoading.value = false;
    pointButton.update((val) {
      val?.isLoading = false;
    });

    if (response.isSuccess) {
      getData(true);
    } else {
      showError(text: response.msg);
    }
  }
}
