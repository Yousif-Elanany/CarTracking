import 'package:car_tracking/features/setting/business_logic/setting_cubit.dart';
import 'package:car_tracking/features/setting/business_logic/setting_states.dart';
import 'package:car_tracking/features/setting/data/Models/BranchModel.dart';
import 'package:car_tracking/features/setting/data/Models/carStatus.dart';
import 'package:car_tracking/features/setting/data/Models/carTypeModel.dart';
import 'package:car_tracking/presentation/widgets/CustomBtn.dart';
import 'package:car_tracking/presentation/widgets/CustomDropDownList.dart';
import 'package:car_tracking/presentation/widgets/CustomTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class addCarPage extends StatefulWidget {
  @override
  State<addCarPage> createState() => _addCarPageState();
}

class _addCarPageState extends State<addCarPage> {
  final _formKey = GlobalKey<FormState>();

  CarTypeModel? selectedType;
  BranchModel? selectedBranch;
  CarStatusModel? selectedState;

  String? selectedStateId;
  String? selectedTypeId;
  String? selectedBranchId;

  List<CarTypeModel> carTypes = [];
  List<BranchModel> branches = [];
  List<CarStatusModel> carStates = [];
  TextEditingController carNameController = TextEditingController();
  TextEditingController plateController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    carTypes = BlocProvider.of<settingCubit>(context).getCarTypes();
    branches = BlocProvider.of<settingCubit>(context).getBranches();
    carStates = BlocProvider.of<settingCubit>(context).getCarStatus();
  }

  // void _loadDropdownData() async {
  //  // final service = CarDataService();
  //   final types = await service.fetchCarTypes();
  //   final brs = await service.fetchBranches();
  //   final states = await service.fetchCarStates();
  //   setState(() {
  //     carTypes = types;
  //     branches = brs;
  //     carStates = states;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<settingCubit, settingState>(
          listener: (context, state) {
            if(state is AddCarSuccess){

              Navigator.pop(context);
            }
            if (state is GetBranchesSuccess) {
              branches = state.model;
            }
            if (state is carStatusSuccess) {
              carStates = state.model;
            }
            if (state is carTypeSuccess) {
              carTypes = state.model;
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
                                  'Car tracker',
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
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  CustomTextField(
                                      controller: carNameController,
                                      hintText: 'Car name'),
                                  SizedBox(
                                    height: MediaQuery.sizeOf(context).height *
                                        0.01,
                                  ),
                                  CustomDropdown<CarTypeModel>(
                                    hint: 'Type',
                                    value: selectedType,
                                    items: carTypes,
                                    itemAsString: (CarTypeModel item) =>
                                        item.carTypeName,
                                    onChanged: (val) => setState(() {
                                      selectedType = val;
                                      selectedTypeId = selectedType?.id;
                                      print(selectedTypeId);
                                    }),
                                  ),

                                  SizedBox(
                                    height: MediaQuery.sizeOf(context).height *
                                        0.01,
                                  ),

                                  CustomTextField(
                                      controller: plateController,
                                      hintText: 'Blate'),
                                  SizedBox(
                                    height: MediaQuery.sizeOf(context).height *
                                        0.01,
                                  ),

                                  CustomDropdown<BranchModel>(
                                    hint: 'Branch',
                                    value: selectedBranch,
                                    items: branches,
                                    itemAsString: (BranchModel item) =>
                                        item.branchName,
                                    onChanged: (val) => setState(() {
                                      selectedBranch = val;
                                      selectedTypeId = selectedBranch?.id;
                                      print(selectedTypeId);
                                    }),
                                  ),

                                  SizedBox(
                                    height: MediaQuery.sizeOf(context).height *
                                        0.01,
                                  ),

                                  CustomDropdown<CarStatusModel>(
                                    hint: 'State',
                                    value: selectedState,
                                    items: carStates,
                                    itemAsString: (CarStatusModel item) =>
                                        item.carStatusName,
                                    onChanged: (dynamic val) => setState(() {
                                      selectedState = val;
                                      selectedStateId = selectedState?.id;
                                      print(selectedStateId);
                                    }),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.sizeOf(context).height *
                                        0.01,
                                  ),

                                  CustomTextField(
                                    controller: notesController,
                                    hintText: 'Notes',
                                    maxLines: 4,
                                  ),
                                  SizedBox(
                                    height: MediaQuery.sizeOf(context).height *
                                        0.01,
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(top: 60),
                                    child: CustomButton(
                                      backGroundColor: const Color(0xff167AD8),
                                      child: const Text("Save",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18)),
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          await BlocProvider.of<settingCubit>(
                                                  context)
                                              .addCar(
                                            carNameController.text,
                                            plateController.text,
                                            selectedTypeId.toString(),
                                            selectedBranchId.toString(),
                                            selectedStateId.toString(),
                                            notesController.text,
                                          );

                                          Navigator.pop(
                                              context); // يقفل الشييت بعد الفلترة
                                        }
                                      },
                                    ),
                                  ),

                                  // ElevatedButton(
                                  //   onPressed: () {
                                  //     if (_formKey.currentState!.validate()) {
                                  //       print('Saving data...');
                                  //     }
                                  //   },
                                  //   child: Text('Save'),
                                  // )
                                ],
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

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16,
          color: Color(0xff6C6C89),
        ),
      ),
    );
  }

  Widget buildOption(String title, String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Card(
        color: Colors.white.withOpacity(0.9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 1,
        child: ListTile(
          leading: Image.asset(imagePath),
          title: Text(
            title,
            style: TextStyle(color: Color(0xff167AD8)),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            // Handle navigation or action
          },
        ),
      ),
    );
  }
}
