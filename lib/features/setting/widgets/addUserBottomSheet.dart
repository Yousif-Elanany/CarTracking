import 'package:car_tracking/features/setting/relatedToSettingScreen/users/Details.dart';
import 'package:car_tracking/presentation/screens/MapScreen/PolyganMapScreen.dart';
import 'package:car_tracking/presentation/screens/MapScreen/map.dart';

import 'package:car_tracking/presentation/widgets/toggleBtn.dart';
import 'package:flutter/material.dart';
import 'package:car_tracking/presentation/widgets/CustomBtn.dart';
import 'package:car_tracking/presentation/widgets/CustomDropDownList.dart';
import 'package:car_tracking/presentation/widgets/CustomTextFormField.dart';

import '../relatedToSettingScreen/users/userPermision.dart';

void CustomAddUserBottomSheet(BuildContext context) {
  TextEditingController branchController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController rangeController = TextEditingController();
  dynamic coordinates;
  final List<String> titles = ['Details', 'User permissions'];

  List<String> cities = ['Cairo', 'Alex', 'Giza'];
  String? selectedCity;
  double? lat;
  double? lng;
  bool isAlert = true; // true => صح, false => خطأ
  int selectedIndex = 0;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 30,
        ),
        child: StatefulBuilder(
          builder: (context, setState) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                //  crossAxisAlignment: CrossAxisAlignment.start,

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
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Add user",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500,),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey), // الحواف الرصاصي
                          ),
                          child: Row(
                            children: List.generate(titles.length, (index) {
                              final isSelected = index == selectedIndex;
                              return Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = index;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 12),
                                    decoration: BoxDecoration(
                                      color: isSelected ? Color(0xff167AD8) : Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      titles[index],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: isSelected ? Colors.white : Colors.grey ,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height*0.5,
                          child: IndexedStack(
                            index: selectedIndex,
                            children: [
                              userDetail(),
                              userPermission(),

                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 14),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey),
                                  ),
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
                                onTap: () {
                                  print("Branch Name: ${branchController.text}");
                                  print("City: $selectedCity");
                                  print("Location: ${locationController.text}");
                                  print("Range: ${rangeController.text}");
                                  print("Latitude: $lat");
                                  print("Longitude: $lng");
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 14),
                                  decoration: BoxDecoration(
                                    color: Color(0xff167AD8),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Add',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),


                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      );
    },
  );
}
