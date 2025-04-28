import 'package:car_tracking/core/network_Local/cache_helper.dart';
import 'package:car_tracking/features/dashboard/business_logic/dashBoard_cubit.dart';
import 'package:car_tracking/features/dashboard/business_logic/dashBoard_states.dart';
import 'package:car_tracking/features/dashboard/data/Models/StatiscsModel.dart';
import 'package:car_tracking/features/dashboard/data/Models/carTrackerModel.dart';
import 'package:car_tracking/presentation/widgets/SmallBox.dart';
import 'package:car_tracking/features/dashboard/widgets/chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late StatiscsModel statics;
  List<dynamic> cars = [];
  bool carLoaded = false;
  @override
  void initState() {
    super.initState();

    //  print(CacheHelper.getData(key: "role"));
    statics = BlocProvider.of<dashBoardCubit>(context).getStatiscs();
    cars = BlocProvider.of<dashBoardCubit>(context).getcarTrackers();
  }

  Widget Griddata(StatiscsModel model) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.8,
      physics: NeverScrollableScrollPhysics(),
      children: [
        buildBox(
            'All Vehicles', '${model.carsCount ?? 0}', null, Colors.purple),
        buildBox(
            'In Branch', '${model.branchesCount ?? 0}', '80%', Colors.blue),
        buildBox('Cities', '${model.citiesCount ?? 0}', '15%', Colors.orange),
        buildBox('Users', '${model.usersCount ?? 0}', '5%', Colors.red),
        buildBox('Regions', '${model.regionsCount ?? 0}', '5%', Colors.red),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<dashBoardCubit, dashBoardState>(
      listener: (context, state) {
        if (state is dashBoardSuccess) {
          statics = state.model;
        } else if (state is dashBoardFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
        if (state is carTrackerSuccess) {
          cars = state.model;
          setState(() {
            carLoaded = true;
          });
          print(cars);
        } else if (state is carTrackerFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                !carLoaded
                    ? ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Loading Cars")),
                      )
                    : context.push('/map', extra: cars);
              },
              icon: Image.asset(
                'assets/images/map.png',
                width: 24,
                height: 24,
              ),
              label: Text(
                'see on the map',
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
                          image: AssetImage(
                              'assets/images/base.png'), // مسار الصورة
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          // ListTile في الأعلى
                          Positioned(
                              top: 20,
                              left: 16,
                              right: 16,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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

                          // النص الرئيسي
                        ],
                      ),
                    ),
                  ),

                  // الجزء السفلي مع البيانات
                  Positioned(
                    top: 130,
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
                      child: Scrollbar(
                        // إضافة شريط التمرير الجانبي هنا
                        //  trackVisibility: true,
                        thumbVisibility: true,
                        thickness: 8, // تحديد ارتفاع الشريط ليكون 20
                        radius: Radius.circular(10),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Color(0xffF5F5F5),
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'last update from 10 min',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              // هنا تقدر تحط فنكشن التحديث
                                            },
                                            child: Text(
                                              'update',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      Griddata(statics)
                                    ],
                                  ),
                                ),
                                SizedBox(height: 24),
                                LiveActivityChart(),
                                // SizedBox(height: 24),
                                // Container(
                                //   padding: EdgeInsets.all(16),
                                //   decoration: BoxDecoration(
                                //     color: Color(0xffF5F5F5),
                                //     borderRadius: BorderRadius.circular(16),
                                //     boxShadow: [
                                //       BoxShadow(
                                //         color: Colors.grey.withOpacity(0.1),
                                //         spreadRadius: 2,
                                //         blurRadius: 5,
                                //       ),
                                //     ],
                                //   ),
                                //   child: Column(
                                //     crossAxisAlignment: CrossAxisAlignment.start,
                                //     children: [
                                //       Row(
                                //         mainAxisAlignment:
                                //             MainAxisAlignment.spaceBetween,
                                //         children: [
                                //           Text(
                                //             'last update from 10 min',
                                //             style: TextStyle(
                                //               color: Colors.grey,
                                //               fontSize: 14,
                                //             ),
                                //           ),
                                //           GestureDetector(
                                //             onTap: () {
                                //               // هنا تقدر تحط فنكشن التحديث
                                //             },
                                //             child: Text(
                                //               'update',
                                //               style: TextStyle(
                                //                 color: Colors.black,
                                //                 fontWeight: FontWeight.bold,
                                //                 fontSize: 14,
                                //               ),
                                //             ),
                                //           ),
                                //         ],
                                //       ),
                                //       SizedBox(height: 8),
                                //       Griddata(statics)
                                //     ],
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Widget _buildDataRow(String title, String value) {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(vertical: 8.0),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Text(title, style: TextStyle(fontSize: 16)),
  //         Text(value,
  //             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget _buildChartColumn(int hour) {
  //   return Container(
  //     width: 40,
  //     margin: EdgeInsets.symmetric(horizontal: 4),
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.end,
  //       children: [
  //         Container(
  //           height: (hour % 5 + 1) * 20.0, // ارتفاع عشوائي للرسم التوضيحي
  //           color: Colors.blue,
  //         ),
  //         SizedBox(height: 4),
  //         Text('${hour + 1}', style: TextStyle(fontSize: 12)),
  //       ],
  //     ),
  //   );
  // }
}
