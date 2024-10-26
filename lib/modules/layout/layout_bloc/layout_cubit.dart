import 'package:car_agency_flutter/helpers/helpers.dart';
import 'package:car_agency_flutter/models/car_model.dart';
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

  List<CarModel> cars = [];
  void loadCarsData() async {
    print("carsss");
    emit(LoadingCarsDataState());
    try {
      var response = await _dio.get('${Helpers.carsServiceApi()}/cars');
      if (response.statusCode  == 200) {
        cars = (response.data['data']['data'] as List).map((e) => CarModel.fromJson(e)).toList();
        emit(SuccessCarsDataState());
      } else {
        emit(ErrorCarsDataState(response.data['message']));
      }
    } catch (e) {
      print(e);
      emit(ErrorCarsDataState('Unknown error occurred'));
    }
  }
  List<CarModel> filteredCars = [];
  void filteredCarsList(String text) {
    print("filter");
    filteredCars = cars.where((element) => element.name!.contains(text)).toList();
    emit(LoadingCarsListState());
  }
 
  
}