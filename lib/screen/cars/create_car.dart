import 'package:car_agency_flutter/helpers/helpers.dart';
import 'package:car_agency_flutter/models/car_model.dart';
import 'package:car_agency_flutter/modules/car/car_bloc/car_cubit.dart';
import 'package:car_agency_flutter/modules/car/car_bloc/car_states.dart';
import 'package:car_agency_flutter/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateCarScreen extends StatefulWidget {
  const CreateCarScreen({super.key});

  @override
  State<CreateCarScreen> createState() => _CreateCarScreenState();

}

class _CreateCarScreenState extends State<CreateCarScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final modelController = TextEditingController();
  final priceController = TextEditingController();

 

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CarCubit>(context);

    return  BlocConsumer<CarCubit,CarStates>(
      listener: (context, state) {
        if (state is CarCreationErrorState) {
          Helpers.errorSnackbar(context: context,message: state.message);
        }else if (state is CarCreatedState) {
          Get.offNamed(Routes.home);
        }
      },
      builder: (context, state) {
        if( state is CarCreationLoadingState){
          return const Scaffold(
            body:  Center(child: CircularProgressIndicator())
          );
        }
        return  Scaffold(
      appBar: AppBar(
        title: const Text('Create Car'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Helpers.formField(controller: nameController, hint: 'Name'),
              const SizedBox(height: 10,),
              Helpers.formField(controller: modelController, hint: 'Model'),
              const SizedBox(height: 10,),
              TextFormField(
                controller: priceController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your price';
                  }
                  if (!RegExp(r'^\d+$').hasMatch(value)) {
                    return 'Please enter a valid numeric price';
                  }
                  return null;
                },
                decoration: const  InputDecoration(
                  border:  OutlineInputBorder(),
                  hintText: 'Price',
                ),
              ),
              const SizedBox(height: 40,),
              MaterialButton(
                onPressed: (){
                    if (_formKey.currentState!.validate()) {
                      cubit.createNewCar(
                        CarModel.fromJson({
                            'name': nameController.text,
                            'model': modelController.text,
                            'price': int.tryParse(priceController.text),
                          })
                      );
                  }
                },
                textColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                minWidth: double.infinity,
                color: const Color(0xff2d4569),
                child: const  Text("Create Car",style:  TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
              ),
            ],
          ),
        ),
      ),
      );
      }
    );
  }
}