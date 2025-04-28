import 'package:car_tracking/features/setting/widgets/userActiveWidget.dart';
import 'package:car_tracking/presentation/widgets/CustomDropDownList.dart';
import 'package:car_tracking/presentation/widgets/CustomTextFormField.dart';
import 'package:flutter/material.dart';

class userPermission extends StatefulWidget {
  const userPermission({super.key});

  @override
  State<userPermission> createState() => _userPermissionState();
}

class _userPermissionState extends State<userPermission> {
  bool isAdmin = false;
  bool isUser = false;
  bool isEditor = false;

  List<String> cities = ['Cairo', 'Alex', 'Giza'];
  String? selectedCity;
  List<String> branches = ['ridah', 'Gada', 'otherBranch'];
  String? selectedBranch;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            User_ActivationSwitch(
              rightText: 'Admin',
              isActivated: isAdmin,
              isEnabled: !(isUser || isEditor),
              onChanged: (value) {
                setState(() {
                  isAdmin = value;
                  if (value) {
                    isUser = false;
                    isEditor = false;
                  }
                });
              },
            ),
            SizedBox(height: 10),
            User_ActivationSwitch(
              rightText: 'Branch controller',
              isActivated: isUser,
              isEnabled: !isAdmin,
              onChanged: (value) {
                setState(() {
                  isUser = value;
                  if (value) isAdmin = false;
                });
              },
            ),
            SizedBox(height: 10),
            User_ActivationSwitch(
              rightText: 'Car controller',
              isActivated: isEditor,
              isEnabled: !isAdmin,
              onChanged: (value) {
                setState(() {
                  isEditor = value;
                  if (value) isAdmin = false;
                });
              },
            ),
            SizedBox(height: 10),
            // CustomDropdown(
            //   hint: 'City',
            //   value: selectedCity,
            //   items: cities,
            //   onChanged: (val) => setState(() => selectedCity = val),
            // ),
            SizedBox(height: 10),
            // CustomDropdown(
            //   hint: 'Branches',
            //   value: selectedBranch,
            //   items: branches,
            //   onChanged: (val) => setState(() => selectedBranch = val),
            // ),
          ],
        ),
      ),
    );
  }

}
