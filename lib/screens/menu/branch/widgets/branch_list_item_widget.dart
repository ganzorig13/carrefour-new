import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BranchListItemWidget extends StatelessWidget {
  final BranchModel branch;
  const BranchListItemWidget({super.key, required this.branch});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 132,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 108,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: IOImageNetworkWidget(
                imageUrl: branch.photoUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  branch.name,
                  style: IOStyles.body2Semibold.copyWith(
                    color: IOColors.brand600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  branch.address,
                  style: IOStyles.caption1Regular.copyWith(
                    color: IOColors.brand400,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/clock.svg',
                      width: 16,
                      height: 16,
                      colorFilter: const ColorFilter.mode(
                        IOColors.brand400,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      branch.workHours,
                      style: IOStyles.caption1Medium.copyWith(
                        color: IOColors.brand400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/phone.svg',
                      width: 16,
                      height: 16,
                      colorFilter: const ColorFilter.mode(
                        IOColors.brand400,
                        BlendMode.srcIn,
                      ),
                    ),
                    if (branch.phone.isNotEmpty) ...[
                      const SizedBox(width: 4),
                      Text(
                        branch.phone,
                        style: IOStyles.caption1Medium.copyWith(
                          color: IOColors.brand400,
                        ),
                      ),
                    ],
                    if (branch.phone2.isNotEmpty) ...[
                      const SizedBox(width: 4),
                      Text(
                        branch.phone,
                        style: IOStyles.caption1Medium.copyWith(
                          color: IOColors.brand400,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
