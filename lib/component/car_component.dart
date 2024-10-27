import 'package:car_agency_flutter/models/car_model.dart';
import 'package:car_agency_flutter/modules/layout/layout_bloc/layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarComponent extends StatefulWidget {
  final LayoutCubit cubit;
  final CarModel model;

  const CarComponent({super.key, required this.cubit, required this.model});

  @override
  State<CarComponent> createState() => _CarComponentState();
}

class _CarComponentState extends State<CarComponent> {
  @override
  Widget build(BuildContext context) {
    var model = widget.model;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:  Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 3,
                offset: Offset(0, 1),
              )
            ]
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
          child: Column(
            children: [
              Container(
                height: 100,
                padding: const EdgeInsets.all(8),
                child: Image.asset('images/car.png',fit: BoxFit.fill),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
               
                  Text(model.name!,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),),
                  Text("(${model.model!})",maxLines: 2, style: const TextStyle(fontSize: 13,color: Colors.grey,overflow: TextOverflow.ellipsis),),
                  const SizedBox(height: 7,),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('\$${model.price!} ',style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                            TextButton(
                              onPressed: () {
                              
                              },
                              style: TextButton.styleFrom(
                                minimumSize: const Size(40, 40),
                                backgroundColor: Colors.black, 
                                padding: EdgeInsets.zero,
                                shadowColor: Colors.black,
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4), 
                                ),
                              ),
                              child: const Icon(
                              Icons.arrow_right_alt,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          
                          ],
                        ),
                        const SizedBox(width: 5,),
                      
                      ],
                    ),                  
                  
                ],
              ),
            ],
          ),
        ));
  }
}