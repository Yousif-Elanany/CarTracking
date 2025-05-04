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
  bool mapLoaded = false;
  final CustomInfoWindowController _customInfoWindowController = CustomInfoWindowController();
  final Map<String, Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _loadCustomMarker();
  }

  late final List<CarTrackerModel> _allCars;

  String? _activeMarkerId;
  bool _isInfoWindowVisible = false;
  Future<void> _loadCustomMarker() async {
    customIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(100, 100)),
      'assets/images/car2.png',
    );
    setState(() => mapLoaded = true);
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


  Future<void> addMarker(CarTrackerModel car) async {
    final Tracker latest = car.tracker.last;
    final String placeName = latest.nameOfLocation;

    final LatLng pos = LatLng(latest.lat, latest.long);

    Widget infoWindow =
    Container(
      width: 335,
      height: 225,// عرض الكونتينر الرئيسي
      //  padding: EdgeInsets.all(12),
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
            // الجزء الأول: صورة جنبها اسم
            SizedBox(
              height: 40,
              width: 311,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/images/car.png', // استبدل بالصورة المرغوبة
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 8), // مسافة بين الصورة والاسم

                      Text(
                        car.carName,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/images/midwifi.png', // استبدل بالصورة الأولى
                            fit: BoxFit.cover,
                            height:20 ,
                            width: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/images/eng.png',
                            height:20 ,
                            width: 20,
                            // استبدل بالصورة الأولى
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 50,// ارتفاع الكونتينر الصغير
                        decoration: BoxDecoration(
                          color: Color(0xff24AD53).withOpacity(0.3),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Text(
                            'Rented',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xff24AD53),
                            ),
                          ),
                        ),
                      ),


                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16), // مسافة بين الأجزاء


            SizedBox(
              height: 24,
              width: double.infinity,
              child: Text(
                'location :${placeName}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),

            SizedBox(height: 16), // مسافة إضافية

            // الجزء الرابع: معلومات السرعة، رقم اللوحة، والفروع
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // رقم اللوحة
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Plate',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w400
                      ),
                    ),
                    //    SizedBox(height: 4),
                    Text(
                      car.carPlate,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600

                      ),
                    ),
                  ],
                ),
                // الفرع
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Branch',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    //      SizedBox(height: 4),
                    Text(
                      car.carBranchName,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                // السرعة
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Speed',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    //     SizedBox(height: 4),
                    Text(
                      car.tracker[0].carSpeed.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 16), // مسافة إضافية

            // الزر "View"
            Container(
              height: 32,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8), // نصف الطول لجعلها دائرية
                border: Border.all(color: Colors.blue), // تحديد اللون الأزرق للحواف
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.remove_red_eye, size: 18),
                  SizedBox(width: 8),
                  Text(
                    'View',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            )

          ],
        ),
      ),
    );




    Marker marker = Marker(
      markerId: MarkerId(car.id),
      position: pos,
      icon: customIcon,
      onTap: () {
        _customInfoWindowController.hideInfoWindow!();
        _customInfoWindowController.addInfoWindow!(infoWindow, pos);
      },
    );

    _markers[car.id] = marker;
    setState(() {});
  }

  @override
  void dispose() {
    _customInfoWindowController.dispose();
    searchText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LatLng initialPosition =
    (widget.cars != null && widget.cars!.isNotEmpty)
        ? LatLng(
      widget.cars!.first.tracker.last.lat,
      widget.cars!.first.tracker.last.long,
    )
        : const LatLng(30.0444, 31.2357);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Top background
          Positioned(
            top: 0,
            left: 0,
            right: 0,
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
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset(
                          'assets/images/arrow.png',
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ),
                    const Text(
                      'Map',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Container(
                      width: 100,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Map container
          Positioned(
            top: 160,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xffF5F5F5),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.blueAccent, width: 2),
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  children: [
                    GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: initialPosition,
                        zoom: 16,
                      ),
                      onMapCreated: (GoogleMapController controller) async {
                        _mapController = controller;
                        _customInfoWindowController.googleMapController = controller;
                        if (widget.cars != null) {
                          for (var car in widget.cars!) {
                            await addMarker(car);
                          }
                        }
                        setState(() => mapLoaded = true);
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
          ),
          // Search box
          Positioned(
            top: 160,
            left: 16,
            right: 16,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: TextField(
                  controller: searchText,
                  onSubmitted: (value) => _filterAndUpdateMarkers(value),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'بحث',
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(color: Color(0xff6C6C89).withOpacity(0.1)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Color(0xff6C6C89).withOpacity(0.1)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Color(0xff6C6C89).withOpacity(0.1)),
                    ),
                    prefixIcon: GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Image.asset('assets/images/filtter.png', width: 15, height: 15),
                      ),
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Image.asset('assets/images/search.png', width: 15, height: 15),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}