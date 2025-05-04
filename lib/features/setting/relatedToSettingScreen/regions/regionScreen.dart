import 'package:car_tracking/features/setting/business_logic/setting_cubit.dart';
import 'package:car_tracking/features/setting/business_logic/setting_states.dart';
import 'package:car_tracking/features/setting/data/Models/regionModel.dart';
import 'package:car_tracking/features/setting/widgets/customAddRegionBottomSheet.dart';
import 'package:car_tracking/features/setting/widgets/regionCardWidget.dart';
import 'package:car_tracking/presentation/widgets/CustomBtn.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class regionPage extends StatefulWidget {
  @override
  State<regionPage> createState() => _regionPageState();
}

class _regionPageState extends State<regionPage> {
  List<RegionModel> regionsList = [];

  @override
  void initState() {
    super.initState();
    regionsList = BlocProvider.of<settingCubit>(context).getRegions();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<settingCubit, settingState>(
          listener: (context, state) {
            if (state is GetRegionsSuccess) {
              regionsList = state.model;
            }
            if (state is AddRegionSuccess) {
              BlocProvider.of<settingCubit>(context).getRegions();
            }
            if (state is deleteRegionSuccess) {
              BlocProvider.of<settingCubit>(context).getRegions();
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
                                  'Regions',
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
                                itemCount: regionsList.length,
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: 24),
                                itemBuilder: (context, index) {
                                  return regionCardWidget(
                                      Model: regionsList[index]);
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: CustomButton(
                                backGroundColor: const Color(0xff167AD8),
                                child: Text("+ Add Region",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18)),
                                onPressed: () async {
                                  //     context.push("/addCar");
                                  CustomAddRefionBottomSheet(context);
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
