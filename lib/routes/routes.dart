
import 'package:car_agency_flutter/middleware/auth_middleware.dart';
import 'package:car_agency_flutter/modules/layout/layout_bloc/layout_cubit.dart';
import 'package:car_agency_flutter/modules/layout/layout_screen.dart';
import 'package:car_agency_flutter/screen/login_screen.dart';
import 'package:car_agency_flutter/screen/register_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class Routes {
  static const home = '/home';
  static const login = '/login';
  static const register = '/register';
  
}

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.home,
      page: ()  => BlocProvider(
        create: (context) => LayoutCubit()..loadCarsData(),
        child: const LayoutScreen(),
      ),
      middlewares: [
        AuthMiddleware()
      ]
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginScreen(),
      
    ),
    GetPage(
      name: Routes.register,
      page: () => const RegisterScreen(),
  
    ),
  ];
}