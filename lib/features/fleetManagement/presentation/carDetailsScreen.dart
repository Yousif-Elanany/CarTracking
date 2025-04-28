import 'package:car_tracking/features/dashboard/data/Models/carTrackerModel.dart';
import 'package:car_tracking/features/fleetManagement/business_logic/fleetManagment_cubit.dart';
import 'package:car_tracking/features/fleetManagement/business_logic/fleetManagment_states.dart';
import 'package:car_tracking/features/fleetManagement/presentation/relatedCarDetail/MapContentTab.dart';
import 'package:car_tracking/features/fleetManagement/presentation/relatedCarDetail/MapHistoryTab.dart';
import 'package:car_tracking/features/fleetManagement/presentation/relatedCarDetail/detialContentTab.dart';
import 'package:car_tracking/features/fleetManagement/presentation/relatedCarDetail/historyContentTab.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class cardetailsScreen extends StatefulWidget {
  String? carId;
  cardetailsScreen({this.carId});
  @override
  State<cardetailsScreen> createState() => _cardetailsScreenState();
}

class _cardetailsScreenState extends State<cardetailsScreen> {
  final searchText = TextEditingController();
  final LatLng carPosition = LatLng(30.0444, 31.2357);
  final LatLng carPosition2 = LatLng(30.0450, 31.2355); // موقع قريب

  Offset? markerOffset;
  bool mapLoaded = false;
   CarTrackerModel? car;

  late BitmapDescriptor customIcon;
  final CustomInfoWindowController _CustomInfwindow =
      CustomInfoWindowController();
  Map<String, Marker> _markers = {};
  final carData = {
    'speed': 80,
    'type': 'Toyota',
    'image': 'assets/images/car.png',
    'time': '2025-04-08 14:35',
  };
  int selectedIndex = 0;
  final List<String> titles = ['Map', 'Details', 'History', 'Map history'];

  @override
  void initState() {
    super.initState();
    //  _loadCustomMarker();
    // car = BlocProvider.of<fleetManagmentCubit>(context)
    //     .getcarTrackerById(widget.carId!);

    print(widget.carId);
    Future.delayed(Duration(seconds: 1), _getMarkerPosition);
  }

  // // حساب مكان الماركر
  Future<void> _getMarkerPosition() async {
    BlocProvider.of<fleetManagmentCubit>(context)
        .getcarTrackerById(widget.carId!);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<fleetManagmentCubit, fleetManagmentState>(
          listener: (context, state) {
            if( state is carTrackerByIdSuccess)
            car =state.model;
          },
          builder: (context, state) {
            return Stack(
              children: [
                // الخلفية العليا
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
                    child: Stack(
                      children: [
                        Positioned(
                          top: 20,
                          left: 0,
                          right: 60,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Image.asset(
                                      "assets/images/arrow.png",
                                      width: 50,
                                      height: 50,
                                    ),
                                  ),
                                ),
                                const Text(
                                  'Car details',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Container()
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // الخريطة
                Positioned(
                  top: 130,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xffF5F5F5),
                            spreadRadius: 2,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 20),
                            child: SizedBox(
                              height: 40,
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      SizedBox(
                                          width: 8), // مسافة بين الصورة والاسم

                                      Text(
                                        car?.carPlate ??"",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 2),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.asset(
                                            'assets/images/carStop.png', // استبدل بالصورة الأولى
                                            fit: BoxFit.fill,
                                            // height:40 ,
                                            // width: 80,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Container حوالين الـ Row كله
                          Container(
                            margin: EdgeInsets.all(16),
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: Colors.grey), // الحواف الرصاصي
                            ),
                            child: Row(
                              children: List.generate(titles.length, (index) {
                                final isSelected = index == selectedIndex;
                                return Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedIndex = index;
                                      });
                                    },
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 12),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? Color(0xff167AD8)
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        titles[index],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.grey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                          // محتوى الصفحات
                          Expanded(
                            child: IndexedStack(
                              index: selectedIndex,
                              children: [
                                LiveLocationMap(
                           carId: widget.carId ,
                                ),
                                DetailsPage(carId: widget.carId,),
                                HistoryPage(carId: widget.carId),
                                HistoryMap(),
                              ],
                            ),
                          ),
                        ],
                      )),
                ),

                // مربع البحث
                // Positioned(
                //   top: 160,
                //   left: 16,
                //   right: 16,
                //   child: Directionality(
                //     textDirection: TextDirection.rtl,
                //     child: Padding(
                //       padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
                //       child: TextFormField(
                //         controller: searchText,
                //         onChanged: (searchProduct) {},
                //         decoration: InputDecoration(
                //           contentPadding: EdgeInsets.zero,
                //           filled: true,
                //           fillColor: Colors.white,
                //           hintText: "بحث",
                //           hintStyle: TextStyle(color: Colors.grey),
                //           border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(24),
                //             borderSide: BorderSide(
                //               color: Color(0xff6C6C89).withOpacity(0.1),
                //             ),
                //           ),
                //           enabledBorder: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(12),
                //             borderSide: BorderSide(
                //               color: Color(0xff6C6C89).withOpacity(0.1),
                //             ),
                //           ),
                //           focusedBorder: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(12),
                //             borderSide: BorderSide(
                //               color: Color(0xff6C6C89).withOpacity(0.1),
                //             ),
                //           ),
                //           prefixIcon: GestureDetector(
                //             onTap: () async {},
                //             child: Padding(
                //               padding: const EdgeInsets.all(6.0),
                //               child: Image.asset(
                //                 'assets/images/filtter.png',
                //                 width: 15,
                //                 height: 15,
                //               ),
                //             ),
                //           ),
                //           suffixIcon: Padding(
                //             padding: const EdgeInsets.all(6.0),
                //             child: Image.asset(
                //               'assets/images/search.png',
                //               width: 15,
                //               height: 15,
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            );
          },
        ),
      ),
    );
  }
}

Widget _buildTableHeader(String text) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.grey[600],
      ),
    ),
  );
}

// Helper method for table cells
Widget _buildTableCell(String text, {bool isSpeed = false}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: 16,
      color: isSpeed ? Colors.blue : Colors.black87,
      fontWeight: isSpeed ? FontWeight.bold : FontWeight.normal,
    ),
  );
}
