import 'package:car_agency_flutter/modules/auth/auth_bloc/auth_cubit.dart';
import 'package:car_agency_flutter/modules/layout/layout_bloc/layout_cubit.dart';
import 'package:car_agency_flutter/routes/routes.dart';
import 'package:car_agency_flutter/shared/app_Initializer.dart';
import 'package:car_agency_flutter/shared/network/cache_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppInitializer.initialize();
  // CacheNetwork.clearCache();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
   return  MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()..loadUserData()),
      ],
      child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.grey[100], 
          ),
          darkTheme: ThemeData.light(),
          initialRoute: Routes.home,
          getPages: AppPages.pages,
        )
    );
  }
}
