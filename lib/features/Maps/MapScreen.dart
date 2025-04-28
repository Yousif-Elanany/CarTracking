import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;
  String? _address;
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  // دالة تجيب الموقع الحالي
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // نتأكد ان الجي بي اس شغال
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    // نطلب صلاحيات الوصول للموقع
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        return;
      }
    }

    // نجيب الموقع الحالي
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    LatLng currentLatLng = LatLng(position.latitude, position.longitude);

    _updateLocation(currentLatLng);

    // نحرك الكاميرا للموقع الحالي
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: currentLatLng, zoom: 16),
      ),
    );
  }

  // دالة تحدث المكان و العنوان
  Future<void> _updateLocation(LatLng position) async {
    setState(() {
      _pickedLocation = position;
    });

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        setState(() {
          _address = "${place.street}, ${place.locality}, ${place.country}";
        });
      }
    } catch (e) {
      print('Error fetching address: $e');
    }
  }

  void _confirmLocation() {
    if (_pickedLocation != null && _address != null) {
      Navigator.pop(context, {
        'lat': _pickedLocation!.latitude,
        'lng': _pickedLocation!.longitude,
        'address': _address,
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a location')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick Location'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _confirmLocation,
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(30.0444, 31.2357), // القاهرة كـ default مبدئياً
          zoom: 10,
        ),
        onTap: (position) {
          _updateLocation(position);
          _mapController?.animateCamera(
            CameraUpdate.newLatLng(position),
          );
        },
        markers: _pickedLocation == null
            ? {}
            : {
          Marker(
            markerId: MarkerId('pickedLocation'),
            position: _pickedLocation!,
          ),
        },
        onMapCreated: (controller) {
          _mapController = controller;
        },
        myLocationEnabled: true, // اظهار الموقع الحالي
        myLocationButtonEnabled: true, // زرار تحديد موقعي
      ),
      bottomNavigationBar: _address != null
          ? Container(
        padding: EdgeInsets.all(16),
        color: Colors.white,
        child: Text(
          'Selected Address: $_address',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      )
          : null,
    );
  }
}
