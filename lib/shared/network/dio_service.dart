import 'package:car_agency_flutter/shared/network/cache_network.dart';
import 'package:dio/dio.dart';

class DioService {
  final Dio dio = Dio(BaseOptions());


  DioService() {
    _initializeInterceptors();
  }

  void _initializeInterceptors() {
    dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler)  {
        String? token =  CacheNetwork.getCache('token');
        if (token != null) {
          options.headers['Authorization'] = token;
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        if (response.statusCode == 401) {
          CacheNetwork.removeCache('token');
        }
        
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        if (e.response?.statusCode == 401) {
          CacheNetwork.removeCache('token');
        }
        return handler.next(e);
      },
    ));
  }

  Future<Response> post(String endpoint, Map<String, String> body) async {
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
}