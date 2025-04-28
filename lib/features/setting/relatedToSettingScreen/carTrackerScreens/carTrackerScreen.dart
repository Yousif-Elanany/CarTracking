
import 'package:car_tracking/features/setting/widgets/carTrackerWidget.dart';
import 'package:car_tracking/presentation/widgets/CustomBtn.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class carTrackerScreenPage extends StatefulWidget {
  @override
  State<carTrackerScreenPage> createState() => _carTrackerScreenPageState();
}

class _carTrackerScreenPageState extends State<carTrackerScreenPage> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> carsList = [
      {
        'name': 'Avanza',
        'type': 'Riyadh',
        'plate': 'ت ف ع - 1362',
        'branch': 'Main Branch',
        'speed': '46.5',
      },
      {
        'name': 'Camry',
        'type': 'Jeddah',
        'plate': 'ن م ب - 4821',
        'branch': 'West Branch',
        'speed': '52.0',
      },
      {
        'name': 'Hilux',
        'type': 'Dammam',
        'plate': 'س ج ر - 9432',
        'branch': 'East Branch',
        'speed': '40.2',
      },
    ];
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
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.68,
                          child: ListView.separated(
                            padding: EdgeInsets.all(4),
                            itemCount: carsList.length,
                            separatorBuilder: (context, index) => SizedBox(height: 24),
                            itemBuilder: (context, index) {
                              return CarTrackerCardWidget(carData: carsList[index]);
                            },
                          ),
                        ),
      
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: CustomButton(
                            backGroundColor:const Color(0xff167AD8),
                            child:  Text("+ Add Car", style: TextStyle(color: Colors.white,fontSize: 18)),
                            onPressed:  () async {
      context.push("/addCar");


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
