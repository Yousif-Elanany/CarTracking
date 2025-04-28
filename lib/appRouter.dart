import 'package:car_tracking/features/Maps/MapPage.dart';
import 'package:car_tracking/features/auth/business_logic/auth_cubit.dart';
import 'package:car_tracking/features/auth/data/web_services/AuthApiService.dart';
import 'package:car_tracking/features/auth/presentation/screens/login.dart';
import 'package:car_tracking/features/dashboard/business_logic/dashBoard_cubit.dart';
import 'package:car_tracking/features/dashboard/data/Models/carTrackerModel.dart';
import 'package:car_tracking/features/dashboard/data/repos/dashBoardRepo.dart';
import 'package:car_tracking/features/dashboard/data/web_ervices/dashBoardApiServices.dart';
import 'package:car_tracking/features/dashboard/presentation/dashboardScreen.dart';
import 'package:car_tracking/features/fleetManagement/business_logic/fleetManagment_cubit.dart';
import 'package:car_tracking/features/fleetManagement/data/repos/fleetManagmentRepo.dart';
import 'package:car_tracking/features/fleetManagement/data/web_services/fleetManagementApi.dart';

import 'package:car_tracking/features/fleetManagement/presentation/FleetScreen.dart';
import 'package:car_tracking/features/fleetManagement/presentation/carDetailsScreen.dart';
import 'package:car_tracking/features/setting/business_logic/setting_cubit.dart';
import 'package:car_tracking/features/setting/data/repos/settingsRepo.dart';
import 'package:car_tracking/features/setting/data/web_Servirces/settingApi.dart';
import 'package:car_tracking/features/setting/relatedToSettingScreen/branches/branchScreen.dart';
import 'package:car_tracking/features/setting/relatedToSettingScreen/carTrackerScreens/carTrackerScreen.dart';
import 'package:car_tracking/presentation/screens/baseScreen/MainScreen.dart';
import 'package:car_tracking/presentation/screens/MapScreen/mapview.dart';
import 'package:car_tracking/features/setting/presentation/settingScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'features/auth/data/repos/authRepo.dart';

import 'features/setting/relatedToSettingScreen/CityPage/cityScreen.dart';
import 'features/setting/relatedToSettingScreen/carStatus/carStatusScreen.dart';
import 'features/setting/relatedToSettingScreen/carTrackerScreens/addCarScreen.dart';
import 'features/setting/relatedToSettingScreen/carType/carTypeScreen.dart';
import 'features/setting/relatedToSettingScreen/regions/regionScreen.dart';
import 'features/setting/relatedToSettingScreen/users/userScreen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/login',
      builder: (context, state) {
        final authRepo = AuthRepository(AuthApiService());
        return BlocProvider(
          create: (context) => AuthCubit(authRepo),
          child: LoginScreen(),
        );
      },
    ),
    ShellRoute(
      builder: (context, state, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => dashBoardCubit(
                DashboardRepository(dashBoardApiService()),
              ),
            ),
            BlocProvider(
              create: (_) => fleetManagmentCubit(
                fleetManagmentRepository(
                  fleetManagmentApiService(),
                ),
              ),
            ),
            BlocProvider(
              create: (_) => settingCubit(
                SettingRepository(
                  SettingsApiService(),
                ),
              ), // Settings
            ),
          ],
          child: MainScreen(child: child), // تمرير الـ child إلى MainScreen
        );
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => DashboardPage(),
        ),
        GoRoute(
          path: '/fleet',
          builder: (context, state) => fleetManagementScreen(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => settingPage(),
        ),
      ],
    ),
    GoRoute(
      path: '/map',
      builder: (context, state) {
        final cars = state.extra as List<CarTrackerModel>;
        return MapPage(cars: cars);
      },
    ),
    GoRoute(
        path: '/cardetailsScreen',
        builder: (context, state) {
          final fleetRepo =
              fleetManagmentRepository(fleetManagmentApiService());
          String carId = state.extra as String;
          return BlocProvider(
            create: (_) => fleetManagmentCubit(fleetRepo),
            child: cardetailsScreen(
              carId: carId,
            ),
          );
        }),
    GoRoute(
      path: '/carTracker',
      builder: (context, state) => carTrackerScreenPage(),
    ),
    GoRoute(
      path: '/addCar',
      builder: (context, state) => addCarPage(),
    ),
    GoRoute(
      path: '/carStatusPage',
      builder: (context, state) => BlocProvider(
          create: (_) => settingCubit(SettingRepository(
                SettingsApiService(),
              )),
          child: carStatusPage()),
    ),
    GoRoute(
        path: '/carTypePage',
        builder: (context, state) => BlocProvider(
              create: (_) => settingCubit(SettingRepository(
                SettingsApiService(),
              )),
              child: carTypePage(),
            )),
    GoRoute(
      path: '/cityPage',
      builder: (context, state) => BlocProvider(
          create: (_) => settingCubit(SettingRepository(
                SettingsApiService(),
              )),
          child: cityPage()),
    ),
    GoRoute(
      path: '/branchPage',
      builder: (context, state) => BlocProvider(
          create: (_) => settingCubit(SettingRepository(
                SettingsApiService(),
              )),
          child: branchPage()),
    ),
    GoRoute(
      path: '/regionPage',
      builder: (context, state) => BlocProvider(
          create: (_) => settingCubit(SettingRepository(
                SettingsApiService(),
              )),
          child: regionPage()),
    ),
    GoRoute(
      path: '/usersPage',
      builder: (context, state) => BlocProvider(
          create: (_) => settingCubit(SettingRepository(
                SettingsApiService(),
              )),
          child: usersPage()),
    ),
  ],
  errorBuilder: (context, state) => const Scaffold(
    body: Center(child: Text('الصفحة غير موجودة')),
  ),
);
