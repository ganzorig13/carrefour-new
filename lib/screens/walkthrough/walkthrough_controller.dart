import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/walkthrough/walkthrough.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum WalkPosition { left, right }

class WalkthroughController extends IOController {
  final items = [
    WalkthroughModel(
      title: 'Санхүүгээ хянах боломж',
      body:
          'Худалдан авалтын зарцуулалтаа дэлгэрэнгүйгээр бүрэн харах боломжтой.',
      image: 'walk.1.jpg',
    ),
    WalkthroughModel(
      title: 'E-Barimt',
      body:
          'Худалдан авалтын баримт автоматаар бүртгэгдэх, түүнийг дэлгэрэнгүйгээр харах боломжтой.',
      image: 'walk.2.jpg',
    ),
    WalkthroughModel(
      title: 'Онооны хуримтлалаараа худалдан авалт хийх боломж',
      body:
          'Худалдан авалтын оноогоо цуглуулан өндөр үнийн дүнтэй сонгогдсон бараа бүтээгдэхүүнийг худалдан авах боломжтой',
      image: 'walk.3.jpg',
    ),
  ];

  final currentIndex = 0.0.obs;
  final direction = WalkPosition.left.obs;
  final pageTextController = PageController();

  final skipButton = IOButtonModel(
    label: 'Алгасах',
    type: IOButtonType.textGray,
    size: IOButtonSize.small,
    enabledForegroundColor: IOColors.backgroundPrimary,
    focusedBackgroundColor: Colors.white.withOpacity(0.3),
  );
  final previousButton = IOButtonIconModel(
    icon: 'arrow.left.svg',
    type: IOButtonType.oulineBrand,
    size: IOButtonSize.large,
    borderRadius: 56,
  );
  final nextButton = IOButtonIconModel(
    icon: 'arrow.right.svg',
    type: IOButtonType.primary,
    size: IOButtonSize.large,
    borderRadius: 56,
  );

  String get image =>
      'assets/images/${items[currentIndex.value.toInt()].image}';

  @override
  void onInit() {
    super.onInit();
    pageTextController.addListener(() {
      direction.value = (pageTextController.page ?? 0.0) > currentIndex.value
          ? WalkPosition.left
          : WalkPosition.right;
      currentIndex.value = pageTextController.page ?? 0.0;
    });
  }

  void onNextPage() {
    if (currentIndex.value == items.length - 1) {
      onLogin();
    } else {
      pageTextController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void onBackPage() {
    pageTextController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void onLogin() async {
    await DeviceStoreManager.shared.write(kWalkthroughShowed, true);
    IOPages.toInitial();
  }
}
