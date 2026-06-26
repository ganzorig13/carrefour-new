import 'package:carrefour/library/library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfilePhoneWidget extends StatelessWidget {
  final String phone;
  final VoidCallback onEdit;
  const ProfilePhoneWidget({
    super.key,
    required this.phone,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      sliver: SliverToBoxAdapter(
        child: IOCardWidget(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Тохиргоо',
                      style: IOStyles.body1Bold.copyWith(
                        color: IOColors.brand700,
                      ),
                    ),
                    IconButton(
                      onPressed: onEdit,
                      style: IconButton.styleFrom(
                        padding: EdgeInsets.zero,
                        iconSize: 20,
                      ),
                      icon: SvgPicture.asset(
                        'assets/icons/edit.svg',
                        width: 20,
                        height: 20,
                        colorFilter: const ColorFilter.mode(
                          IOColors.textSecondary,
                          BlendMode.srcIn,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Утасны дугаар',
                      style: IOStyles.body2Medium.copyWith(
                        color: IOColors.textTertiary,
                      ),
                    ),
                    Text(
                      phone,
                      style: IOStyles.body2Medium.copyWith(
                        color: IOColors.brand700,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
