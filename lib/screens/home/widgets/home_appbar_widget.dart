import 'package:carrefour/library/library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

class HomeAppBarWidget extends StatelessWidget {
  final Widget point;
  final int count;
  final VoidCallback onTapNotfication;
  const HomeAppBarWidget({
    super.key,
    required this.point,
    required this.count,
    required this.onTapNotfication,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: kToolbarHeight + 192,
      pinned: true,
      backgroundColor: IOColors.brand500,
      centerTitle: false,
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
      stretch: true,
      flexibleSpace: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(
              'assets/icons/logo.half.svg',
            ),
          ),
          FlexibleSpaceBar(
            background: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: SizedBox(
                    height: 144,
                    child: point,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
