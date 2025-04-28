import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:car_tracking/features/fleetManagement/business_logic/fleetManagment_cubit.dart';
import 'package:car_tracking/features/fleetManagement/business_logic/fleetManagment_states.dart';

class LiveLocationMap extends StatefulWidget {
  final String? carId;

  LiveLocationMap({required this.carId});

  @override
  State<LiveLocationMap> createState() => _LiveLocationMapState();
}

class _LiveLocationMapState extends State<LiveLocationMap> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // أول مرة
    BlocProvider.of<fleetManagmentCubit>(context)
        .getcarTrackerById(widget.carId!);

    // كل 5 ثواني
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      BlocProvider.of<fleetManagmentCubit>(context)
          .getcarTrackerById(widget.carId!);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _updateMarker(double lat, double long)async {
    final position = LatLng(lat, long);
    _markers.clear();
    _markers.add(
      Marker(
        icon: await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(100, 100)),
    'assets/images/car2.png',
    ),
        markerId: MarkerId('car'),
        position: position,
        infoWindow: InfoWindow(title: "موقع السيارة"),
      ),
    );
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: 16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<fleetManagmentCubit, fleetManagmentState>(
      builder: (context, state) {
        double lat = 30.0;
        double long = 31.0;

        if (state is carTrackerByIdSuccess &&
            state.model.tracker.isNotEmpty) {
          lat = state.model.tracker[0].lat;
          long = state.model.tracker[0].long;
          _updateMarker(lat, long);
        }

        return GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(lat, long),
            zoom: 16,
          ),
          markers: _markers,
          onMapCreated: (controller) {
            _mapController = controller;
          },
        );
      },
    );
  }
}
