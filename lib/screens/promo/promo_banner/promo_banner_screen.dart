import 'package:cached_network_image/cached_network_image.dart';
import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:story/story.dart';

class PromoBannerScreen extends GetView<PromoBannerController> {
  const PromoBannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      backgroundColor: IOColors.brand900,
      appBar: AppBar(
        backgroundColor: IOColors.brand900,
        leading: const SizedBox.shrink(),
        actions: [
          IconButton(
            onPressed: Get.back,
            icon: SvgPicture.asset(
              'assets/icons/close.svg',
              colorFilter: const ColorFilter.mode(
                IOColors.backgroundPrimary,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: StoryPageView(
          backgroundColor: IOColors.brand900,
          indicatorVisitedColor: IOColors.backgroundPrimary,
          indicatorUnvisitedColor: IOColors.backgroundPrimary.withOpacity(0.4),
          indicatorPadding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
          itemBuilder: (context, pageIndex, storyIndex) {
            final story = controller.items[storyIndex];
            return Stack(
              children: [
                Positioned.fill(
                  child: Container(color: IOColors.brand900),
                ),
                Positioned.fill(
                  child: StoryImage(
                    key: ValueKey(story.id),
                    imageProvider: CachedNetworkImageProvider(story.photoUrl),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ],
            );
          },
          gestureItemBuilder: (context, pageIndex, storyIndex) {
            final story = controller.items[storyIndex];
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      story.title,
                      style: IOStyles.body1Medium.copyWith(
                        color: IOColors.backgroundPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: IOColors.brand800,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '${storyIndex + 1}/${controller.items.length}',
                      style: IOStyles.caption1Bold.copyWith(
                        color: IOColors.backgroundPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          storyLength: (pageIndex) {
            return controller.items.length;
          },
          initialStoryIndex: (pageIndex) {
            return controller.index;
          },
          onPageLimitReached: Get.back,
          pageLength: 1,
        ),
      ),
    );
  }
}
