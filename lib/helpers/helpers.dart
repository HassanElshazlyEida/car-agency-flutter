
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/route_manager.dart';

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
  static AlertDialog errorDialog({required BuildContext context, required String message}){
    return AlertDialog(
      content: Text(message,style: const  TextStyle(color: Colors.white)),
      backgroundColor: Colors.red,
      actions: [
        TextButton(onPressed: () {
          Navigator.pop(context);
        }, child: const Center(child:  Text('OK')))
      ],
    );
  }
  static SnackbarController errorSnackbar({required BuildContext context, required String message}){
    return Get.snackbar('Failed', message, duration : const Duration(seconds: 5),backgroundColor: const Color.fromARGB(255, 218, 77, 77));
  }
  static String? usersServiceApi(){
    return dotenv.env['USERS_SERVICE_API'];
  }
  static String? carsServiceApi(){
    return dotenv.env['CARS_SERVICE_API'];
  }
}