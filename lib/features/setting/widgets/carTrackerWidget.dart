import 'package:car_tracking/features/dashboard/business_logic/dashBoard_cubit.dart';
import 'package:car_tracking/features/dashboard/business_logic/dashBoard_states.dart';
import 'package:car_tracking/features/dashboard/data/Models/carTrackerModel.dart';
import 'package:car_tracking/features/setting/business_logic/setting_cubit.dart';
import 'package:car_tracking/features/setting/business_logic/setting_states.dart';
import 'package:car_tracking/presentation/widgets/CustomBottomSheet.dart';
import 'package:car_tracking/presentation/widgets/customSelectButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CarTrackerCardWidget extends StatelessWidget {
  CarTrackerModel? model;
  CarTrackerCardWidget({this.model});

  @override
  Widget build(BuildContext context) {
    final dashboradCubit = BlocProvider.of<dashBoardCubit>(context);

    return BlocConsumer<dashBoardCubit, dashBoardState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          width: 335,
          height: 230,
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
                            model?.carName ?? '',
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
                    model?.carBranchName ?? '',
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
                          model?.carPlate ?? '',
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
                          model?.carBranchName ?? '',
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
                          '${(model!.tracker.isNotEmpty) ? (model!.tracker[0].carSpeed ?? 0) : 0} Km/h',
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
                Row(
                  children: [
                    Expanded(
                      child: customSelectButton(
                        btnText: "Delete",
                        borderColor: Colors.red,
                        behindIcon: Icons.delete_outline,
                        btnheight: 40,
                        iconColor: Colors.red,
                        btnTextColor: Colors.red,
                        ontap: () {
                          // CustomBottomSheet(context, onTap: () async {
                          //   await settingsCubit.deleteCar(model!.id);
                          //   Navigator.pop(context);
                          // });
                        },
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: customSelectButton(
                        btnText: "edit",
                        borderColor: Colors.blue,
                        btnheight: 40,
                        behindIcon: Icons.edit,
                        iconColor: Colors.blue,
                        btnTextColor: Colors.blue,
                        ontap: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
