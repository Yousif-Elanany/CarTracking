import 'package:car_tracking/features/auth/data/Models/userModel.dart';
import 'package:car_tracking/features/setting/data/Models/userModel.dart';
import 'package:car_tracking/presentation/widgets/CustomBottomSheet.dart';
import 'package:car_tracking/presentation/widgets/customSelectButton.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class userCardWidget extends StatelessWidget {
  // final Map<String, dynamic> carData;
  UsersModel? Model;
  userCardWidget({this.Model});

  @override
  Widget build(BuildContext context) {
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
            blurRadius: 5,
            offset: Offset(0, 3),
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
                  TextSpan(text: 'User name:: '),
                  TextSpan(
                    text: Model?.userName ?? "",
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
                  TextSpan(text: 'Phone Number: '),
                  TextSpan(
                    text: Model?.phoneNumber ?? "",
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
                  TextSpan(text: 'Role:: '),
                  TextSpan(
                    text:
                        '${(Model?.roles.isNotEmpty) ? (Model?.roles[0] ?? 0) : ""}',
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
                  TextSpan(text: 'Account status: '),
                  TextSpan(
                    text: Model?.userActivation == null
                        ? ""
                        : Model?.userActivation == true
                            ? "Active"
                            : "Not Active",
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
                  TextSpan(text: 'last login:: '),
                  TextSpan(
                    text: Model?.lastLogin ?? "",
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
            Column(
              children: [
                customSelectButton(
                  btnText: "edit",
                  borderColor: Colors.blue,
                  behindIcon: Icons.edit,
                  iconColor: Colors.blue,
                  btnheight: 35,
                  btnTextColor: Colors.blue,
                  ontap: () {},
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height*0.02),
                customSelectButton(
                  btnText: "ChangePassword",
                  borderColor: Colors.blue,
                  behindIcon: Icons.vpn_key_outlined,
                  iconColor: Colors.blue,
                  btnheight: 35,

                  btnTextColor: Colors.blue,
                  ontap: () {},
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height*0.02),
                customSelectButton(
                  btnText: "Delete",
                  borderColor: Colors.red,
                  behindIcon: Icons.delete_outline,
                  btnheight: 35,

                  iconColor: Colors.red,
                  btnTextColor: Colors.red,
                  ontap: () {
                    CustomBottomSheet(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
