import 'package:car_agency_flutter/helpers/helpers.dart';
import 'package:car_agency_flutter/screen/register_screen.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailOrPasswordController = TextEditingController();
    final passwordController = TextEditingController();

    final formKey = GlobalKey<FormState>();

    return  Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Center(child:  Text('Login',style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold),)),
                    Helpers.formField(controller: emailOrPasswordController, label: 'Email or Phone', hint : 'Enter your email or phone'),
                    const SizedBox(height: 16.0,),
                    Helpers.formField(controller: passwordController, label: 'Email', hint : 'Enter your email'),
                    const SizedBox(height: 16.0,),
                    MaterialButton(
                      onPressed: () {
                        
                      },
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(4.0)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0),
                      minWidth: double.infinity,
                      color: const Color(0xff2d4569),
                      child: const Text(
                        'Login',
                        style:  TextStyle(
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
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const  RegisterScreen()));
                          },
                          child: const Text('Create one',style: TextStyle(color: Color(0xff2d4569),fontWeight: FontWeight.bold)),
                        )
                      ],
                    )
                  ],
                ),
          ),
      ));
  }
}
