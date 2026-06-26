import 'package:carrefour/library/library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileAdditionalWidget extends StatelessWidget {
  final UserModel user;
  final VoidCallback onEdit;
  const ProfileAdditionalWidget({
    super.key,
    required this.user,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      sliver: SliverToBoxAdapter(
        child: IOCardWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Нэмэлт мэдээлэл',
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
              _Row(
                title: 'И-мэйл хаяг',
                value: user.email,
              ),
              const SizedBox(height: 12),
              _Row(
                title: 'Төрсөн он сар өдөр',
                value: user.dateBirth,
              ),
              const SizedBox(height: 12),
              _Row(
                title: 'Оршин суугаа дүүрэг, хороо',
                value:
                    '${user.districtName.isNotEmpty ? user.districtName : '-'}, ${user.khorooName.isNotEmpty ? user.khorooName : '-'}',
              ),
              const SizedBox(height: 12),
              _Row(
                title: 'Хүйс',
                value: user.gender == 0
                    ? 'Эрэгтэй'
                    : user.gender == 1
                        ? 'Эмэгтэй'
                        : '-',
              ),
              const SizedBox(height: 12),
              _Row(
                title: 'Ам бүлийн тоо',
                value: user.familyCount == 0 ? '' : user.familyCount.toString(),
              ),
              const SizedBox(height: 16),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: IOStyles.body2Medium.copyWith(
              color: IOColors.textTertiary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value.isNotEmpty ? value : '-',
            style: IOStyles.body2Medium.copyWith(
              color: IOColors.brand700,
            ),
          ),
        ],
      ),
    );
  }
}
