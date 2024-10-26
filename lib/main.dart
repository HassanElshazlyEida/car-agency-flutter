import 'package:car_agency_flutter/helpers/helpers.dart';
import 'package:car_agency_flutter/modules/auth/auth_cubit.dart';
import 'package:car_agency_flutter/screen/login_screen.dart';
import 'package:car_agency_flutter/screen/register_screen.dart';
import 'package:car_agency_flutter/shared/bloc/global_bloc_observer.dart';
import 'package:car_agency_flutter/shared/network/cache_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = GlobalBlocObserver();

  await dotenv.load(fileName: ".env");
  await CacheNetwork.init();

  print('test');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
      ],
      child:  const MaterialApp(
      title: 'Flutter Demo',
      home: LoginScreen()
      )
    );
  }
}
