
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Helpers {

  static TextFormField formField({required TextEditingController controller, required String hint, String? label, bool? isPassword}){
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your ${label ?? hint}';
        }
        return null;
      },
      obscureText: isPassword ?? false,
      decoration:  InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
        hintText: hint,
      ),
    );
  }

  static String? usersServiceApi(){
    return dotenv.env['USERS_SERVICE_API'];
  }
  static String? carsServiceApi(){
    return dotenv.env['CARS_SERVICE_API'];
  }
}