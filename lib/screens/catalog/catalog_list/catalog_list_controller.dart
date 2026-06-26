import 'dart:async';

import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CatalogListController extends IOController {
  final refreshController = RefreshController();
  final catalogItems = <CatalogListModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getCatalog(true);
  }

  Future onRefresh() async {
    getCatalog(false);
  }

  Future getCatalog(bool isInitial) async {
    if (isInitial) isInitialLoading.value = true;
    final response = await CustomerApi().getCatalogList();
    if (isInitial) isInitialLoading.value = false;
    refreshController.refreshCompleted();

    if (response.isSuccess) {
      var items = response.data.listValue
          .map((e) => CatalogListModel.fromJson(e))
          .toList();
      items.sort((a, b) => a.orderValue.compareTo(b.orderValue));
      catalogItems.value = items;
    }
  }
}
