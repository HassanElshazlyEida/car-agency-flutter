
import 'package:car_agency_flutter/modules/auth/auth_bloc/auth_cubit.dart';
import 'package:car_agency_flutter/modules/auth/auth_bloc/auth_states.dart';
import 'package:car_agency_flutter/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return   BlocConsumer<AuthCubit,AuthStates >(
        listener: (context, state) {
         if (state is ErrorUserDataState) {
            Get.toNamed(Routes.home);
            Get.snackbar('Error', state.message);
         }
        },
        builder: (context, state) {
          if(state is LoadingUserDataState) {
            return const Scaffold(
              body:  Center(child: CircularProgressIndicator())
            );
          }
          final cubit = BlocProvider.of<AuthCubit>(context); 
    
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset('images/user.png', height: 75, width: 75)),
                  const SizedBox(height: 16.0,),
                  Text('${cubit.userModel?.name}',style: const TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold),),
                  Padding(
                     padding: const EdgeInsets.only(left:20,top: 20,right: 10),
                      child: Column(children: [
                    const SizedBox(height: 60.0,),
                    TextFormField(
                      decoration: const  InputDecoration(
                        labelText: 'Name',
                        labelStyle:  TextStyle(color: Colors.pink),
                      ),
                      initialValue: cubit.userModel?.name,
                      readOnly: true,
                    ),
                    const SizedBox(height: 16.0,),
                    TextFormField(
                      decoration:  const InputDecoration(
                        labelText: 'Email' ,
                        labelStyle: TextStyle(color: Colors.pink),
                      ),
                      initialValue: cubit.userModel?.email,
                      readOnly: true,
                    ),
                    const SizedBox(height: 16.0,),
                    TextFormField(
                      decoration:  const InputDecoration(
                        labelText: 'Phone',
                        labelStyle:  TextStyle(color: Colors.pink),
                      ),
                      initialValue: cubit.userModel?.phone,
                      readOnly: true,
                    ),
                        ],
                      )
                  )
                
                  
      
                ],
              ),
            ),
          );
        },
    );
  }
}