import 'package:car_agency_flutter/shared/bloc/global_bloc_observer.dart';
import 'package:car_agency_flutter/shared/network/cache_network.dart';
import 'package:car_agency_flutter/shared/network/pusher/pusher_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


class AppInitializer {
  AppInitializer._();

  static Future<void> initialize() async {
    await _loadEnv();
    await _initCache();
    await _initPusherWebsocket();
    _initBlocObserver();

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
  static Future<void>  _initPusherWebsocket() async{
    PusherServices().initPusher(dotenv.env['PUSHER_CHANNEL'] ?? '');
  }


}