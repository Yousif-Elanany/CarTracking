import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:car_tracking/features/dashboard/data/Models/carTrackerModel.dart';

class MapPage extends StatefulWidget {
  final List<CarTrackerModel>? cars;
  const MapPage({Key? key, this.cars}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final TextEditingController searchText = TextEditingController();
  late BitmapDescriptor customIcon;
  late GoogleMapController _mapController;
  final CustomInfoWindowController _customInfoWindowController = CustomInfoWindowController();
  final Map<String, Marker> _markers = {};

  late final List<CarTrackerModel> _allCars;

  String? _activeMarkerId;
  bool _isInfoWindowVisible = false;

  @override
  void initState() {
    super.initState();
    _allCars = widget.cars ?? [];
    _loadCustomMarker();
  }

  Future<void> _loadCustomMarker() async {
    customIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(100, 100)),
      'assets/images/car2.png',
    );
    setState(() {});
  }

  Future<void> _filterAndUpdateMarkers(String query) async {
    final lowerQuery = query.toLowerCase().trim();
    final filtered = _allCars.where((car) {
      return car.carPlate.toLowerCase().contains(lowerQuery);
    }).toList();

    _markers.clear();
    _activeMarkerId = null;
    _isInfoWindowVisible = false;
    _customInfoWindowController.hideInfoWindow!();

    for (var car in filtered) {
      await addMarker(car);
    }

    if (filtered.isNotEmpty) {
      final firstCar = filtered.first.tracker.last;
      final pos = LatLng(firstCar.lat, firstCar.long);
      _mapController.animateCamera(CameraUpdate.newLatLngZoom(pos, 16));

      _customInfoWindowController.addInfoWindow!(
        _buildInfoWindow(filtered.first),
        pos,
      );
      _isInfoWindowVisible = true;
      _activeMarkerId = filtered.first.id;
    }

    setState(() {});
  }

  Widget _buildInfoWindow(CarTrackerModel car) {
    final Tracker latest = car.tracker.last;
    final String placeName = latest.nameOfLocation;

    return Container(
      width: 335,
      height: 225,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(car.carName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Location: $placeName', style: TextStyle(fontSize: 14, color: Colors.grey[700])),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Plate', style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w400)),
                    Text(car.carPlate, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Branch', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    Text(car.carBranchName, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Speed', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    Text('${latest.carSpeed} km/h', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              height: 32,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue),
              ),
              child: const Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.remove_red_eye, size: 18),
                    SizedBox(width: 8),
                    Text('View', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addMarker(CarTrackerModel car) async {
    final Tracker latest = car.tracker.last;
    final LatLng pos = LatLng(latest.lat, latest.long);
    final markerId = car.id;

    Marker marker = Marker(
      markerId: MarkerId(markerId),
      position: pos,
      icon: customIcon,
      onTap: () {
        if (_activeMarkerId == markerId && _isInfoWindowVisible) {
          _customInfoWindowController.hideInfoWindow!();
          _isInfoWindowVisible = false;
          _activeMarkerId = null;
        } else {
          _customInfoWindowController.hideInfoWindow!();
          _customInfoWindowController.addInfoWindow!(
            _buildInfoWindow(car),
            pos,
          );
          _mapController.animateCamera(CameraUpdate.newLatLngZoom(pos, 16));
          _isInfoWindowVisible = true;
          _activeMarkerId = markerId;
        }
      },
    );

    _markers[markerId] = marker;
  }

  @override
  void dispose() {
    _customInfoWindowController.dispose();
    searchText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LatLng initialPosition = _allCars.isNotEmpty
        ? LatLng(_allCars.first.tracker.last.lat, _allCars.first.tracker.last.long)
        : const LatLng(30.0444, 31.2357);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 0, left: 0, right: 0,
            child: Container(
              height: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/base.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Image.asset('assets/images/arrow.png', width: 50, height: 50),
                    ),
                    const Text('Map', style: TextStyle(color: Colors.white, fontSize: 16)),
                    const SizedBox(width: 50),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 140, left: 16, right: 16,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextField(
                controller: searchText,
                onChanged: (value) => _filterAndUpdateMarkers(value),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'ابحث برقم اللوحة',
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Image.asset('assets/images/search.png', width: 20, height: 20),
                  ),
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(color: Color(0xff6C6C89).withOpacity(0.1)),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 180, left: 0, right: 0, bottom: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(target: initialPosition, zoom: 16),
                    onMapCreated: (controller) async {
                      _mapController = controller;
                      _customInfoWindowController.googleMapController = controller;
                      await _filterAndUpdateMarkers('');
                    },
                    onTap: (_) => _customInfoWindowController.hideInfoWindow!(),
                    onCameraMove: (_) => _customInfoWindowController.onCameraMove!(),
                    markers: _markers.values.toSet(),
                  ),
                  CustomInfoWindow(
                    controller: _customInfoWindowController,
                    height: 225,
                    width: 335,
                    offset: 50,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
