import 'package:car_agency_flutter/modules/auth/user_repository.dart';
import 'package:car_agency_flutter/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuestMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    print("redirect -----------");
    if (UserRepository.isAuthenticated()) {
      return const RouteSettings(name: Routes.home);
    }
    return null;
  }
}