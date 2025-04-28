import 'package:car_tracking/core/network_Local/cache_helper.dart';
import 'package:car_tracking/core/network_Local/dio_Helper.dart';
import 'package:flutter/material.dart';

import 'appRouter.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
 await DioHelper.init();
  await CacheHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );


  }
}
