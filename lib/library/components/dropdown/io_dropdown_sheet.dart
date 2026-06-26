import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:carrefour/library/library.dart';

class IODropdownSheet<T> extends StatelessWidget {
  final String title;
  final List<IODropdownSheetModel<T>> items;
  const IODropdownSheet({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      maxChildSize: 0.8,
      builder: (context, scroll) {
        return Container(
          decoration: const BoxDecoration(
            color: IOColors.backgroundPrimary,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(8),
            ),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 56,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Center(
                          child: Text(
                            title,
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
                Expanded(
                  child: ListView.separated(
                    controller: scroll,
                    padding: const EdgeInsets.all(16),
                    itemBuilder: (context, index) {
                      return Container(
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
                              Get.back(result: items[index]);
                            },
                            borderRadius: BorderRadius.circular(8),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                              child: Text(
                                items[index].name,
                                style: IOStyles.body2Medium,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 8);
                    },
                    itemCount: items.length,
                  ),
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
      },
    );
  }

  Future<IODropdownSheetModel<T>?>? show() {
    return Get.bottomSheet(this, isScrollControlled: true);
  }
}
