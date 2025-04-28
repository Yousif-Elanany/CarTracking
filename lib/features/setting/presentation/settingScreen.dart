import 'package:car_tracking/presentation/widgets/SmallBox.dart';
import 'package:car_tracking/features/dashboard/widgets/chart.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class settingPage extends StatelessWidget {
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
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/base.png'), // مسار الصورة
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    // ListTile في الأعلى
                    Positioned(
                        top: 20,
                        left: 16,
                        right: 16,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: AssetImage(
                                        'assets/images/person.png'), // غيّر المسار حسب صورتك
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Hello,',
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        'Abobakr Sobhy',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.05),
                                border: Border.all(color: Colors.white10),
                              ),
                              padding: EdgeInsets.all(10),
                              child: Icon(
                                Icons.notifications,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ],
                        )),
      
                    // النص الرئيسي
                  ],
                ),
              ),
            ),
      
            // الجزء السفلي مع البيانات
            Positioned(
              top: 130,
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
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          sectionTitle("Tracking devices:"),
                          buildOption("Car Tracker", "assets/images/vectorCar.png",ontap: (){
                            context.push('/carTracker');
                          }),
                          buildOption("Car Status", "assets/images/vectorCar.png",ontap: (){
                            context.push('/carStatusPage');
      
      
                          }),
                          buildOption("Car Type", "assets/images/vectorCar.png",ontap: (){
                            context.push('/carTypePage');
      
                          }),
                          const SizedBox(height: 10),
                          sectionTitle("Location:"),
                          buildOption("City", "assets/images/vectorLocation.png",ontap:(){
                context.push('/cityPage');
      
                }),
                          buildOption("Branches", "assets/images/vectorLocation.png",ontap: (){
      
                            context.push("/branchPage");
                          }),
                          buildOption("Regions", "assets/images/vectorLocation.png",ontap: (){
      
                            context.push("/regionPage");
                          }),
                          const SizedBox(height: 10),
                          sectionTitle("Users:"),
                          buildOption("Users", "assets/images/vectorUser.png",ontap: (){
      
                            context.push("/usersPage");
                          }),
                          // buildOption("Admins", "assets/images/vectorUser.png"),
                          // buildOption("Permissions", "assets/images/vectorUser.png"),
                        ],
                      ),
                    ],
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

  Widget buildOption(String title, String imagePath,  {Function()? ontap}
  ) {
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
          onTap: ontap
        ),
      ),
    );
  }
}
