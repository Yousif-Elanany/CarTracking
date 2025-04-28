import 'package:car_tracking/features/dashboard/data/Models/carTrackerModel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CarCardWidget extends StatelessWidget {
  final CarTrackerModel carData;

  const CarCardWidget({Key? key, required this.carData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            // الصورة والاسم
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
                          'assets/images/car.png',
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        carData.carName ?? "",
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
                            'assets/images/midwifi.png',
                            height: 20,
                            width: 20,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/images/eng.png',
                            height: 20,
                            width: 20,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 50,
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

            SizedBox(height: 16),

            // location
            SizedBox(
              height: 24,
              width: double.infinity,
              child: Text(
                'Location: ${carData.carStatusName == null ? "" : carData.carStatusName}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),

            SizedBox(height: 16),

            // plate, branch, speed
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Plate
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Plate',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      carData.carPlate?.isNotEmpty == true
                          ? carData.carPlate!
                          : 'N/A',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                // Branch
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
                    Text(
                      carData.carBranchName?.isNotEmpty == true
                          ? carData.carBranchName!
                          : 'Main branch',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                // Speed
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
                    Text(
                      '${(carData.tracker.isNotEmpty) ? (carData.tracker[0].carSpeed ?? 0) : 0} Km/h',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 16),

            // زر View
            GestureDetector(
              onTap: () {
                context.push('/cardetailsScreen', extra: carData.id);
              },
              child: Container(
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.remove_red_eye, size: 18, color: Colors.blue),
                    SizedBox(width: 8),
                    Text(
                      'View',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
