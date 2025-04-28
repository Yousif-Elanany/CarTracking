import 'package:car_tracking/features/dashboard/data/Models/carTrackerModel.dart';
import 'package:car_tracking/features/fleetManagement/business_logic/fleetManagment_cubit.dart';
import 'package:car_tracking/features/fleetManagement/business_logic/fleetManagment_states.dart';
import 'package:car_tracking/features/fleetManagement/presentation/widgets/CustomCarDetails.dart';
import 'package:car_tracking/presentation/widgets/SmallBox.dart';
import 'package:car_tracking/features/dashboard/widgets/chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class fleetManagementScreen extends StatefulWidget {
  const fleetManagementScreen({super.key});

  @override
  State<fleetManagementScreen> createState() => _fleetManagementScreenState();
}

class _fleetManagementScreenState extends State<fleetManagementScreen> {
  final searchText = TextEditingController();

  List<CarTrackerModel> cars = [];
  bool carLoaded = false;
  List<CarTrackerModel> filteredCars = [];
  String searchQuery = '';
  void filterCars(String query) {
    setState(() {
      searchQuery = query;
      filteredCars = cars.where((car) {
        return car.carName!.toLowerCase().contains(query.toLowerCase()) ||
            car.carPlate!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    carLoaded = false;

    //  print(CacheHelper.getData(key: "role"));
    cars = BlocProvider.of<fleetManagmentCubit>(context).getcarTrackers();
  }
  // final List<Map<String, dynamic>> carsList = [
  //
  //
  //
  //
  //   {
  //     'name': 'Avanza',
  //     'type': 'Riyadh',
  //     'plate': 'ت ف ع - 1362',
  //     'branch': 'Main Branch',
  //     'speed': '46.5',
  //   },
  //   {
  //     'name': 'Camry',
  //     'type': 'Jeddah',
  //     'plate': 'ن م ب - 4821',
  //     'branch': 'West Branch',
  //     'speed': '52.0',
  //   },
  //   {
  //     'name': 'Hilux',
  //     'type': 'Dammam',
  //     'plate': 'س ج ر - 9432',
  //     'branch': 'East Branch',
  //     'speed': '40.2',
  //   },
  // ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<fleetManagmentCubit, fleetManagmentState>(
      listener: (context, state) {
        if (state is carTrackerSuccess) {
          cars = state.model;
          print("cars.length=${cars}");
          setState(() {
            carLoaded = true;
          });
        }
      },
      builder: (context, state) => SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              // context.push('/cardetailsScreen');
            },
            icon: Image.asset(
              'assets/images/map.png',
              width: 24,
              height: 24,
            ),
            label: Text(
              'See on the map',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Color(0xff09345D),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Stack(
              children: [
                // الجزء العلوي (خلفية أو عناصر أخرى)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:
                            AssetImage('assets/images/base.png'), // مسار الصورة
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                            top: 20,
                            left: 16,
                            right: 16,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundImage: AssetImage(
                                            'assets/images/person.png'), // غيّر المسار حسب صورتك
                                      ),
                                      SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Hello,',
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text(
                                            'Abobakr Sobhy',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white.withOpacity(0.05),
                                    border: Border.all(color: Colors.white10),
                                  ),
                                  padding: EdgeInsets.all(10),
                                  child: Icon(
                                    Icons.notifications,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                ),

                // الجزء السفلي مع البيانات
                Positioned(
                  top: 140,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.all(16),
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
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: TextFormField(
                                    controller: searchText,

                                    onChanged: filterCars,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: "بحث",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(24),
                                        borderSide: BorderSide(
                                          color: Color(0xff6C6C89)
                                              .withOpacity(0.3),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: Color(0xff6C6C89)
                                              .withOpacity(0.3),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: Color(0xff6C6C89)
                                              .withOpacity(0.3),
                                        ),
                                      ),
                                      suffixIcon: GestureDetector(
                                        onTap: () async {},
                                        child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Image.asset(
                                            'assets/images/filtter.png',
                                            width: 15,
                                            height: 15,
                                          ),
                                        ),
                                      ),
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Image.asset(
                                          'assets/images/search.png',
                                          width: 15,
                                          height: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                // Padding(
                                //   padding:
                                //       const EdgeInsets.symmetric(horizontal: 4.0),
                                //   child: Container(
                                //     height: 56,
                                //     width: 56,
                                //     decoration: BoxDecoration(
                                //       color: Colors.grey.withOpacity(0.1),
                                //       borderRadius: BorderRadius.circular(12),
                                //     ),
                                //     child: Image.asset("assets/images/dots.png"),
                                //   ),
                                // ),
                              ],
                            ),
                            SizedBox(height: 24),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.52,
                              child: Skeletonizer(
                                enabled: !carLoaded,
                                child: ListView.separated(
                                  padding: EdgeInsets.all(4),
                                  itemCount: searchText.text.isEmpty
                                      ? BlocProvider.of<fleetManagmentCubit>(
                                              context)
                                          .carTrackerList
                                          .length
                                      : filteredCars.length,
                                  separatorBuilder: (context, index) =>
                                      SizedBox(height: 24),
                                  itemBuilder: (context, index) {
                                    final listcar = searchText.text.isEmpty
                                        ? BlocProvider.of<fleetManagmentCubit>(
                                                context)
                                            .carTrackerList[index]
                                        : filteredCars[index];
                                    return CarCardWidget(carData: listcar);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDataRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 16)),
          Text(value,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildChartColumn(int hour) {
    return Container(
      width: 40,
      margin: EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: (hour % 5 + 1) * 20.0, // ارتفاع عشوائي للرسم التوضيحي
            color: Colors.blue,
          ),
          SizedBox(height: 4),
          Text('${hour + 1}', style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
