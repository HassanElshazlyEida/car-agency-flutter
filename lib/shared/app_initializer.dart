
import 'package:car_agency_flutter/modules/auth/auth_bloc/auth_cubit.dart';
import 'package:car_agency_flutter/modules/layout/layout_bloc/layout_cubit.dart';
import 'package:car_agency_flutter/shared/bloc/global_bloc_observer.dart';
import 'package:car_agency_flutter/shared/network/cache_network.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class AppInitializer {
  AppInitializer._();

  static Future<void> initialize() async {
    await _loadEnv();
    await _initCache();
    _initBlocObserver();
    _getLoadDependencies();
  }

  static Future<void> _loadEnv() async {
    await dotenv.load(fileName: ".env");
  }

  static Future<void> _initCache() async {
    await CacheNetwork.init();
  }

  static void _initBlocObserver() {
    Bloc.observer = GlobalBlocObserver();
  }
  static void _getLoadDependencies() {
    Get.lazyPut<LayoutCubit>(() => LayoutCubit());
    Get.lazyPut<AuthCubit>(() => AuthCubit());
  }
}