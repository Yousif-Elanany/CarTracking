import 'package:car_tracking/features/setting/business_logic/setting_cubit.dart';
import 'package:car_tracking/features/setting/widgets/colorPicker.dart';
import 'package:car_tracking/presentation/screens/MapScreen/PolyganMapScreen.dart';
import 'package:car_tracking/presentation/widgets/toggleBtn.dart';
import 'package:flutter/material.dart';
import 'package:car_tracking/presentation/widgets/CustomDropDownList.dart';
import 'package:car_tracking/presentation/widgets/CustomTextFormField.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/Models/cityModel.dart';

void CustomAddRefionBottomSheet(BuildContext context) {
  TextEditingController regionController = TextEditingController();
  TextEditingController coordinatesController = TextEditingController();

  TextEditingController minimumStayController = TextEditingController();
  TextEditingController nameOfLocationController = TextEditingController();
  dynamic coordinates;
  final List<String> titles = ['Details', 'User permissions'];
  CityModel? selectedCity;
  String? selectedCityId;
  List<String> cities = ['Cairo', 'Alex', 'Giza'];
  // String? selectedCity;
  final settingsCubit = BlocProvider.of<settingCubit>(context);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String coordinatesToString(List<Map<String, double>> coordinates) {
    return coordinates
        .expand((coord) => [coord['lat'], coord['lng']])
        .map((value) => value.toString())
        .join(',');
  }
  String Coordinates = "";
  double? lat;
  double? lng;
  bool isAlert = true; // true => صح, false => خطأ
  int selectedIndex = 0;
  List<CityModel> CityList = settingsCubit.citiesList;

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
            bottom: MediaQuery.of(context).viewInsets.bottom + 30,
          ),
          child: Form(
            key: _formKey,
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
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 12),
                            CustomTextField(
                              controller: regionController,
                              hintText: 'Region Name',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'enter Region Name ';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 6),
                            CustomTextField(
                              controller: coordinatesController,
                              hintText: 'Coordinates',
                              readOnly: true,
                            ),
                            SizedBox(height: 6),
                            CustomTextField(
                              controller: nameOfLocationController,
                              hintText: 'Name of Location',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'enter Location Name ';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 6),
                            ColorPickerDropdown(),
                            SizedBox(height: 6),
                            GestureDetector(
                              onTap: () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => MapPolygonScreen()),
                                );

                                if (result != null) {
                                  // result حيكون List<Map<String, double>>
                                  print('Selected Points: $result');
                                  coordinates = result;
                                  //      coordinatesController.text=coordinates;
                                  //         coordinatesController=result;
                                  Coordinates =         coordinatesToString(coordinates);
                                  coordinatesController.text=Coordinates;
                                  print("///////////////////////");
                                  print("object:$coordinates");
                                  print("///////////////////////");

                                  // هنا تقدر تعمل setState وتحفظ النقط حسب ما تحب
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                height:
                                    MediaQuery.sizeOf(context).height * 0.15,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Image.asset(
                                  "assets/images/map2.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: 6),
                            CustomTextField(
                              controller: minimumStayController,
                              hintText: 'Minimum Stay Count',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'enter Minimum Stay ';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 6),
                            Text(
                              "is Alert ?",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 6),
                            Row(
                              children: [
                                Expanded(
                                  child: ToggleButtonOption(
                                    label: "Yes",
                                    value: true,
                                    groupValue: isAlert,
                                    onChanged: (val) {
                                      setState(() {
                                        isAlert = val;
                                        print(isAlert);
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: ToggleButtonOption(
                                    label: "No",
                                    value: false,
                                    groupValue: isAlert,
                                    onChanged: (val) {
                                      setState(() {
                                        isAlert = val;
                                        print(isAlert);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            CustomDropdown<CityModel>(
                              hint: 'Select City',
                              value: selectedCity,
                              items: CityList,
                              itemAsString: (city) => city.cityName,
                              onChanged: (city) {
                                setState(() {
                                  selectedCity = city;
                                  selectedCityId = city?.id; // هنا نخزن الايدي
                                });
                              },
                            ),
                            SizedBox(height: 15),
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
                                    onTap: () async {
                                      if (_formKey.currentState!.validate()) {
                                        await BlocProvider.of<settingCubit>(
                                                context)
                                            .addRegion(
                                                regionController.text,
                                            Coordinates,
                                                nameOfLocationController.text,
                                                isAlert,
                                                int.parse(
                                                    minimumStayController.text),
                                                selectedCityId!);
                                        regionController.clear();
                                        nameOfLocationController.clear();

                                        minimumStayController.clear();

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
          ),
        ),
      );
    },
  );
}
