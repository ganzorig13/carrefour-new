import 'package:carrefour/library/library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MenuProfileWidget extends StatelessWidget {
  final UserModel user;
  final VoidCallback onTap;

  const MenuProfileWidget({
    super.key,
    required this.user,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 76,
      child: IOCardWidget(
        padding: EdgeInsets.zero,
        child: IOButtonOpacityWidget(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox.square(
                  dimension: 60,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: user.avatar.isEmpty
                        ? Image.asset(
                            'assets/images/user.placeholder.png',
                          )
                        : IOImageNetworkWidget(
                            imageUrl: user.photoUrl,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${user.firstName} ${user.lastName}',
                        overflow: TextOverflow.ellipsis,
                        style: IOStyles.body2Bold.copyWith(
                          color: IOColors.brand700,
                        ),
                      ),
                      Text(
                        user.phone,
                        overflow: TextOverflow.ellipsis,
                        style: IOStyles.caption1Medium.copyWith(
                          color: IOColors.brand400,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
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
      ),
    );
  }
}
