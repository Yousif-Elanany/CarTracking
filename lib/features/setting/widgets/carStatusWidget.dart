import 'package:car_tracking/features/setting/data/Models/carStatus.dart';
import 'package:car_tracking/presentation/widgets/CustomBottomSheet.dart';
import 'package:car_tracking/presentation/widgets/customSelectButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../business_logic/setting_cubit.dart';

class CarStatusCardWidget extends StatelessWidget {
  // final Map<String, dynamic> carData;
  CarStatusModel? Model;
  CarStatusCardWidget({this.Model});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            // blurRadius: 5,
            //offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
                children: [
                  TextSpan(text: 'Status name: '),
                  TextSpan(
                    text: Model?.carStatusName.toString() ?? "",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff121217), // تقدر تغيّر اللون حسب الحالة
                    ),
                  ),
                ],
              ),
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
                      CustomBottomSheet(context, onTap: () async {
                        await BlocProvider.of<settingCubit>(context)
                            .deleteStatus(Model!.id);
                        Navigator.pop(context);
                      });
                    },
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: customSelectButton(
                    btnText: "edit",
                    borderColor: Colors.blue,
                    behindIcon: Icons.edit,
                    btnheight: 40,
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
  }
}
