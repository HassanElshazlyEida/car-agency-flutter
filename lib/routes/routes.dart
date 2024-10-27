
import 'package:car_agency_flutter/middleware/auth_middleware.dart';
import 'package:car_agency_flutter/middleware/guest_middleware.dart';
import 'package:car_agency_flutter/models/car_model.dart';
import 'package:car_agency_flutter/modules/auth/auth_bloc/auth_cubit.dart';
import 'package:car_agency_flutter/modules/car/car_bloc/car_cubit.dart';
import 'package:car_agency_flutter/modules/layout/layout_bloc/layout_cubit.dart';
import 'package:car_agency_flutter/modules/layout/layout_screen.dart';
import 'package:car_agency_flutter/screen/cars/car_detail_screen.dart';
import 'package:car_agency_flutter/screen/cars/car_mode_enum.dart';
import 'package:car_agency_flutter/screen/cars/create_car_screen.dart';
import 'package:car_agency_flutter/screen/login_screen.dart';
import 'package:car_agency_flutter/screen/register_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class Routes {
  static const home = '/home';
  static const login = '/login';
  static const register = '/register';
  static const createCar = '/create-car';
  static const carDetails = '/car-details';
  
}

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.home,
      page: ()  => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthCubit()..loadUserData()), 
          BlocProvider(create: (context) => LayoutCubit()..loadCarsData()), 
        ],
        child: const LayoutScreen(), 
      ),
      middlewares: [
        AuthMiddleware()
      ]
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginScreen(),
        middlewares: [
        GuestMiddleware()
      ],
      
    ),
    GetPage(
      name: Routes.register,
      page: () => const RegisterScreen(),
  
    ),
     GetPage(
      name: Routes.createCar,
      page: ()  => BlocProvider(
        create: (context) => CarCubit(),
        child: const CreateCarScreen(),
      ),
      middlewares: [
        AuthMiddleware()
      ]
    ),
      GetPage(
      name: Routes.carDetails,
      page: () {
        final CarModel model = Get.arguments['model'];
        final CarModeEnum mode = Get.arguments['mode'];
        print(mode);
        print(model.name);
        return BlocProvider(
          create: (context) => CarCubit(), 
          child:   CarDetailScreen(model: model,mode: mode),
        );
      },
      middlewares: [
        AuthMiddleware()
      ]
    ),
  ];
}