import 'package:car_agency_flutter/component/car_component.dart';
import 'package:car_agency_flutter/modules/layout/layout_bloc/layout_cubit.dart';
import 'package:car_agency_flutter/modules/layout/layout_bloc/layout_states.dart';
import 'package:car_agency_flutter/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
 
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {
         if (state is ErrorCarsDataState) {
            Get.toNamed(Routes.home);
            Get.snackbar('Error', state.message);
         }
      },
      builder: (context, state) {

        final cubit = BlocProvider.of<LayoutCubit>(context); 
        return  Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                  const SizedBox(height: 10,),
                    TextFormField(
                    controller: searchController,
                    onChanged: (value) {
                      cubit.filteredCarsList(value);
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white ,
                      filled: true,
                      hintText: 'Find any car..',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon:IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          searchController.clear();
                          cubit.filteredCarsList('');
                        },
                      ),
                      contentPadding: const EdgeInsets.all(0),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white), // Set enabled border color
                        ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                (cubit.cars.isNotEmpty)?GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                    childAspectRatio: 0.85,
                    
                  ),
                  itemCount: cubit.filteredCars.isEmpty? cubit.cars.length : cubit.filteredCars.length,
                  itemBuilder: (context, index) {
                    return CarComponent(
                      model:cubit.filteredCars.isEmpty? cubit.cars[index] : cubit.filteredCars[index],
                      cubit: cubit,
                    );
                  },
                ):
                const Center(child: CupertinoActivityIndicator(),)
              ]
          ))
        );
      }
  );
  }
}