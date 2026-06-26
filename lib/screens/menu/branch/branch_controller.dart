import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BranchController extends IOController {
  final titleText = 'Салбарын байршил';
  final branchItems = <BranchModel>[].obs;

  final mapController = Completer<GoogleMapController>();
  final markers = <Marker>[].obs;

  late BitmapDescriptor activeMarkerIcon;
  late BitmapDescriptor inactiveMarkerIcon;

  int selectedMarkerId = 0;
  int previousMarkerId = 0;

  @override
  void onInit() {
    super.onInit();
    getBranches();
  }

  void setMarker() {
    markers.value = branchItems
        .map(
          (element) => Marker(
            markerId: MarkerId(element.id.toString()),
            position: LatLng(element.latitude, element.longtitude),
            icon: inactiveMarkerIcon,
            onTap: () => onTapMarker(element),
          ),
        )
        .toList();

    updateGoogleCameraToFit();
  }

  void onTapMarker(BranchModel item) async {
    selectedMarkerId = item.id;
    final previousMarkerIndex = markers.indexWhere(
      (e) => e.markerId.value == previousMarkerId.toString(),
    );
    final currentMarkerIndex = markers.indexWhere(
      (e) => e.markerId.value == selectedMarkerId.toString(),
    );
    if (previousMarkerIndex != -1) {
      markers[previousMarkerIndex] = markers[previousMarkerIndex].copyWith(
        iconParam: inactiveMarkerIcon,
      );
    }
    if (currentMarkerIndex != -1) {
      markers[currentMarkerIndex] = markers[currentMarkerIndex].copyWith(
        iconParam: activeMarkerIcon,
      );
    }
    markers.refresh();
    previousMarkerId = selectedMarkerId;
    Get.bottomSheet(BranchMapInfoWidget(branch: item)).then((_) {
      onDeselectMarker();
    });
  }

  void onDeselectMarker() {
    final previousMarkerIndex = markers.indexWhere(
      (e) => e.markerId.value == previousMarkerId.toString(),
    );
    if (previousMarkerIndex != -1) {
      markers[previousMarkerIndex] = markers[previousMarkerIndex].copyWith(
        iconParam: inactiveMarkerIcon,
      );
    }
  }

  void onMapCreated(GoogleMapController value) {
    mapController.complete(value);
  }

  Future initMarkerIcon() async {
    final size = Platform.isIOS ? 80 : 73;
    final activeBytes = await getBytesFromAsset(
      'assets/images/marker.active.png',
      size,
    );
    final inactiveBytes = await getBytesFromAsset(
      'assets/images/marker.inactive.png',
      size,
    );
    inactiveMarkerIcon = BitmapDescriptor.fromBytes(inactiveBytes!);
    activeMarkerIcon = BitmapDescriptor.fromBytes(activeBytes!);
  }

  Future<Uint8List?> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        ?.buffer
        .asUint8List();
  }

  Future getBranches() async {
    isInitialLoading.value = true;
    await initMarkerIcon();
    final response = await InfoApi().getBranches();
    isInitialLoading.value = false;

    if (response.isSuccess) {
      branchItems.value =
          response.data.listValue.map((e) => BranchModel.fromJson(e)).toList();
      setMarker();
    } else {
      Get.back();
      showError(text: response.msg);
    }
  }

  Future updateGoogleCamera(double latitude, double longitude) async {
    final ctrlr = await mapController.future;
    await ctrlr.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 12,
        ),
      ),
    );
  }

  Future updateGoogleCameraToFit() async {
    double southWestLat = 0;
    double southWestLon = 0;
    double northEastLat = 0;
    double northEastLon = 0;

    for (int i = 0; i < markers.length; i++) {
      final branch = markers[i];
      if (i == 0) {
        southWestLat = branch.position.latitude;
        southWestLon = branch.position.longitude;
        northEastLat = branch.position.latitude;
        northEastLon = branch.position.longitude;
      }
      if (southWestLat > branch.position.latitude) {
        southWestLat = branch.position.latitude;
      }
      if (southWestLon > branch.position.longitude) {
        southWestLon = branch.position.longitude;
      }
      if (northEastLat < branch.position.latitude) {
        northEastLat = branch.position.latitude;
      }
      if (northEastLon < branch.position.longitude) {
        northEastLon = branch.position.longitude;
      }
    }

    final ctrlr = await mapController.future;

    ctrlr.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(southWestLat, southWestLon),
          northeast: LatLng(northEastLat, northEastLon),
        ),
        50,
      ),
    );
  }
}
