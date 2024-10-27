import 'package:car_agency_flutter/routes/routes.dart';
import 'package:car_agency_flutter/shared/network/cache_network.dart';
import 'package:dio/dio.dart';
import 'package:get/route_manager.dart';

class DioService {
  final Dio dio = Dio(BaseOptions(
   
  ));


  DioService() {
    _initializeInterceptors();
  }

  void _initializeInterceptors() {
    dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler)  {
        options.headers['Accept'] = 'application/json';
        String? token =  CacheNetwork.getCache('token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        if (response.statusCode == 401) {
          CacheNetwork.removeCache('token');
          Get.toNamed(Routes.login);
        }
        
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        if (e.response?.statusCode == 401) {
          CacheNetwork.removeCache('token');
          Get.toNamed(Routes.login);
        }
        return handler.next(e);
      },
    ));
  }

  Future<Response> post(String endpoint, Map<String, dynamic> body) async {
    return await dio.post(
      endpoint,
      data: body,
    );
  }

  Future<Response> get(String endpoint) async {
    return await dio.get(
      endpoint,
    );
  }
  Future<Response> patch(String endpoint, Map<String, dynamic> body) async {
    return await dio.patch(
      endpoint,
      data: body,
    );
  }
  Future<Response> delete(String endpoint) async {
    return await dio.delete(
      endpoint,
    );
  }
}