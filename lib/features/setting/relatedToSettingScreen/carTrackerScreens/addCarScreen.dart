
import 'package:car_tracking/presentation/widgets/CustomBtn.dart';
import 'package:car_tracking/presentation/widgets/CustomDropDownList.dart';
import 'package:car_tracking/presentation/widgets/CustomTextFormField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class addCarPage extends StatefulWidget {
  @override
  State<addCarPage> createState() => _addCarPageState();
}

class _addCarPageState extends State<addCarPage> {
  final _formKey = GlobalKey<FormState>();

  String? selectedCarType;
  String? selectedBranch;
  String? selectedCarState;

  List<String> carTypes = [];
  List<String> branches = [];
  List<String> carStates = [];

  TextEditingController carNameController = TextEditingController();
  TextEditingController plateController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  void _loadStaticData() {
    carTypes = ['Sedan', 'SUV', 'Truck'];         // بيانات ثابتة مؤقتًا
    branches = ['Cairo', 'Alex', 'Giza'];         // بيانات الفروع
    carStates = ['New', 'Used', 'Damaged'];       // حالة العربية
  }
  @override
  void initState() {
    super.initState();
    _loadStaticData();
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


        body: Stack(
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
                          CustomTextField(controller: carNameController, hintText: 'Car name'),
                          // CustomDropdown(
                          //   hint: 'Car type',
                          //   value: selectedCarType,
                          //   items: carTypes,
                          //   onChanged: (val) => setState(() => selectedCarType = val),
                          // ),
                          // CustomTextField(controller: plateController, hintText: 'Blate'),
                          // CustomDropdown(
                          //   hint: 'Branch',
                          //   value: selectedBranch,
                          //   items: branches,
                          //   onChanged: (val) => setState(() => selectedBranch = val),
                          // ),
                          // CustomDropdown(
                          //   hint: 'Car state',
                          //   value: selectedCarState,
                          //   items: carStates,
                          //   onChanged: (val) => setState(() => selectedCarState = val),
                          // ),
                          CustomTextField(
                            controller: notesController,
                            hintText: 'Notes',
                            maxLines: 4,
                          ),
                          SizedBox(height: 20),

                          Padding(
                            padding:  EdgeInsets.only(top: 60),
                            child: CustomButton(
                              backGroundColor:const Color(0xff167AD8),
                              child:  Text("Save", style: TextStyle(color: Colors.white,fontSize: 18)),
                              onPressed:  ()  {
                          //      context.push("/addCar");
                                // AuthCubit.get(context).Login(
                                //   email: Phonecontroller.text,
                                //   pass: passcontroller.text,
                                // );
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
      padding: const EdgeInsets.symmetric(vertical:4),
      child: Card(
        color: Colors.white.withOpacity(0.9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 1,
        child: ListTile(
          leading: Image.asset(imagePath),
          title: Text(title,style: TextStyle(color: Color(0xff167AD8)),),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            // Handle navigation or action
          },
        ),
      ),
    );
  }
}
