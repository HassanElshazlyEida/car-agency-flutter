import 'package:car_agency_flutter/helpers/helpers.dart';
import 'package:car_agency_flutter/models/user_model.dart';
import 'package:car_agency_flutter/modules/auth/auth_bloc/auth_states.dart';
import 'package:car_agency_flutter/shared/network/cache_network.dart';
import 'package:car_agency_flutter/shared/network/dio_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends  Cubit<AuthStates> {
  final DioService _dio = DioService();
  AuthCubit() : super(AuthInitialState());
  UserModel? userModel;

  void register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String passwordConfirmation
    }) async {
    await _authenticate('register', {
      'email': email,
      'name': name,
      'phone': phone,
      'password': password,
      "password_confirmation": passwordConfirmation
    });
  }

  void login({required String login, required String password}) async {
    await _authenticate('login', {
      'login': login,
      'password': password,
    });
  }
  Future<void> _authenticate(String endpoint, Map<String, String> body) async {
    emit(AuthLoadingState());
    try {
      final response = await _dio.post('${Helpers.usersServiceApi()}/$endpoint',body);

      if (response.statusCode  == 200) {
        await CacheNetwork.setCache('token', response.data['data']['access_token']);
        userModel = UserModel.fromJson(response.data['data']['user']);
        
        emit(AuthAuthenticatedState());
      } else {
        emit(AuthErrorState(response.data['message']));
      }
    } on DioException catch (e) {
      emit(AuthErrorState(e.response?.data['message']));
    }
  }
  void loadUserData() async {
    print("userssss");
    emit(LoadingUserDataState());
    try {
      var response = await _dio.get('${Helpers.usersServiceApi()}/user');
        if (response.statusCode  == 200) {
        userModel = UserModel.fromJson(response.data['data']);
        emit(SuccessUserDataState());
      } else {
        emit(ErrorUserDataState(response.data['message']));
      }
    }on DioException catch (e) {
      emit(AuthErrorState(e.response?.data['message']));
    }
  }
 
}