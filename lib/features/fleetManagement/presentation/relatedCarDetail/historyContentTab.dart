import 'package:car_tracking/features/fleetManagement/business_logic/fleetManagment_cubit.dart';
import 'package:car_tracking/features/fleetManagement/business_logic/fleetManagment_states.dart';
import 'package:car_tracking/features/fleetManagement/data/Models/carTripModel.dart';
import 'package:car_tracking/features/fleetManagement/presentation/widgets/tripWidget.dart';
import 'package:car_tracking/presentation/widgets/BottomSheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HistoryPage extends StatefulWidget {
  final String? carId;
  const HistoryPage({super.key, required this.carId});
  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  DateTime? startDate;
  DateTime? endDate;
  List<carTripModel>? carTripList = [];
  bool isloading=true;
  @override
  void initState() {
    super.initState();

    // الوقت الحالي
    DateTime now = DateTime.now();

    // لو مفيش فلترة، استخدم من بداية اليوم إلى اللحظة الحالية
    DateTime todayStart = DateTime(now.year, now.month, now.day);
    DateTime current = now;

    // استخدم التاريخ الحالي لو المستخدم لسه مختارش تواريخ
    final DateFormat dateFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
    String formattedStart =
        dateFormat.format((startDate ?? todayStart).toUtc());
    String formattedEnd = dateFormat.format((endDate ?? current).toUtc());

    // استدعاء الداتا من الـ API
    BlocProvider.of<fleetManagmentCubit>(context).getCarTrip(
      widget.carId!,
      formattedStart,
      formattedEnd,
    );
  }

  final List<Map<String, String>> historyData = List.generate(
    5,
    (index) => {
      'datetime': '05/02/2021 8:47:18 AM',
      'location':
          '62 Uruwat Al-Rijal Street, After Lafa Grilled Food, Al-Masani\', Al-Qurayyat',
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:BlocConsumer<fleetManagmentCubit, fleetManagmentState> (
        listener: (BuildContext context, fleetManagmentState state) {
          if (state is carTripSuccess) {
            carTripList = state.tripListModel;
            setState(() {
              isloading =false;
            });
          }else if(state is carTripLoading){
            Skeletonizer(
                enabled: isloading ,
                child: tripwidget());
          }
        },


        builder: (BuildContext context, fleetManagmentState state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // زر الفلترة
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 135,
                    height: 45,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: InkWell(
                      onTap: () {
                        showFilterSheet(context,carId: widget.carId);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/images/filtter2.png',
                            width: 20,
                            height: 20,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            "Filtre by",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // قائمة العناصر
                Expanded(
                  child: ListView.builder(
                    itemCount: carTripList?.length,
                    itemBuilder: (context, index) {
                      return tripwidget(carTrip: carTripList?[index]);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
