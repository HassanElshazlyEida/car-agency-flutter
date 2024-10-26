import 'package:car_agency_flutter/modules/layout/layout_bloc/layout_states.dart';
import 'package:car_agency_flutter/screen/home_screen.dart';
import 'package:car_agency_flutter/screen/profile_screen.dart';
import 'package:car_agency_flutter/shared/network/dio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitialState());

  final DioService _dio = DioService();

  List<Widget> screens =[const HomeScreen(), const ProfileScreen()];

  int bottomNavIndex = 0;
  void changeBottomNavIndex(int index) {
    bottomNavIndex = index;
    emit(ChangeBottomNavIndexState());
  }
  
}