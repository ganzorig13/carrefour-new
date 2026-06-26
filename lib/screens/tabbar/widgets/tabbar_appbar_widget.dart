import 'package:carrefour/library/library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TabBarAppBarWidget extends IOAppBar {
  TabBarAppBarWidget({
    super.key,
    required int count,
    required VoidCallback onTapNotfication,
  }) : super(
          leading: Padding(
            padding: const EdgeInsets.only(left: 24),
            child: SvgPicture.asset(
              'assets/icons/logo.horizontal.svg',
            ),
          ),
          leadingWidth: 124,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: onTapNotfication,
                icon: Badge.count(
                  count: count,
                  child: SvgPicture.asset(
                    'assets/icons/notification.svg',
                    colorFilter: const ColorFilter.mode(
                      IOColors.backgroundPrimary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
}
