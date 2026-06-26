import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class CatalogInfoScreen extends GetView<CatalogInfoController> {
  const CatalogInfoScreen({super.key});

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
      body: Obx(
        () => controller.isInitialLoading.value
            ? const IOLoading(
                color: IOColors.backgroundPrimary,
              )
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                    ),
                    child: LinearProgressIndicator(
                      minHeight: 2,
                      borderRadius: BorderRadius.circular(2),
                      backgroundColor: IOColors.backgroundPrimary.withOpacity(
                        0.4,
                      ),
                      color: IOColors.backgroundPrimary,
                      value: controller.readPercent.value,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                controller.detail.value.name,
                                style: IOStyles.body2Medium.copyWith(
                                  color: IOColors.backgroundPrimary,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/calendar.svg',
                                    width: 16,
                                    height: 16,
                                    colorFilter: const ColorFilter.mode(
                                      IOColors.brand100,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    controller.detail.value.startToEnd,
                                    style: IOStyles.caption1Medium.copyWith(
                                      color: IOColors.brand100,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 4,
                          ),
                          child: Text(
                            '${controller.currentPage.value}/${controller.totalPage.value}',
                            style: IOStyles.caption1Bold.copyWith(
                              color: IOColors.backgroundPrimary,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SfPdfViewerTheme(
                    data: SfPdfViewerThemeData(
                      backgroundColor: IOColors.brand900,
                      progressBarColor: IOColors.brand500,
                    ),
                    child: Expanded(
                      child: SfPdfViewer.network(
                        controller.detail.value.pdfUrl,
                        key: controller.pdfKey,
                        controller: controller.pdfController,
                        scrollDirection: PdfScrollDirection.vertical,
                        canShowScrollHead: false,
                        pageLayoutMode: PdfPageLayoutMode.continuous,
                        interactionMode: PdfInteractionMode.pan,
                        onDocumentLoaded: (details) {
                          controller.onPageLoaded();
                        },
                        onPageChanged: controller.onPageChanged,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
