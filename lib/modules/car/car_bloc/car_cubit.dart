import 'dart:convert';
import 'package:car_agency_flutter/helpers/helpers.dart';
import 'package:car_agency_flutter/models/car_model.dart';
import 'package:car_agency_flutter/modules/car/car_bloc/car_states.dart';
import 'package:car_agency_flutter/modules/layout/layout_bloc/layout_cubit.dart';
import 'package:car_agency_flutter/shared/network/dio_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';


class CarCubit extends  Cubit<CarStates> {
  final DioService _dio = DioService();
  CarCubit() : super(CarInitialState());


  void createNewCar(CarModel model) async {
    emit(CarCreationLoadingState());
    try {
      var response = await _dio.post('${Helpers.carsServiceApi()}/cars', model.toJson());
      if (response.statusCode  == 200) {
        emit(CarCreatedState());
      } else {
        emit(CarCreationErrorState(response.data['message']));
      }
    } on DioException catch (e) {
      emit(CarCreationErrorState(e.response?.data['message']));
    }
  }
  static void sendCarStatusNotification(PusherEvent event)  {
    final data = event.data; 
    final Map<String, dynamic> parsedData = json.decode(data);

    final String carName = parsedData['car']['name'];
    final String actionStatus = parsedData['action_status'];
    if(actionStatus == 'deleted') {
      Helpers.errorSnackbar(message:   "$carName has been $actionStatus");
    } else {
      Helpers.successSnackbar(message:   "$carName has been $actionStatus");
    }
    // Get.put(LayoutCubit()).loadCarsData();
 }
}