import 'package:car_tracking/features/setting/business_logic/setting_cubit.dart';
import 'package:car_tracking/features/setting/business_logic/setting_states.dart';
import 'package:car_tracking/features/setting/data/Models/carTypeModel.dart';
import 'package:car_tracking/presentation/widgets/CustomBottomSheet.dart';
import 'package:car_tracking/presentation/widgets/customSelectButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../data/Models/carTypeModel.dart';

class CarTypeCardWidget extends StatefulWidget {
  // final Map<String, dynamic> carData;
  CarTypeModel? typeModel;
  CarTypeCardWidget({this.typeModel});

  @override
  State<CarTypeCardWidget> createState() => _CarTypeCardWidgetState();
}

class _CarTypeCardWidgetState extends State<CarTypeCardWidget> {
  @override
  Widget build(BuildContext context) {
    final settingsCubit = BlocProvider.of<settingCubit>(context);

    return BlocConsumer<settingCubit, settingState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          width: double.infinity,
          //height: 100,
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
                Container(
                  width: double.infinity,
                  height: 70,
                  child: Image.asset("assets/images/car.png"),
                ),

                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                    children: [
                      TextSpan(text: 'Car type: '),
                      TextSpan(
                        text: widget.typeModel?.carTypeName ?? "",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color:
                              Color(0xff121217), // تقدر تغيّر اللون حسب الحالة
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
                          iconColor: Colors.red,
                          btnheight: 32,
                          btnTextColor: Colors.red,
                          ontap: () {
                            CustomBottomSheet(context, onTap: () async {
                              await settingsCubit
                                  .deleteType(widget.typeModel!.id);
                              Navigator.pop(context);
                            });
                          }),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: customSelectButton(
                        btnText: "edit",
                        borderColor: Colors.blue,
                        behindIcon: Icons.edit,
                        btnheight: 32,
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
