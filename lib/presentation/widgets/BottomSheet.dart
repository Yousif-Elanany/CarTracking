import 'package:car_tracking/features/fleetManagement/business_logic/fleetManagment_cubit.dart';
import 'package:car_tracking/features/fleetManagement/business_logic/fleetManagment_states.dart';
import 'package:car_tracking/presentation/widgets/CustomBtn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

void showFilterSheet(BuildContext context, {String? carId}) {
  DateTime? startDate;
  DateTime? endDate;

  final fleetCubit = BlocProvider.of<fleetManagmentCubit>(context); // <-- خد الكيوبت الأساسي

  showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    isScrollControlled: true,
    builder: (context) {
      final dateFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");

      return BlocProvider.value( // ✅ ضيف الكيوبت هنا
        value: fleetCubit,
        child: Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 0,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 50,
                    child: Divider(
                      thickness: 5,
                      color: Color(0xff6C6C89),
                    ),
                  ),
                  SizedBox(height: 24),

                  // تاريخ البداية
                  GestureDetector(
                    onTap: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: startDate ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        setState(() => startDate = picked);
                      }
                    },
                    child: Container(
                      padding:
                      EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Text(
                            startDate != null
                                ? 'from: ${dateFormat.format(startDate!.toUtc())}'
                                : 'start date',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          Spacer(),
                          Icon(
                            Icons.calendar_month,
                            size: 20,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),

                  // تاريخ النهاية
                  GestureDetector(
                    onTap: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: endDate ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        setState(() => endDate = picked);
                      }
                    },
                    child: Container(
                      padding:
                      EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Text(
                            endDate != null
                                ? 'to: ${dateFormat.format(endDate!.toUtc())}'
                                : 'end date',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          Spacer(),
                          Icon(
                            Icons.calendar_month,
                            size: 20,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.2),

                  // زر التطبيق
                  CustomButton(
                    backGroundColor: const Color(0xff167AD8),
                    child: Text("filter",
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                    onPressed: () async {
                      if (startDate != null && endDate != null) {
                        BlocProvider.of<fleetManagmentCubit>(context).getCarTrip(
                          carId.toString(),
                          dateFormat.format(startDate!.toUtc()).toString(),
                          dateFormat.format(endDate!.toUtc()).toString(),
                        );
                        Navigator.pop(context); // يقفل الشييت بعد الفلترة
                      } else {
                        // لو التواريخ مش موجودة، ممكن تظهر رسالة تنبيه للمستخدم
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Please select both start and end dates'),
                        ));
                      }

                    },
                  ),
                ],
              );
            },
          ),
        ),
      );
    },
  );
}

