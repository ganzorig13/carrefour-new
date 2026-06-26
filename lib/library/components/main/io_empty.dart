import 'package:flutter/material.dart';
import 'package:carrefour/library/library.dart';
import 'package:flutter_svg/svg.dart';

class IOEmptyWidget extends StatelessWidget {
  final String? icon;
  final String text;
  const IOEmptyWidget({
    super.key,
    this.icon,
    this.text = 'Илэрц хоосон',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null) ...[
            SizedBox(
              width: 145,
              height: 168,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/empty.background.svg',
                  ),
                  SvgPicture.asset(
                    'assets/icons/$icon',
                    width: 40,
                    height: 40,
                    colorFilter: const ColorFilter.mode(
                      IOColors.brand200,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            )
          ],
          Text(
            text,
            textAlign: TextAlign.center,
            style: IOStyles.body1Medium.copyWith(
              color: IOColors.brand500,
            ),
          ),
        ],
      ),
    );
  }
}
