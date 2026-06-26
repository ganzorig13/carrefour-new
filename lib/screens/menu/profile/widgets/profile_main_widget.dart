import 'package:carrefour/library/library.dart';
import 'package:flutter/material.dart';

class ProfileMainWidget extends StatelessWidget {
  final UserModel user;
  const ProfileMainWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      sliver: SliverToBoxAdapter(
        child: IOCardWidget(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Ерөнхий мэдээлэл',
                style: IOStyles.body1Bold.copyWith(
                  color: IOColors.brand700,
                ),
              ),
              const SizedBox(height: 16),
              _Row(
                title: 'Овог',
                value: user.lastName,
              ),
              const SizedBox(height: 12),
              _Row(
                title: 'Нэр',
                value: user.firstName,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final String title;
  final String value;
  const _Row({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: IOStyles.body2Medium.copyWith(
            color: IOColors.textTertiary,
          ),
        ),
        Text(
          value,
          style: IOStyles.body2Medium.copyWith(
            color: IOColors.brand700,
          ),
        ),
      ],
    );
  }
}
