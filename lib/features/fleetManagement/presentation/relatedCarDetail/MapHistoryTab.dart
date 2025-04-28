import 'package:car_tracking/features/fleetManagement/business_logic/fleetManagment_cubit.dart';
import 'package:car_tracking/features/fleetManagement/business_logic/fleetManagment_states.dart';
import 'package:car_tracking/presentation/widgets/BottomSheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';


class HistoryMap extends StatefulWidget {
  @override
  _HistoryMapState createState() => _HistoryMapState();
}

class _HistoryMapState extends State<HistoryMap> {
  late Position _currentPosition;
  late CameraPosition _cameraPosition;
  Set<Marker> _markers = Set();
  GoogleMapController? _mapController;

  final LatLng carPosition = LatLng(30.0444, 31.2357);

  @override
  void initState() {
    super.initState();
    // _getCurrentLocation();
  }

  // الحصول على الموقع الحالي باستخدام Geolocator
  void _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // التحقق من تفعيل الخدمة
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // عرض رسالة في حالة عدم تفعيل الخدمة
      return;
    }

    // التحقق من إذن الوصول إلى الموقع
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return;
      }
    }

    // الحصول على الموقع الحالي
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _currentPosition = position;
      _cameraPosition = CameraPosition(
        target: LatLng(_currentPosition.latitude, _currentPosition.longitude),
        zoom: 16.0,
      );
      _markers.clear(); // إزالة الماركر القديم
      _markers.add(Marker(
        markerId: MarkerId('car'),
        position: carPosition,
        infoWindow: InfoWindow(title: 'موقع السيارة'),
      ));
    });

    // تحديث الموقع كل 5 ثواني
    Geolocator.getPositionStream(desiredAccuracy: LocationAccuracy.high)
        .listen((Position position) {
      setState(() {
        _currentPosition = position;
        _cameraPosition = CameraPosition(
          target: LatLng(_currentPosition.latitude, _currentPosition.longitude),
          zoom: 16.0,
        );
        _markers.clear(); // إزالة الماركر القديم
        _markers.add(Marker(
          markerId: MarkerId('car'),
          position: LatLng(_currentPosition.latitude, _currentPosition.longitude),
          infoWindow: InfoWindow(title: 'موقع السيارة'),
        ));
      });
      _mapController?.animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(title: Text('الخريطة الحية')),
      body: BlocConsumer<fleetManagmentCubit,fleetManagmentState>(
        listener:(context,state){

        } ,
        builder: (context,state){
          return  Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16 ),
              //   child: Align(
              //     alignment: Alignment.centerLeft,
              //     child: Container(
              //       width: 135,
              //       height: 45,
              //       padding: EdgeInsets.symmetric(horizontal: 12),
              //       decoration: BoxDecoration(
              //         color: Colors.white,
              //         borderRadius: BorderRadius.circular(12),
              //         border: Border.all(color: Colors.grey.shade300),
              //       ),
              //       child: InkWell(
              //
              //         onTap: () {
              //
              //        //   showFilterSheet(context);
              //         },
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           children: [
              //             Image.asset(
              //               'assets/images/filtter2.png', // غيره حسب مكان الصورة عندك
              //               width: 20,
              //               height: 20,
              //             ),
              //             SizedBox(width: 8),
              //             Text(
              //               "Filtre by",
              //               style: TextStyle(
              //                 color: Colors.black,
              //                 fontWeight: FontWeight.w500,
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // هنا استخدمنا Expanded أو Flexible لتجنب overflow
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: GoogleMap(
                    mapType: MapType.normal, // نوع الخريطة هنا
                    initialCameraPosition: CameraPosition(
                      target: carPosition, // إحداثيات القاهرة
                      zoom: 16.0,
                    ),
                    markers: _markers, // إضافة الماركر هنا
                    onMapCreated: (GoogleMapController controller) {
                      _mapController = controller;
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),

    );
  }
}
