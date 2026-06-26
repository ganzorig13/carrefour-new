import 'package:flutter/material.dart';
import 'package:carrefour/library/library.dart';
import 'package:flutter_svg/svg.dart';

class IOAppBar extends AppBar {
  IOAppBar({
    super.key,
    super.bottom,
    // super.flexibleSpace,
    super.leading,
    super.leadingWidth,
    super.actions,
    String? titleText,
    Widget? title,
  }) : super(
          backgroundColor: IOColors.brand500,
          iconTheme: const IconThemeData(
            color: IOColors.backgroundPrimary,
          ),
          centerTitle: true,
          flexibleSpace: Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(
              'assets/icons/logo.half.svg',
              alignment: Alignment.topRight,
            ),
          ),
          title: title ??
              Text(
                titleText ?? '',
                style: IOStyles.body1Bold.copyWith(
                  color: IOColors.backgroundPrimary,
                ),
              ),
        );
}
