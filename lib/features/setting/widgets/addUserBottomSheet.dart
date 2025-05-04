import 'package:car_tracking/features/setting/business_logic/setting_cubit.dart';
import 'package:car_tracking/features/setting/data/Models/BranchModel.dart';
import 'package:car_tracking/features/setting/data/Models/carModel.dart';
import 'package:car_tracking/features/setting/data/Models/cityModel.dart';
import 'package:car_tracking/features/setting/relatedToSettingScreen/users/Details.dart';
import 'package:car_tracking/features/setting/widgets/userActiveWidget.dart';
import 'package:car_tracking/presentation/screens/MapScreen/PolyganMapScreen.dart';
import 'package:car_tracking/presentation/screens/MapScreen/map.dart';
import 'package:car_tracking/presentation/widgets/simpleactivewidget.dart';

import 'package:car_tracking/presentation/widgets/toggleBtn.dart';
import 'package:flutter/material.dart';
import 'package:car_tracking/presentation/widgets/CustomBtn.dart';
import 'package:car_tracking/presentation/widgets/CustomDropDownList.dart';
import 'package:car_tracking/presentation/widgets/CustomTextFormField.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../relatedToSettingScreen/users/userPermision.dart';

void CustomAddUserBottomSheet(BuildContext context) {
  dynamic coordinates;
  final List<String> titles = ['Details', 'User permissions'];
  final settingsCubit = BlocProvider.of<settingCubit>(context);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isAdmin = false;
  bool isUser = false;
  bool isEditor = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isActive = true;
  List<CarModel> cars = BlocProvider.of<settingCubit>(context).carsList;
  List<BranchModel> branches =
      BlocProvider.of<settingCubit>(context).branchesList;
  CarModel? selectedCar;
  BranchModel? selectedBranch;
  List<Map<String, String>> selectedBranchesResults = [];
  List<Map<String, String>> selectedCarsResults = [];
  String? selectedCarId;
  String? selectedBranchId;
  List<String> userRoles = [];
  bool isAlert = true; // true => صح, false => خطأ
  int selectedIndex = 0;
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
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: Colors.grey), // الحواف الرصاصي
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
                                        padding:
                                            EdgeInsets.symmetric(vertical: 12),
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? Color(0xff167AD8)
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          titles[index],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: isSelected
                                                ? Colors.white
                                                : Colors.grey,
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
                              height: MediaQuery.sizeOf(context).height * 0.5,
                              child: selectedIndex == 0
                                  ? Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: ListView(
                                        children: [
                                          CustomTextField(
                                            controller: nameController,
                                            hintText: 'Name',
                                          ),
                                          const SizedBox(height: 10),
                                          CustomTextField(
                                            controller: emailController,
                                            hintText: 'Email',
                                          ),
                                          const SizedBox(height: 10),
                                          CustomTextField(
                                            controller: phoneController,
                                            hintText: 'Phone',
                                          ),
                                          const SizedBox(height: 10),
                                          CustomTextField(
                                            controller: passwordController,
                                            hintText: 'Password',
                                            obscureText: true,
                                          ),
                                          const SizedBox(height: 10),
                                          UserActivationSwitch(
                                            rightText: "User Activation",
                                            isEnabled: true,
                                            isActivated: isActive,
                                            onChanged: (value) {
                                              setState(() {
                                                isActive = value;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            User_ActivationSwitch(
                                              rightText: 'Admin',
                                              isActivated: isAdmin,
                                              isEnabled: !(isUser ||
                                                  isEditor), // تعطيل التفعيل إذا تم تفعيل Branch أو Car
                                              onChanged: (value) {
                                                setState(() {
                                                  isAdmin = value;
                                                  if (value) {
                                                    // إذا تم تفعيل Admin، أضف القيمة "Admin" إلى الـ List
                                                    if (!userRoles
                                                        .contains('Admin')) {
                                                      userRoles.add('Admin');
                                                      print(userRoles);
                                                    }
                                                    // تعطيل Branch و Car عند تفعيل Admin
                                                    isUser = false;
                                                    isEditor = false;
                                                  } else {
                                                    userRoles.remove('Admin');
                                                    print(userRoles);
                                                  }
                                                });
                                              },
                                            ),

                                            const SizedBox(height: 10),

// المفتاح الثاني: Branch controller
                                            User_ActivationSwitch(
                                              rightText: 'Branch controller',
                                              isActivated: isUser,
                                              isEnabled:
                                                  !isAdmin, // تعطيل Branch إذا كان Admin مفعل
                                              onChanged: (value) {
                                                setState(() {
                                                  isUser = value;
                                                  if (value) {
                                                    // إذا تم تفعيل Branch controller، أضف القيمة "Branch" إلى الـ List
                                                    if (!userRoles
                                                        .contains('Branch')) {
                                                      userRoles.add('Branch');
                                                      print(userRoles);
                                                    }
                                                  } else {
                                                    userRoles.remove('Branch');
                                                    print(userRoles);
                                                  }
                                                });
                                              },
                                            ),

                                            const SizedBox(height: 10),

// المفتاح الثالث: Car controller
                                            User_ActivationSwitch(
                                              rightText: 'Car controller',
                                              isActivated: isEditor,
                                              isEnabled:
                                                  !isAdmin, // تعطيل Car إذا كان Admin مفعل
                                              onChanged: (value) {
                                                setState(() {
                                                  isEditor = value;
                                                  if (value) {
                                                    // إذا تم تفعيل Car controller، أضف القيمة "Car" إلى الـ List
                                                    if (!userRoles
                                                        .contains('Car')) {
                                                      userRoles.add('Car');
                                                      print(userRoles);
                                                    }
                                                  } else {
                                                    userRoles.remove('Car');
                                                    print(userRoles);
                                                  }
                                                });
                                              },
                                            ),
                                            const SizedBox(height: 10),
                                            isAdmin != true
                                                ? Column(
                                                    children: [
                                                      CustomDropdown<CarModel>(
                                                        hint: 'Select Car',
                                                        value: selectedCar,
                                                        items: cars,
                                                        itemAsString: (Car) =>
                                                            Car.name,
                                                        onChanged: (Car) {
                                                          setState(() {
                                                            selectedCar = Car;
                                                            selectedCarId = Car
                                                                ?.id; // هنا نخزن الايدي
                                                            if (!selectedCarsResults
                                                                .any((element) =>
                                                                    element[
                                                                        "id"] ==
                                                                    selectedCarId)) {
                                                              selectedCarsResults
                                                                  .add({
                                                                "id":
                                                                    selectedCarId!
                                                              });
                                                            }
                                                          });
                                                          print(
                                                              selectedCarsResults);
                                                        },
                                                      ),
                                                      SizedBox(height: 0),
                                                      if (selectedCarsResults
                                                          .isNotEmpty)
                                                        Text('Selected Cars',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      SizedBox(height: 8),
                                                      SingleChildScrollView(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        child: Row(
                                                          children:
                                                              selectedCarsResults
                                                                  .map(
                                                                      (selectedCity) {
                                                            final id = selectedCity[
                                                                'id']; // Assuming the map has 'id' key
                                                            final city =
                                                                cars.firstWhere(
                                                              (item) =>
                                                                  item.id ==
                                                                  id, // Compare the 'id' from map with 'id' from model
                                                              orElse: () =>
                                                                  CarModel(
                                                                id: '',
                                                                name:
                                                                    'جاري التحميل...',
                                                              ),
                                                            );

                                                            return Container(
                                                              margin: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          6),
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          12,
                                                                      vertical:
                                                                          8),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .grey[100],
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                              ),
                                                              child: Row(
                                                                children: [
                                                                  Text(city
                                                                      .name),
                                                                  SizedBox(
                                                                      width: 8),
                                                                  GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          selectedCarsResults
                                                                              .remove(selectedCity);
                                                                        });
                                                                      },
                                                                      child: Icon(
                                                                          Icons
                                                                              .close,
                                                                          size:
                                                                              18,
                                                                          color:
                                                                              Colors.red)),
                                                                ],
                                                              ),
                                                            );
                                                          }).toList(),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(),
                                            const SizedBox(height: 10),
                                            isAdmin != true
                                                ? Column(
                                                    children: [
                                                      CustomDropdown<
                                                          BranchModel>(
                                                        hint: 'Select Branch',
                                                        value: selectedBranch,
                                                        items: branches,
                                                        itemAsString:
                                                            (branch) =>
                                                                branch.cityName,
                                                        onChanged: (branch) {
                                                          setState(() {
                                                            selectedBranch =
                                                                branch;
                                                            selectedBranchId =
                                                                branch?.id;
                                                            if (!selectedBranchesResults
                                                                .any((element) =>
                                                                    element[
                                                                        "id"] ==
                                                                    selectedBranchId)) {
                                                              selectedBranchesResults
                                                                  .add({
                                                                "id":
                                                                    selectedBranchId!
                                                              });
                                                            }
                                                            print(
                                                                selectedBranchesResults);
                                                          });
                                                        },
                                                      ),
                                                      SizedBox(height: 0),
                                                      if (selectedBranchesResults
                                                          .isNotEmpty)
                                                        Text(
                                                            'Selected Branches',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      SizedBox(height: 8),
                                                      SingleChildScrollView(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        child: Row(
                                                          children:
                                                              selectedBranchesResults
                                                                  .map(
                                                                      (selectedBranch) {
                                                            final id =
                                                                selectedBranch[
                                                                    'id']; // Assuming the map has 'id' key
                                                            final branch =
                                                                branches
                                                                    .firstWhere(
                                                              (item) =>
                                                                  item.id ==
                                                                  id, // Compare the 'id' from map with 'id' from model
                                                              orElse: () => BranchModel(
                                                                  id: '',
                                                                  cityName:
                                                                      'جاري التحميل...',
                                                                  nameOfLocation:
                                                                      "",
                                                                  branchName:
                                                                      '',
                                                                  allowedSpace:
                                                                      0,
                                                                  lat: 0,
                                                                  long: 0),
                                                            );

                                                            return Container(
                                                              margin: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          6),
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          12,
                                                                      vertical:
                                                                          8),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .grey[100],
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                              ),
                                                              child: Row(
                                                                children: [
                                                                  Text(branch
                                                                      .cityName),
                                                                  SizedBox(
                                                                      width: 8),
                                                                  GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          selectedBranchesResults
                                                                              .remove(selectedBranch);
                                                                        });
                                                                      },
                                                                      child: Icon(
                                                                          Icons
                                                                              .close,
                                                                          size:
                                                                              18,
                                                                          color:
                                                                              Colors.red)),
                                                                ],
                                                              ),
                                                            );
                                                          }).toList(),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(),
                                          ],
                                        ),
                                      ),
                                    ),

                              // IndexedStack(
                              //   index: selectedIndex,
                              //   children: [
                              //    UserDetail(),
                              //     userPermission(),
                              //   ],
                              // ),
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
                                      print(
                                          "nameController: ${nameController.text}");
                                      print(
                                          "emailController: ${emailController.text}");
                                      print(
                                          "Location: ${phoneController.text}");
                                      print(
                                          "Range: ${passwordController.text}");
                                      print("isActive: $isActive");
                                      if (_formKey.currentState!.validate()) {
                                        await BlocProvider.of<settingCubit>(
                                                context)
                                            .addUser(
                                                nameController.text,
                                                emailController.text,
                                                phoneController.text,
                                                isActive,
                                                passwordController.text,
                                                userRoles,
                                                selectedCarsResults,
                                                selectedBranchesResults);

                                         Navigator.pop(
                                             context); // يقفل الشييت بعد الفلترة
                                      } else {
                                        // لو التواريخ مش موجودة، ممكن تظهر رسالة تنبيه للمستخدم
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(''),
                                        ));
                                      }

                                      //    print("Longitude: $lng");
                                      // Navigator.pop(context);
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
