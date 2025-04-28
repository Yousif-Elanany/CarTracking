import 'package:car_tracking/features/fleetManagement/data/Models/carTripModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



final DateFormat displayFormat = DateFormat("MM/dd/yyyy h:mm:ss a");

Widget tripwidget({ carTripModel? carTrip}) => Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
//      Icon(Icons.access_time, color: Colors.grey),
          Image.asset(
            "assets/images/clock.png",
            width: 48,
            height: 48,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayFormat.format(carTrip!.tripStart) ??"",
             //     carTrip?.tripStart.toString() ??"",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                ),
                SizedBox(height: 4),
                Text(
                  displayFormat.format(carTrip!.tripEnd)??"",
                  style: TextStyle(
                      color: Colors.grey[400],
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
              ],
            ),
          ),
          SizedBox(width: 8),
          Image.asset(
            "assets/images/marker.png",
            width: 20,
            height: 20,
          ),
        ],
      ),
    );
