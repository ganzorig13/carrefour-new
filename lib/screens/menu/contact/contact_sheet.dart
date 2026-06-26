import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ContactSheet extends StatelessWidget {
  const ContactSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ContactController(),
      builder: (controller) {
        return Obx(
          () => Container(
            decoration: const BoxDecoration(
              color: IOColors.backgroundSecondary,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 8),
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: IOColors.textQuarternary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Холбоо барих',
                      style: IOStyles.body1Bold.copyWith(
                        color: IOColors.brand700,
                      ),
                    ),
                    const SizedBox(height: 16),
                    IOCardWidget(
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final item = controller.items[index];
                          return SizedBox(
                            height: 56,
                            child: IOButtonOpacityWidget(
                              onTap: () => controller.onTapItem(item),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    SizedBox.square(
                                      dimension: 40,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: SvgPicture.asset(
                                          'assets/icons/${switch (item.keyword) {
                                            'phone' => 'phone.svg',
                                            'website' => 'web.svg',
                                            'facebook' => 'facebook.svg',
                                            _ => 'phone.svg',
                                          }}',
                                          colorFilter: const ColorFilter.mode(
                                            IOColors.brand500,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        item.title,
                                        style: IOStyles.body2Bold.copyWith(
                                          color: IOColors.brand600,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                      ),
                                      child: SvgPicture.asset(
                                        'assets/icons/chevron.right.svg',
                                        width: 24,
                                        height: 24,
                                        colorFilter: const ColorFilter.mode(
                                          IOColors.brand600,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(
                            thickness: 1,
                            height: 1,
                            color: IOColors.strokePrimary,
                          );
                        },
                        itemCount: controller.items.length,
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
