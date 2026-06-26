import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:carrefour/library/library.dart';

class IORegisterSheet extends StatelessWidget {
  final String? selectedChar;
  final List<String> chars;
  const IORegisterSheet({
    super.key,
    required this.chars,
    this.selectedChar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: IOColors.backgroundPrimary,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 56,
              child: Stack(
                children: [
                  const Positioned.fill(
                    child: Center(
                      child: Text(
                        'Регистр',
                        style: IOStyles.body1Bold,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: Get.back,
                      icon: SvgPicture.asset(
                        'assets/icons/close.svg',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: IOColors.strokePrimary,
              thickness: 1,
              height: 1,
            ),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              crossAxisCount: 6,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              children: chars
                  .map(
                    (e) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          width: 1,
                          color: IOColors.strokePrimary,
                        ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Get.back(result: e);
                          },
                          borderRadius: BorderRadius.circular(8),
                          child: Center(
                            child: Text(
                              e,
                              style: IOStyles.body2Medium,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const Divider(
              color: IOColors.strokePrimary,
              thickness: 1,
              height: 1,
            ),
          ],
        ),
      ),
    );
  }

  Future<String?>? show() {
    return Get.bottomSheet(this, isScrollControlled: true);
  }
}
