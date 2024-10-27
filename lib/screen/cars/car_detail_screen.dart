import 'package:car_agency_flutter/helpers/helpers.dart';
import 'package:car_agency_flutter/modules/car/car_bloc/car_cubit.dart';
import 'package:car_agency_flutter/modules/car/car_bloc/car_states.dart';
import 'package:car_agency_flutter/routes/routes.dart';
import 'package:car_agency_flutter/screen/cars/car_mode_enum.dart';
import 'package:flutter/material.dart';
import 'package:car_agency_flutter/models/car_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class CarDetailScreen extends StatefulWidget {
  final CarModel model;
  CarModeEnum mode;

  CarDetailScreen({
    super.key,
    required this.model,
    this.mode = CarModeEnum.view,
  });

  @override
  State<CarDetailScreen> createState() => _CarDetailScreenState();
}

class _CarDetailScreenState extends State<CarDetailScreen> {
  bool get isEditMode => widget.mode == CarModeEnum.edit;
  late final TextEditingController nameController;
  late final TextEditingController modelController;
  late final TextEditingController priceController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.model.name);
    modelController = TextEditingController(text: widget.model.model);
    priceController = TextEditingController(text: widget.model.price.toString());
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final cubit = BlocProvider.of<CarCubit>(context);
    return  BlocConsumer<CarCubit,CarStates>(
      listener: (context, state) {
        if (state is CarUpdateErrorState) {
          Helpers.errorSnackbar(message: state.message);
        }else if (state is CarUpdatedState) {
          Get.offNamed(Routes.home);
        }
      },
      builder: (context, state) {
        if( state is CarUpdateLoadingState){
          return const Scaffold(
            body:  Center(child: CircularProgressIndicator())
          );
        }
      return  Scaffold(
      appBar: AppBar(
        title: Text(nameController.text)
      ),
      body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child:  Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                height: 150,
                padding: const EdgeInsets.all(8),
                child: Image.asset('images/car.png', fit: BoxFit.fill),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Helpers.formField(controller: nameController, hint: 'Name',readOnly: !isEditMode),
                  const SizedBox(height: 10,),
                  Helpers.formField(controller: modelController, hint: 'Model',readOnly: !isEditMode),
                  const SizedBox(height: 10,),
                  TextFormField(
                    controller: priceController,
                    readOnly: !isEditMode,
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
                  const SizedBox(height: 20,),
                  isEditMode ? 
                     MaterialButton(
                      onPressed: (){
                        if (formKey.currentState!.validate()) {
                            cubit.updateCar(
                              widget.model.id ?? '',
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
                      child: const  Text("Save changes",style:  TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
                    ):
                    MaterialButton(
                      onPressed: (){
                        setState(() {
                          widget.mode = CarModeEnum.edit;
                        });
                      },
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      minWidth: double.infinity,
                      color: const Color(0xff2d4569),
                      child: const  Text("Edit",style:  TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
                
                    )
                
                ],
              ),
            ],
          ),
        ),
      ),
    )
    );});
    
  }
}