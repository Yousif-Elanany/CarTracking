import 'package:car_tracking/features/setting/business_logic/setting_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void CustomBottomSheet(BuildContext context, {required void Function()? onTap}) {
  final settingsCubit = BlocProvider.of<settingCubit>(context);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return BlocProvider.value(
        value: settingsCubit,
        child: Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 30,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Color(0xFF6C6C89),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(height: 24),

              /// ✅ هنا بنستخدم صورة بدل الأيقونة
              Image.asset(
                'assets/images/delete.png', // غير المسار حسب مكان الصورة
                width: 100,
                height: 100,
              ),

              SizedBox(height: 24),
              Text(
                'Are you sure, you want to delete this item.\nIf you continue you will not be able to recover it.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF6C6C89),
                  fontSize: 14,
                  height: 1.6,
                ),
              ),
              SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        print(" على تأكيد");
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey)),
                        alignment: Alignment.center,
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: GestureDetector(
                      onTap:onTap,



                      //     () async{
                      //  await settingsCubit.deleteCity(id!);
                      //   Navigator.pop(context);
                      // },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: Color(0xffD50B3E),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Delete',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
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
