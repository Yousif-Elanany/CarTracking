import 'package:car_tracking/features/fleetManagement/business_logic/fleetManagment_cubit.dart';
import 'package:car_tracking/features/fleetManagement/business_logic/fleetManagment_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../dashboard/data/Models/carTrackerModel.dart';

class DetailsPage extends StatefulWidget {
  final String? carId;

  DetailsPage({required this.carId});
  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  CarTrackerModel? car;
  bool isloading =false;

  @override
  void initState() {
    super.initState();
    // BlocProvider.of<fleetManagmentCubit>(context)
    //     .getcarTrackerById(widget.carId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<fleetManagmentCubit,fleetManagmentState>(
        listener:(context,state){
          if(state is carTrackerByIdSuccess ){
            car =state.model;
            setState(() {
              isloading=false;
            });
          }
          // else if (state is carTrackerByIdLoading){
          //   setState(() {
          //     isloading=true;
          //   });
          // }
        } ,
        builder:(context,state){
          return  Padding(
            padding:  EdgeInsets.all(16.0),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Plate", style: TextStyle(color: Colors.grey)),
                SizedBox(height: 4),
                Text(car?.carPlate??"", style: TextStyle(fontSize: 16)),
                SizedBox(height: 16),
                Row(
                  children: [
                    statusBox("Rental estate", car?.carStatusName ??"", Colors.grey[300]!,
                        imagepath: ""),
                    SizedBox(width: 8),
                    statusBox("Engine status", car?.isStopCar==true?"off":"on", Colors.grey[300]!,
                        imagepath: "assets/images/eng2.png"),
                    SizedBox(width: 8),
                    statusBox("connecting", "Good", Colors.grey[300]!,
                        imagepath: "assets/images/fullwifi2.png"),
                  ],
                ),
                SizedBox(height: 16),
                // Text("location", style: TextStyle(color: Colors.grey,fontSize: 12)),
                // SizedBox(height: 4),
                // Text(
                //   "12 Shahab Bin Abdullah Street, In front of Ruabi Damascus Grilled Foods, Al-Salam, Buraidah",
                //   style: TextStyle(fontSize: 16),
                // ),
                // SizedBox(height: 16),
                Text("Branch", style: TextStyle(color: Colors.grey,fontSize: 12)),
                SizedBox(height: 4),
                Text(car?.carBranchName ??"", style: TextStyle(fontSize: 16)),
                SizedBox(height: 16),
                Text("Speed", style: TextStyle(color: Colors.grey,fontSize: 12)),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.speed, size: 18, color: Colors.grey),
                    SizedBox(width: 4),
                    Text(car?.tracker ==null ? "0" :car!.tracker[0].carSpeed.toString(), style: TextStyle(fontSize: 16)),
                  ],
                ),
                SizedBox(height: 16),
                // Text("Directions", style: TextStyle(color: Colors.grey,fontSize: 12)),
                // SizedBox(height: 4),
                // Row(
                //   children: [
                //     Icon(Icons.explore, size: 18, color: Colors.grey),
                //     SizedBox(width: 4),
                //     Text("50 °", style: TextStyle(fontSize: 16)),
                //   ],
                // ),
              ],
            ),
          );
        }
      ),
    );
  }

  // Helper widget
  Widget statusBox(String title, String value, Color bgColor,
      {String? imagepath}) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        decoration: BoxDecoration(
        //  color: bgColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 12, color: Colors.black54)),
            SizedBox(height: 4),
            Row(
              children: [
                imagepath == ""
                    ? SizedBox()
                    : Image.asset(
                        imagepath.toString(),
                        height: 24,
                        width: 24,
                      ),
                SizedBox(
                  width: 8,
                ),
                Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
