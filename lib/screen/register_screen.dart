import 'package:car_agency_flutter/helpers/helpers.dart';
import 'package:car_agency_flutter/modules/auth/auth_bloc/auth_cubit.dart';
import 'package:car_agency_flutter/modules/auth/auth_bloc/auth_states.dart';
import 'package:car_agency_flutter/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';


class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final passwordController = TextEditingController();
    final passwordConfirmationController = TextEditingController();

    final formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit,AuthStates>(
        listener: (context, state) {
          if (state is AuthErrorState) {
            Helpers.errorSnackbar(message: state.message);
          }else if (state is AuthAuthenticatedState) {
            Get.offNamed(Routes.home);
          }
        },
        builder: (context, state) {
          if( state is AuthLoadingState){
            return const Scaffold(
              body:  Center(child: CircularProgressIndicator())
            );
          }
          return Scaffold(
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
                  Helpers.formField(controller: passwordConfirmationController, label: 'Confirm Password',hint  : 'Enter your password again', isPassword: true),
                  const SizedBox(height: 16.0,),
                  MaterialButton(
                    onPressed: (){
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<AuthCubit>(context).register(
                          name: nameController.text,
                          phone: phoneController.text,
                          email: emailController.text,
                          password: passwordController.text,
                          passwordConfirmation: passwordConfirmationController.text,
                        );
                      }
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
    ));
  }
}
