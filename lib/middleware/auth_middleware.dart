import 'package:car_agency_flutter/modules/auth/user_repository.dart';
import 'package:car_agency_flutter/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (!UserRepository.isAuthenticated()) {
      return const RouteSettings(name: Routes.login);
    }
    return null;
  }
}