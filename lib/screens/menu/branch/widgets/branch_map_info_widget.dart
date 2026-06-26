import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BranchMapInfoWidget extends StatelessWidget {
  final BranchModel branch;
  const BranchMapInfoWidget({super.key, required this.branch});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: IOColors.backgroundPrimary,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      child: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: IOColors.textTertiary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              AspectRatio(
                aspectRatio: 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: IOImageNetworkWidget(
                    imageUrl: branch.photoUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                branch.name,
                textAlign: TextAlign.left,
                style: IOStyles.body2Semibold.copyWith(
                  color: IOColors.brand600,
                ),
              ),
              const SizedBox(height: 8),
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
                  const SizedBox(width: 4),
                  Text(
                    branch.phone,
                    style: IOStyles.caption1Medium.copyWith(
                      color: IOColors.brand400,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
