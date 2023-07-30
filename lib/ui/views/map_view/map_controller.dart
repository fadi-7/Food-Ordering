import 'dart:async';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../app/core/services/base_controller.dart';
import '../../../app/core/utiles/map_utile.dart';
import '../../shared/utils.dart';

class MapController extends BaseController {
  MapController(this.currentLocation);

  late LocationData currentLocation;

  final Completer<GoogleMapController> controller =
      Completer<GoogleMapController>();

  late CameraPosition currentPosition;

  RxSet<Marker> markers = <Marker>{}.obs;

  late LatLng selecteLocation;

  RxString streetName = ''.obs;

  @override
  void onInit() {
    currentPosition = CameraPosition(
      target: LatLng(currentLocation.latitude ?? 37.42796133580664,
          currentLocation.longitude ?? -122.085749655962),
      zoom: 14.4746,
    );
    selecteLocation = LatLng(currentLocation.latitude ?? 37.42796133580664,
        currentLocation.longitude ?? -122.08574965596);
    super.onInit();
  }

  void addMarker({
    required LatLng position,
    required String id,
    String? imageName,
    String? imageUrl,
  }) async {
    BitmapDescriptor markerIcon = imageName != null
        ? await MapUtil.getImageFromAsset(imageName: imageName)
        : imageUrl != null
            ? await MapUtil.getImageFromNetwork(imageUrl: imageUrl)
            : BitmapDescriptor.defaultMarker;

    markers.add(
        Marker(markerId: MarkerId(id), position: position, icon: markerIcon));
    getStreetName();
    update();
  }

  void getStreetName() async {
    runLoadingFutureFunction(
        function: locationService
            .getLocationInfo(
                showLoader: false,
                LocationData.fromMap({
                  'latitude': selecteLocation.latitude,
                  'longitude': selecteLocation.longitude
                }))
            .then((value) {
      streetName.value = value?.street ?? 'No Info Found';
      update();
    }));
  }
}
