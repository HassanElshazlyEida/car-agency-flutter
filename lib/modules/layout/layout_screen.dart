import 'package:car_agency_flutter/modules/layout/layout_bloc/layout_cubit.dart';
import 'package:car_agency_flutter/modules/layout/layout_bloc/layout_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    
    return BlocBuilder<LayoutCubit, LayoutStates>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Image.asset('images/logo.png', height: 75, width: 75),
          ),
          body: cubit.screens[cubit.bottomNavIndex],
          backgroundColor: Colors.grey[200],
          bottomNavigationBar:
            BottomNavigationBar(onTap: (value) {
              cubit.changeBottomNavIndex(value);
            },
            currentIndex: cubit.bottomNavIndex, 
            selectedItemColor: const  Color(0xff2d4569),
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                  icon:  Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon:  Icon(Icons.person), label: 'Profile'),
            ]
            ),
        );
      },
    );
  }
}
