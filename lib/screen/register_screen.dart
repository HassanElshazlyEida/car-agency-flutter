import 'package:car_agency_flutter/helpers/helpers.dart';
import 'package:flutter/material.dart';


class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmedPasswordController = TextEditingController();

    final formKey = GlobalKey<FormState>();

    return  Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Helpers.formField(controller: nameController, label: 'Name', hint : 'Enter your name'),
                const SizedBox(height: 16.0,),
                Helpers.formField(controller: emailController, label: 'Email', hint : 'Enter your email'),
                const SizedBox(height: 16.0,),
                Helpers.formField(controller: phoneController, label: 'Phone', hint : 'Enter your phone'),
                const SizedBox(height: 16.0,),
                Helpers.formField(controller: passwordController, label: 'Password',hint  : 'Enter your password', isPassword: true),
                const SizedBox(height: 16.0,),
                Helpers.formField(controller: confirmedPasswordController, label: 'Confirm Password',hint  : 'Enter your password again', isPassword: true),
                const SizedBox(height: 16.0,),
                MaterialButton(
                  onPressed: (){
                    
                  },
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  minWidth: double.infinity,
                  color: const Color(0xff2d4569),
                  child: const  Text("Register",style:  TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
                ),
              ],
            ),
          ),
        )
      );
    }
}
