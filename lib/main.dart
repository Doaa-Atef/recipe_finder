import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app.dart';
import 'core/dependency_injection/di.dart';
import 'core/network/network_services.dart';
import 'core/shared_prefs/shared_prefs.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  print('API_KEY: ${dotenv.env['API_KEY']}');
  await SharedPrefs.init();
  await Firebase.initializeApp();
  NetworkServices.init();
  await setupGetIt();
  runApp(
    ScreenUtilInit(
      designSize: Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => const MyApp(),
    ),
  );
}
