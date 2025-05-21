import 'package:car_tracking/features/setting/business_logic/setting_cubit.dart';
import 'package:car_tracking/features/setting/data/Models/carStatus.dart';
import 'package:car_tracking/presentation/widgets/CustomBtn.dart';
import 'package:car_tracking/presentation/widgets/CustomTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void CustomAddStatusBottomSheet(BuildContext context,
    {CarStatusModel? statusmodel}) {
  final bool isEditMode = statusmodel != null;

//  TextEditingController StatusController = TextEditingController();
  final TextEditingController StatusController =
      TextEditingController(text: isEditMode ? statusmodel?.carStatusName : "");
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final settingsCubit = BlocProvider.of<settingCubit>(context);
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    builder: (context) {
      return BlocProvider.value(
        value: settingsCubit,
        child: Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 0,
            bottom: MediaQuery.of(context).viewInsets.bottom + 30,
          ),
          child: Form(
            key: _formKey,
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
                    Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // مهم عشان الشيت ما ياخدش كل الشاشة
                          children: [
                            Text(
                              !isEditMode ? "Add Status" : "Edit Status",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 12),
                            CustomTextField(
                              controller: StatusController,
                              hintText: 'Status',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'enter Status Name ';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 60),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 14),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border:
                                              Border.all(color: Colors.grey)),
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
                                    onTap: () async {
                                      if (_formKey.currentState!.validate()) {
                                        if (isEditMode) {
                                          await BlocProvider.of<settingCubit>(
                                                  context)
                                              .editCarStatus(statusmodel.id,
                                                  StatusController.text);
                                        } else {
                                          await BlocProvider.of<settingCubit>(
                                                  context)
                                              .addCarStatus(
                                                  StatusController.text);
                                        }

                                        StatusController.clear();
                                        Navigator.pop(
                                            context); // يقفل الشييت بعد الفلترة
                                      } else {
                                        // لو التواريخ مش موجودة، ممكن تظهر رسالة تنبيه للمستخدم
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content:
                                              Text('Please senter Status Name'),
                                        ));
                                      }
                                    },
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 14),
                                      decoration: BoxDecoration(
                                        color: Color(0xff167AD8),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        isEditMode ? "Edit" : 'Add',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ))
                  ],
                );
              },
            ),
          ),
        ),
      );
    },
  );
}
