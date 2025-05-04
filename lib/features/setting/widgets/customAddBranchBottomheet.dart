import 'package:car_tracking/features/Maps/MapScreen.dart';
import 'package:car_tracking/features/setting/business_logic/setting_cubit.dart';
import 'package:car_tracking/features/setting/data/Models/cityModel.dart';
import 'package:car_tracking/presentation/screens/MapScreen/map.dart';
import 'package:flutter/material.dart';
import 'package:car_tracking/presentation/widgets/CustomBtn.dart';
import 'package:car_tracking/presentation/widgets/CustomDropDownList.dart';
import 'package:car_tracking/presentation/widgets/CustomTextFormField.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void CustomAddBranchBottomSheet(BuildContext context) {
  TextEditingController branchController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController rangeController = TextEditingController();
  final settingsCubit = BlocProvider.of<settingCubit>(context);
  List<CityModel> CityList = settingsCubit.citiesList;
  CityModel? selectedCity;
  String? selectedId;
  List<String> cities = ['Cairo', 'Alex', 'Giza'];
  //int? selectedCity;

  double? lat;
  double? lng;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                              "Add Branch",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 12),
                            CustomTextField(
                              controller: branchController,
                              hintText: 'Branch Name',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'enter City Name ';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 12),
                            CustomDropdown<CityModel>(
                              hint: 'Select City',
                              value: selectedCity,
                              items: CityList,
                              itemAsString: (city) => city.cityName,
                              onChanged: (city) {
                                setState(() {
                                  selectedCity = city;
                                  selectedId = city?.id; // هنا نخزن الايدي
                                });
                              },
                            ),
                            SizedBox(height: 12),
                            CustomTextField(
                                controller: locationController,
                                hintText: 'Branch Location',
                                readOnly: true,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'enter City Name ';
                                  }
                                  return null;
                                }),
                            SizedBox(height: 12),
                            CustomTextField(
                                controller: rangeController,
                                hintText: 'Allowed Range',
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'enter Allowed Range ';
                                  }
                                  return null;
                                }),
                            SizedBox(height: 12),
                            GestureDetector(
                              onTap: () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => MapScreen()),
                                );

                                if (result != null) {
                                  setState(() {
                                    lat = result['lat'];
                                    lng = result['lng'];
                                    locationController.text = result['address'];
                                  });
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
                            SizedBox(height: 50),
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
                                            .addBranch(
                                                branchController.text,
                                                int.parse(rangeController.text),
                                                lat ?? 0,
                                                lng ?? 0,
                                                locationController.text,
                                                selectedId ?? "");
                                        branchController.clear();
                                        rangeController.clear();

                                        locationController.clear();

                                        // await BlocProvider.of<settingCubit>(
                                        //         context)
                                        //     .getCities();
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
