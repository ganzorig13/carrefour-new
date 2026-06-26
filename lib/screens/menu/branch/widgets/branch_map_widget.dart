import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BranchMapWidget extends StatefulWidget {
  final Set<Marker> markers;
  final ValueChanged<GoogleMapController> onMapCreated;
  const BranchMapWidget({
    super.key,
    required this.markers,
    required this.onMapCreated,
  });

  @override
  State<BranchMapWidget> createState() => _BranchMapWidgetState();
}

class _BranchMapWidgetState extends State<BranchMapWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GoogleMap(
      initialCameraPosition: const CameraPosition(
        target: LatLng(47.920449615346534, 106.91731888047495),
        zoom: 14,
      ),
      padding: EdgeInsets.only(top: 76, bottom: Get.mediaQuery.padding.bottom),
      markers: widget.markers,
      myLocationEnabled: false,
      myLocationButtonEnabled: false,
      onMapCreated: widget.onMapCreated,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
