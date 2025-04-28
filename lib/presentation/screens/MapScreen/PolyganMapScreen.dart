import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPolygonScreen extends StatefulWidget {
  @override
  _MapPolygonScreenState createState() => _MapPolygonScreenState();
}

class _MapPolygonScreenState extends State<MapPolygonScreen> {
  List<LatLng> selectedPoints = [];
  late GoogleMapController _controller;

  void _onTap(LatLng latLng) {
    if (selectedPoints.length >= 4) return; // الحد الأقصى 4 نقاط
    setState(() {
      selectedPoints.add(latLng);
    });
  }

  void _confirmSelection() {
    if (selectedPoints.length < 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('يرجى اختيار 3 نقاط على الأقل')),
      );
      return;
    }

    List<Map<String, double>> coordinates = selectedPoints
        .map((point) => {"lat": point.latitude, "lng": point.longitude})
        .toList();

    Navigator.pop(context, coordinates);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('حدد النقاط'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _confirmSelection,
          )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(30.0444, 31.2357), // مكان مبدأي
          zoom: 14,
        ),
        onMapCreated: (controller) => _controller = controller,
        onTap: _onTap,
        markers: {
          for (int i = 0; i < selectedPoints.length; i++)
            Marker(
              markerId: MarkerId('marker_$i'),
              position: selectedPoints[i],
              infoWindow: InfoWindow(title: 'نقطة ${i + 1}'),
            ),
        },
        polygons: {
          if (selectedPoints.length >= 3)
            Polygon(
              polygonId: PolygonId("selected_area"),
              points: selectedPoints,
              strokeColor: Colors.blue,
              fillColor: Colors.blue.withOpacity(0.2),
              strokeWidth: 2,
            )
        },
      ),
    );
  }
}
