
import 'package:car_agency_flutter/shared/network/cache_network.dart';

class UserRepository {
  static bool isAuthenticated() {
    print(CacheNetwork.getCache('token'));
    if(CacheNetwork.getCache('token') !=null){
      return true;
    }
    return false;
  }
  static void logout() {
    CacheNetwork.removeCache('token');
  }


}