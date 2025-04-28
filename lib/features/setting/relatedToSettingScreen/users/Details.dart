import 'package:car_tracking/presentation/widgets/CustomTextFormField.dart';
import 'package:car_tracking/presentation/widgets/simpleactivewidget.dart';
import 'package:flutter/material.dart';

class userDetail extends StatefulWidget {
  const userDetail({super.key});

  @override
  State<userDetail> createState() => _userDetailState();
}

class _userDetailState extends State<userDetail> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  bool isActive = true;
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            CustomTextField(
              controller: nameController,
              hintText: 'Name',
            ),
            const SizedBox(height: 6),
            CustomTextField(
              controller: emailController,
              hintText: 'Email',
            ),
            const SizedBox(height: 6),
            CustomTextField(
              controller: phoneController,
              hintText: 'Phone',
            ),
            const SizedBox(height: 6),
            CustomTextField(
              controller: passwordController,
              hintText: 'Password',
            ),
            UserActivationSwitch(
              rightText: "User activation",
              isEnabled: true,
              isActivated: isActive,
              onChanged: (value) {
                setState(() {
                  isActive = value;
                //  if (value) isAdmin = false;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
