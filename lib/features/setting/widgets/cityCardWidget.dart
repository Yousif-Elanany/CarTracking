import 'package:car_tracking/features/setting/business_logic/setting_cubit.dart';
import 'package:car_tracking/features/setting/data/Models/cityModel.dart';
import 'package:car_tracking/features/setting/widgets/customAddCityBottomSheet.dart';
import 'package:car_tracking/presentation/widgets/CustomBottomSheet.dart';
import 'package:car_tracking/presentation/widgets/customSelectButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class cityCardWidget extends StatefulWidget {
  // final Map<String, dynamic> carData;
  CityModel? model;

   cityCardWidget({this.model}) ;

  @override
  State<cityCardWidget> createState() => _cityCardWidgetState();
}

class _cityCardWidgetState extends State<cityCardWidget> {

  @override
  Widget build(BuildContext context) {
    final settingsCubit = BlocProvider.of<settingCubit>(context);

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
                  TextSpan(text: 'City: '),
                  TextSpan(
                    text: widget.model?.cityName ?? "",
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
                  TextSpan(text: 'City Code: '),
                  TextSpan(
                    text: widget.model?.cityCode ?? "",
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
                    btnheight: 35,

                    btnTextColor: Colors.red,
                    ontap: () {
                      CustomBottomSheet(context ,onTap: ()async{
                        await settingsCubit.deleteCity(widget.model!.id);
                        Navigator.pop(context);
                      });
                    },
                  ),
                ),
                SizedBox(width: MediaQuery.sizeOf(context).width*0.05,),
                Expanded(
                  child: customSelectButton(
                    btnText: "edit",
                    borderColor: Colors.blue,
                    behindIcon: Icons.edit,
                    btnheight: 35,
                    iconColor: Colors.blue,
                    btnTextColor: Colors.blue,
                    ontap: () {
                      CustomAddCityBottomSheet(context,city: widget.model);


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
