import 'dart:io';

import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:g_json/g_json.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class CatalogInfoController extends IOController {
  final int catalogId;
  final GlobalKey<SfPdfViewerState> pdfKey = GlobalKey();
  final pdfController = PdfViewerController();
  final detail = CatalogListModel.fromJson(JSON.nil).obs;
  final tempFile = Rx<File?>(null);

  final totalPage = 0.obs;
  final currentPage = 0.obs;
  final readPercent = 0.0.obs;

  CatalogInfoController({required this.catalogId});

  @override
  void onInit() {
    super.onInit();
    getInfo();
  }

  void onPageChanged(PdfPageChangedDetails detail) {
    currentPage.value = detail.newPageNumber;
    setReadPercent();
  }

  void onPageLoaded() {
    totalPage.value = pdfController.pageCount;
    currentPage.value = pdfController.pageNumber;
    setReadPercent();
  }

  void setReadPercent() {
    if (totalPage.value == 0) {
      readPercent.value = 0;
    }
    readPercent.value = currentPage.value / totalPage.value;
  }

  void onPdfLoaded(PdfDocumentLoadedDetails pdf) async {
    final tempPath = await getTemporaryDirectory();
    final tempFileOnPath = File('${tempPath.path}/${detail.value.id}.pdf');
    tempFile.value = await tempFileOnPath.writeAsBytes(
      await pdf.document.save(),
    );
  }

  Future getInfo() async {
    isInitialLoading.value = true;
    final response = await CustomerApi().getCatalogInfo(id: catalogId);

    if (response.isSuccess) {
      detail.value = CatalogListModel.fromJson(response.data);
      // await initializeFile();
      isInitialLoading.value = false;
    } else {
      isInitialLoading.value = false;
      Get.back();
      showError(text: response.msg);
    }
  }

  Future initializeFile() async {
    final tempPath = await getTemporaryDirectory();
    final tempFileOnPath = File('${tempPath.path}/${detail.value.id}.pdf');
    final checkFileExist = await tempFileOnPath.exists();
    if (checkFileExist) {
      tempFile.value = tempFileOnPath;
    }
  }
}
