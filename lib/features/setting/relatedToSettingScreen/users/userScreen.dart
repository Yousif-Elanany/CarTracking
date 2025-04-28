import 'package:car_tracking/features/auth/data/Models/userModel.dart';
import 'package:car_tracking/features/setting/business_logic/setting_cubit.dart';
import 'package:car_tracking/features/setting/business_logic/setting_states.dart';
import 'package:car_tracking/features/setting/data/Models/userModel.dart';
import 'package:car_tracking/features/setting/widgets/addUserBottomSheet.dart';
import 'package:car_tracking/features/setting/widgets/userCardWidget.dart';
import 'package:car_tracking/presentation/widgets/CustomBtn.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class usersPage extends StatefulWidget {
  @override
  State<usersPage> createState() => _usersPageState();
}

class _usersPageState extends State<usersPage> {
  List<UsersModel> UsersList = [];

  @override
  void initState() {
    super.initState();
    UsersList = BlocProvider.of<settingCubit>(context).getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<settingCubit, settingState>(
          listener: (context, state) {
            if (state is GetUsersSuccess) {
              UsersList = state.model;
            }
            if (state is AddUserSuccess) {
              BlocProvider.of<settingCubit>(context).getUsers();
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                // الجزء العلوي (خلفية أو عناصر أخرى)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 200,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/base.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 20,
                          left: 0,
                          right: 60,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Image.asset(
                                      "assets/images/arrow.png",
                                      width: 50,
                                      height: 50,
                                    ),
                                  ),
                                ),
                                const Text(
                                  'Users',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Container()
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // الجزء السفلي مع البيانات
                Positioned(
                  top: 110,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xffF5F5F5),
                          spreadRadius: 2,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.68,
                              child: ListView.separated(
                                padding: EdgeInsets.all(4),
                                itemCount: UsersList.length,
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: 24),
                                itemBuilder: (context, index) {
                                  return userCardWidget(Model: UsersList[index],);
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: CustomButton(
                                backGroundColor: const Color(0xff167AD8),
                                child: Text("+ Add User",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18)),
                                onPressed: () async {
                                  //     context.push("/addCar");
                                  CustomAddUserBottomSheet(context);
                                  // AuthCubit.get(context).Login(
                                  //   email: Phonecontroller.text,
                                  //   pass: passcontroller.text,
                                  // );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
