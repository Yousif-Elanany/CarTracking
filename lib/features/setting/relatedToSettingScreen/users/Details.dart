import 'package:car_tracking/presentation/widgets/CustomTextFormField.dart';
import 'package:car_tracking/presentation/widgets/simpleactivewidget.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:car_tracking/presentation/widgets/CustomTextFormField.dart';
import 'package:car_tracking/presentation/widgets/simpleactivewidget.dart';

class UserDetail extends StatefulWidget {
  const UserDetail({super.key});

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isActive = true;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      body: Padding(
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
      ),
    );
  }
}
