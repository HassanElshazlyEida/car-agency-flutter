import 'package:car_agency_flutter/helpers/helpers.dart';
import 'package:car_agency_flutter/modules/auth/auth_bloc/auth_cubit.dart';
import 'package:car_agency_flutter/modules/auth/auth_bloc/auth_states.dart';
import 'package:car_agency_flutter/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailOrPasswordController = TextEditingController();
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

      return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is AuthErrorState) {
          // showDialog(
          //     context: context,
          //     builder: (context) => Helpers.errorDialog(context: context, message: state.message)
          // );
          Helpers.errorSnackbar(message: state.message);
        }else if (state is AuthAuthenticatedState) {
          Get.offNamed(Routes.home);
        }
      },
      builder: (context, state) {
        return BlocBuilder<AuthCubit, AuthStates>(
          builder: (context, state) {
            if( state is AuthLoadingState){
              return const Scaffold(
                body:  Center(child: CircularProgressIndicator())
              );
            }
            return   Scaffold(
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(child: 
                            Image.asset('images/bg.png', height: 100, width: 100),
                          ),
                          const SizedBox(height: 16.0,),
                          Helpers.formField(controller: emailOrPasswordController, label: 'Email or Phone', hint : 'Enter your email or phone'),
                          const SizedBox(height: 16.0,),
                          Helpers.formField(controller: passwordController, label: 'Password', hint : 'Enter your password',isPassword: true),
                          const SizedBox(height: 16.0,),
                          MaterialButton(
                            onPressed: () {
                               if (formKey.currentState!.validate()) {
                                  BlocProvider.of<AuthCubit>(context).login(
                                    login: emailOrPasswordController.text,
                                    password: passwordController.text,
                                  );
                                }
                            },
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(4.0)),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.0),
                            minWidth: double.infinity,
                            color: const Color(0xff2d4569),
                            child: Text(
                                state is AuthLoadingState
                                    ? "Loading ..."
                                    : "Login",
                              style: const  TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 15,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                            [
                              const Text('Don\'t have an account? ',style: TextStyle(color: Colors.black)),
                              const  SizedBox(width: 4,),
                              InkWell(
                                onTap: ()
                                {
                                  Get.toNamed(Routes.register);
                                },
                                child: const Text('Create one',style: TextStyle(color: Color(0xff2d4569),fontWeight: FontWeight.bold)),
                              )
                            ],
                          )
                        ],
                      ),
                )
           ));
        });
    });
  }
}
