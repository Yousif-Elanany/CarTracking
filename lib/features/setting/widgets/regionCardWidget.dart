import 'package:car_tracking/features/setting/data/Models/regionModel.dart';
import 'package:car_tracking/features/setting/widgets/customAddRegionBottomSheet.dart';
import 'package:car_tracking/presentation/widgets/CustomBottomSheet.dart';
import 'package:car_tracking/presentation/widgets/customSelectButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../business_logic/setting_cubit.dart';

class regionCardWidget extends StatefulWidget {
  // final Map<String, dynamic> carData;
  RegionModel? Model;
  regionCardWidget({this.Model});

  @override
  State<regionCardWidget> createState() => _regionCardWidgetState();
}

class _regionCardWidgetState extends State<regionCardWidget> {
  @override
  Widget build(BuildContext context) {
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
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
                children: [
                  TextSpan(text: 'Region name:: '),
                  TextSpan(
                    text: widget.Model?.regionName ?? "",
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

            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
                children: [
                  TextSpan(text: 'is alert:: '),
                  TextSpan(
                    text: widget.Model?.isAlert == true ? "yes" : "No",
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

            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
                children: [
                  TextSpan(text: 'City: '),
                  TextSpan(
                    text: widget.Model?.nameOfLocation ?? "",
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

            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
                children: [
                  TextSpan(text: 'color:    '),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),

            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
                children: [
                  TextSpan(text: 'Min Stay Count: '),
                  TextSpan(
                    text: "${widget.Model?.minStayCount ?? 0}",
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

            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
                children: [
                  TextSpan(text: 'city name: '),
                  TextSpan(
                    text: widget.Model?.cityName ?? "",
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

            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
                children: [
                  TextSpan(text: 'city code: '),
                  TextSpan(
                    text: widget.Model?.cityCode ?? "",
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
                    iconColor: Colors.red,
                    btnTextColor: Colors.red,
                    btnheight: 35,
                    ontap: () {
                      CustomBottomSheet(context, onTap: () async {
                        await BlocProvider.of<settingCubit>(context)
                            .deleteRegion(widget.Model!.id);
                        Navigator.pop(context);
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.05,
                ),
                Expanded(
                  child: customSelectButton(
                    btnText: "edit",
                    borderColor: Colors.blue,
                    behindIcon: Icons.edit,
                    iconColor: Colors.blue,
                    btnheight: 35,
                    btnTextColor: Colors.blue,
                    ontap: () {
                      CustomAddRefionBottomSheet(context,
                          RegionModel: widget.Model);
                    },
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
