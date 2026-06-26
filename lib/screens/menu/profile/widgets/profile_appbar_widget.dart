import 'package:carrefour/library/library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileAppbarWidget extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onTap;
  const ProfileAppbarWidget({
    super.key,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: kToolbarHeight + 152,
      pinned: true,
      backgroundColor: IOColors.brand500,
      title: Text(
        'Хувийн мэдээлэл',
        style: IOStyles.body1Bold.copyWith(
          color: IOColors.backgroundPrimary,
        ),
      ),
      iconTheme: const IconThemeData(
        color: IOColors.backgroundPrimary,
      ),
      stretch: true,
      flexibleSpace: Stack(
        children: [
          FlexibleSpaceBar(
            background: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: Container(
                        color: IOColors.brand500,
                      ),
                    ),
                    Container(
                      color: IOColors.backgroundSecondary,
                      height: 75,
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: GestureDetector(
                      onTap: onTap,
                      child: SizedBox.square(
                        dimension: 102,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: imageUrl.isEmpty
                                    ? Image.asset(
                                        'assets/images/user.placeholder.png',
                                      )
                                    : IOImageNetworkWidget(
                                        imageUrl: imageUrl,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            Transform.translate(
                              offset: const Offset(8, 8),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: IOColors.secondary500,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 2,
                                      color: IOColors.backgroundPrimary,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: SvgPicture.asset(
                                    'assets/icons/edit.svg',
                                    width: 12,
                                    height: 12,
                                    colorFilter: const ColorFilter.mode(
                                      IOColors.backgroundPrimary,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(
              'assets/icons/logo.half.svg',
            ),
          ),
        ],
      ),
    );
  }
}
