import 'package:car_tracking/features/Maps/MapScreen.dart';
import 'package:car_tracking/features/setting/business_logic/setting_cubit.dart';
import 'package:car_tracking/features/setting/data/Models/BranchModel.dart';
import 'package:car_tracking/features/setting/data/Models/cityModel.dart';
import 'package:car_tracking/presentation/screens/MapScreen/map.dart';
import 'package:flutter/material.dart';
import 'package:car_tracking/presentation/widgets/CustomBtn.dart';
import 'package:car_tracking/presentation/widgets/CustomDropDownList.dart';
import 'package:car_tracking/presentation/widgets/CustomTextFormField.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void CustomAddBranchBottomSheet(
    BuildContext context, {
      BranchModel? branch, // null معناها إضافة، مش null معناها تعديل
    }) {
  final bool isEditMode = branch != null;
  final settingsCubit = BlocProvider.of<settingCubit>(context);
  final List<CityModel> CityList = settingsCubit.citiesList;

  CityModel? selectedCity = isEditMode
      ? CityList.firstWhere((c) => c.id == branch!.id, orElse: () => CityList.first)
      : null;
  String? selectedId = selectedCity?.id;

  TextEditingController branchController =
  TextEditingController(text: isEditMode ? branch!.branchName : '');
  TextEditingController locationController =
  TextEditingController(text: isEditMode ? branch!.nameOfLocation : '');
  TextEditingController rangeController = TextEditingController(
      text: isEditMode ? branch!.allowedSpace.toString() : '');

  dynamic? lat = isEditMode ? branch!.lat : null;
  dynamic? lng = isEditMode ? branch!.long : null;

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
                              isEditMode ? "Edit Branch" : "Add Branch",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 12),
                            CustomTextField(
                              controller: branchController,
                              hintText: 'Branch Name',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter branch name';
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
                                  selectedId = city?.id;
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
                                  return 'Enter location';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 12),
                            CustomTextField(
                              controller: rangeController,
                              hintText: 'Allowed Range',
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter allowed range';
                                }
                                return null;
                              },
                            ),
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
                                        if (isEditMode) {
                                          await settingsCubit.editBranch(
                                            branch!.id,
                                            branchController.text,
                                            int.parse(rangeController.text),
                                            lat?.toDouble() ?? 0,
                                            lng?.toDouble()?? 0,
                                            locationController.text,
                                            selectedId ?? "",
                                          );
                                        } else {
                                          await settingsCubit.addBranch(
                                            branchController.text,
                                            int.parse(rangeController.text),
                                            lat ?? 0,
                                            lng ?? 0,
                                            locationController.text,
                                            selectedId ?? "",
                                          );
                                        }

                                        branchController.clear();
                                        rangeController.clear();
                                        locationController.clear();

                                        Navigator.pop(context);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content:
                                          Text('Please fill all fields'),
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
                                        isEditMode ? 'Update' : 'Add',
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

